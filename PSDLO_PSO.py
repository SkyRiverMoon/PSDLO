import random
import numpy as np
import matplotlib.pyplot as plt
import datetime
from tensorflow import keras
import pandas as pd
from sklearn import preprocessing
import socket
import struct

class PSO:
    def __init__(self, dimension, time, size, low, up, v_low, v_high):
        self.dimension = dimension  
        self.time = time
        self.size = size 
        self.bound = []
        self.bound.append(low)
        self.bound.append(up)
        self.v_low = v_low
        self.v_high = v_high
        self.x = np.zeros((self.size, self.dimension))
        self.v = np.zeros((self.size, self.dimension))
        self.p_best = np.zeros((self.size, self.dimension))
        self.g_best = np.zeros((1, self.dimension))[0]

        temp = -100000000
        for i in range(self.size):
            for j in range(self.dimension):
                self.x[i][j] = random.uniform(self.bound[0][j], self.bound[1][j])
                self.v[i][j] = random.uniform(self.v_low, self.v_high)
            self.p_best[i] = self.x[i]
            fit = self.fitness(self.p_best[i])
            if fit > temp:
                self.g_best = self.p_best[i]
                temp = fit

    def fitness(self, x):
        x=np.array(x)
        x=x.reshape(1,4)
        y=model.predict(x,verbose=0)
        return y

    def update(self, size):
        c1 = 2.0
        c2 = 2.0
        w = 0.8
        global generation
        
        for i in range(size):
            self.v[i]=(w*self.v[i]
                       +c1*random.uniform(0,1)*(self.p_best[i]-self.x[i])
                       +c2*random.uniform(0,1)*(self.g_best-self.x[i]))
            for j in range(self.dimension):
                if self.v[i][j] < self.v_low:
                    self.v[i][j] = self.v_low
                if self.v[i][j] > self.v_high:
                    self.v[i][j] = self.v_high
            self.x[i] = self.x[i] + self.v[i]
            for j in range(self.dimension):
                if self.x[i][j] < self.bound[0][j]:
                    self.x[i][j] = self.bound[0][j]
                if self.x[i][j] > self.bound[1][j]:
                    self.x[i][j] = self.bound[1][j]
            generation[i,0]=i
            generation[i,1]=self.fitness(self.x[i])
        generation=np.array(sorted(generation,key=lambda x:x[1],reverse=True))
        
        ###### Physics supervise ######
        for i in range(5):
            send_data=str(scaler.inverse_transform([self.x[int(generation[i,0])]]))
            print("Send to MATLAB：")
            print(send_data)
            udp_sock.sendto(send_data.encode('ascii'),("127.0.0.1",3031))
            recv=udp_sock.recvfrom(256)
            comsol=struct.unpack('d', recv[0])[0]
            print("COMSOL result: ",comsol)
            generation[i,1]=comsol
            
        for i in range(5):
            if generation[i,1]>generation[i,2]:
                generation[i,2]=generation[i,1]
                self.p_best[int(generation[i,0])]=self.x[int(generation[i,0])]
            if generation[i,1]>generation[0,3]:
                generation[:,3]=generation[i,1]
                self.g_best=self.x[int(generation[i,0])]

    def pso(self):
        best = []
        self.final_best = low
        fitness_final_best=self.fitness(self.final_best)
        
        for gen in range(self.time):
            print('\n')
            print("--------Generation {}--------".format(gen))
            self.update(self.size)
            if generation[0,3]>fitness_final_best:
                fitness_final_best=generation[0,3]
                self.final_best = self.g_best.copy()
            a=scaler.inverse_transform([self.final_best])
            print('Current best position: {}'.format(a))
            
            temp=fitness_final_best
            print('Current best fitness: {}'.format(temp))
            best.append(temp)
        np.savetxt('PSO.csv',best,delimiter=',')
        plt.rcParams['xtick.direction']='in'
        plt.rcParams['ytick.direction']='in'
        ax = plt.figure(figsize = (4,4)).add_subplot(111)
        t = [i for i in range(self.time)]
        ax.plot(t, best, color='#123b57', marker='.', ms=9)
        ax.set_xlabel(u"Generation")
        ax.set_ylabel(u"Fitness Function")
        plt.savefig('PSO',dpi=1000,bbox_inches='tight')
        
udp_sock=socket.socket(socket.AF_INET,socket.SOCK_DGRAM)
udp_sock.bind(('',3030))
np.set_printoptions(precision=2)
np.set_printoptions(suppress=True)

time = 1+50
size = 200
dimension = 4
v_low = -1
v_high = 1

data=pd.read_csv('Data.csv')
data_features=np.array(data[['1','2','3','4']])
scaler=preprocessing.StandardScaler().fit(data_features)
data_features_normalize=scaler.transform(data_features)

low=scaler.transform(np.array([[ 1, 1,20, 1]])).flatten()
up =scaler.transform(np.array([[ 5, 5,50,10]])).flatten()

model=keras.models.load_model('NN.h5')
generation=np.zeros((size,4))

starttime = datetime.datetime.now()
pso = PSO(dimension, time, size, low, up, v_low, v_high)
pso.pso()

endtime = datetime.datetime.now()
print("Total time spent: ")
print(endtime-starttime)
