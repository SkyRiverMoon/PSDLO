import datetime
import random
from operator import itemgetter
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
from sklearn import preprocessing
import tensorflow as tf
from tensorflow import keras
from tensorflow.keras import layers
import socket
import struct

class Gene: 
    def __init__(self, **data):
        self.__dict__.update(data)
        self.size = len(data['data'])

class GA:
# 遗传算法的类
    def __init__(self, parameter):
        self.parameter = parameter

        low = self.parameter[4]
        up = self.parameter[5]

        self.bound = []
        self.bound.append(low)
        self.bound.append(up)
        
        pop = []
        for i in range(self.parameter[3]):
            geneinfo = []
            for pos in range(len(low)):
                geneinfo.append(random.uniform(self.bound[0][pos], self.bound[1][pos]))
            fitness = self.evaluate(geneinfo)
            pop.append({'Gene': Gene(data=geneinfo), 'fitness': fitness})
        self.pop = pop
        self.bestindividual = self.selectBest(self.pop)

    def evaluate(self, geneinfo):    
        x=np.array(geneinfo)
        x=x.reshape(1,4)
        y=model.predict(x,verbose=0)
        return y
    
    def selectBest(self, pop):
        self.pop=sorted(pop,key=itemgetter("fitness"),reverse=True)
        Pre_pop=[]
        
        ###### Physical sppervision 5 times ######
        n=5
        for i in range(n):
            x=[]
            for j in range(len(low)):
                x.append(self.pop[i]['Gene'].data[j])
            z=scaler.inverse_transform(np.array([x]))
            send_data=str(z)
            print("Passed to MATLAB: ")
            print(send_data)
            udp_sock.sendto(send_data.encode('ascii'),("127.0.0.1",3031))
            recv=udp_sock.recvfrom(256)
            Comsol=struct.unpack('d', recv[0])[0]
            print("COMSOL结果: ",Comsol)

            self.pop[i]['fitness']=Comsol  
            Pre_pop.append(self.pop[i])
        Ult_pop=sorted(Pre_pop,key=itemgetter("fitness"),reverse=True)
        
        for i in range(n):
            self.pop[i]=Ult_pop[i]
            
        return self.pop[0]

    def selection(self, individuals, k):
        s_inds = sorted(individuals, key=itemgetter("fitness"), reverse=True)
        sum_fits = sum(ind['fitness'] for ind in individuals)
        chosen = []
        for i in range(k):
            u=random.random()*sum_fits
            sum_=0
            for ind in s_inds:
                sum_+=ind['fitness']
                if sum_ >= u:
                    chosen.append(ind)
                    break
        chosen = sorted(chosen, key=itemgetter("fitness"), reverse=False)
        return chosen

    def crossoperate(self, offspring):
        dim = len(offspring[0]['Gene'].data)

        geninfo1 = offspring[0]['Gene'].data
        geninfo2 = offspring[1]['Gene'].data  

        if dim == 1:
            pos1 = 1
            pos2 = 1
        else:
            pos1 = random.randrange(1, dim)
            pos2 = random.randrange(1, dim)
        newoff1 = Gene(data=[])
        newoff2 = Gene(data=[])
        temp1 = []
        temp2 = []
        for i in range(dim):
            if min(pos1, pos2) <= i < max(pos1, pos2):
                temp2.append(geninfo2[i])
                temp1.append(geninfo1[i])
            else:
                temp2.append(geninfo1[i])
                temp1.append(geninfo2[i])
        newoff1.data = temp1
        newoff2.data = temp2

        return newoff1, newoff2

    def mutation(self, crossoff, bound):
        dim = len(crossoff.data)

        if dim == 1:
            pos = 0
        else:
            pos = random.randrange(0, dim)
        crossoff.data[pos] = random.uniform(bound[0][pos], bound[1][pos])
        return crossoff

    def GA_main(self):
        popsize = self.parameter[3]
        print("Start to evolve")
        
        for g in range(NGEN):
            print('\n')
            print("--------Generation {}--------".format(g))
            selectpop = self.selection(self.pop, popsize)
            nextoff = []
            while len(nextoff)!=popsize:
                offspring = [selectpop.pop() for _ in range(2)]
                if random.random() < CXPB:
                    crossoff1, crossoff2 = self.crossoperate(offspring)
                    if random.random() < MUTPB:
                        muteoff1 = self.mutation(crossoff1, self.bound)
                        muteoff2 = self.mutation(crossoff2, self.bound)
                        fit_muteoff1 = self.evaluate(muteoff1.data)
                        fit_muteoff2 = self.evaluate(muteoff2.data)
                        nextoff.append({'Gene': muteoff1, 'fitness': fit_muteoff1})
                        nextoff.append({'Gene': muteoff2, 'fitness': fit_muteoff2})
                    else:
                        fit_crossoff1 = self.evaluate(crossoff1.data)
                        fit_crossoff2 = self.evaluate(crossoff2.data)
                        nextoff.append({'Gene': crossoff1, 'fitness': fit_crossoff1})
                        nextoff.append({'Gene': crossoff2, 'fitness': fit_crossoff2})
                else:
                    nextoff.extend(offspring)

            self.pop = nextoff
            
            best_ind = self.selectBest(self.pop)
            if best_ind['fitness'] > self.bestindividual['fitness']:
                self.bestindividual = best_ind
            Iterations[g,0]=g
            Iterations[g,1]=self.bestindividual['fitness']
            Iterations[g,2:]=self.bestindividual['Gene'].data[:]
            
            print("Optimal individual: {}".format(self.bestindividual['Gene'].data))
            print("Maximum fitness: {}".format(self.bestindividual['fitness']))
            print("Maximum of the current population：{}".format(best_ind['fitness']))
        print("--------End evolution--------")

if __name__ == "__main__":

    udp_sock=socket.socket(socket.AF_INET,socket.SOCK_DGRAM)
    udp_sock.bind(('',3030))
    
    data=pd.read_csv('Data.csv')
    data_features=np.array(data[['1','2','3','4']])
    scaler=preprocessing.StandardScaler().fit(data_features)
    data_features_normalize=scaler.transform(data_features)
    
    np.set_printoptions(precision=2)
    np.set_printoptions(suppress=True)
    CXPB,MUTPB,NGEN,popsize=0.9,0.2,50+1,200
    
    low=scaler.transform(np.array([[ 1, 1,20, 1]])).flatten()
    up =scaler.transform(np.array([[ 5, 5,50,10]])).flatten()
    
    parameter=[CXPB, MUTPB, NGEN, popsize, low, up] 
    model=keras.models.load_model('NN.h5')
    Iterations=np.zeros((NGEN,2+len(up)))

    starttime = datetime.datetime.now()
    run=GA(parameter)
    run.GA_main()
    
    endtime = datetime.datetime.now()
    print("Total time spent")
    print(endtime-starttime)
    
    b=scaler.inverse_transform([Iterations[NGEN-1,2:]])
    
    plt.rcParams['xtick.direction']='in'
    plt.rcParams['ytick.direction']='in'
    ax = plt.figure(figsize = (4,4)).add_subplot(111)
    ax.plot(Iterations[:,0],Iterations[:,1],'o--',markersize='2',linewidth=1,color=(0,73/255,144/255))

    ax.set_ylabel(r'Maximum Fitness',fontsize=14)   
    ax.set_xlabel(r'Number of Iterations',fontsize=14)
    
    y_max=max(Iterations[:,1])
    y_min=min(Iterations[:,1])
    ax.set_ylim(y_min*0.999,y_max*1.001)
    ax.set_xlim(0,NGEN-1)
    
    ax.plot([0,NGEN],[y_max,y_max],linewidth=1,ls='--',color = 'darkred')
    
    plt.savefig('GA',dpi=1000,bbox_inches='tight')
    np.savetxt('GA.csv',Iterations,delimiter=',')
    np.savetxt('Best.csv',b,delimiter=',')
    udp_sock.close()
