import datetime
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.font_manager as font_manager
import pandas as pd
import tensorflow as tf
from tensorflow import keras
from tensorflow.keras import layers
from sklearn import preprocessing
import warnings
warnings.filterwarnings("ignore")

starttime = datetime.datetime.now()
data=pd.read_csv('Data.csv')

print(data.head())
print('Data dimension:',data.shape)

amplification_factor=20
data_labels=(np.array(data[['F2/F1']]))*amplification_factor
data_features=np.array(data[['1','2','3','4']])

def normalize(array):
    mx = np.nanmax(array)
    mn = np.nanmin(array)
    t = (array-mn)/(mx-mn)
    return t

scaler=preprocessing.StandardScaler().fit(data_features)
data_features_normalize=scaler.transform(data_features)

data_labels_normalize=normalize(data_labels)

n_test=1000
index_test=np.random.choice(data_labels.shape[0],n_test,replace=False)
data_test_features=data_features_normalize[index_test]
data_test_labels=data_labels[index_test]

index_train=np.arange(data_labels.shape[0])
index_train=np.delete(index_train,index_test)
data_train_features=data_features_normalize[index_train]
data_train_labels=data_labels[index_train]

model=tf.keras.Sequential()

model.add(layers.Dense(16,activation='relu',bias_initializer='random_normal',
                       kernel_regularizer=tf.keras.regularizers.l2(0.03)))
model.add(layers.Dense(32,activation='relu',bias_initializer='random_normal',
                        kernel_regularizer=tf.keras.regularizers.l2(0.03)))
model.add(layers.Dense(64,activation='relu',bias_initializer='random_normal',
                        kernel_regularizer=tf.keras.regularizers.l2(0.03)))
model.add(layers.Dense(128,activation='relu',bias_initializer='random_normal',
                        kernel_regularizer=tf.keras.regularizers.l2(0.03)))
model.add(layers.Dense(256,activation='relu',bias_initializer='random_normal',
                        kernel_regularizer=tf.keras.regularizers.l2(0.03)))

model.add(layers.Dense(1,activation='relu',bias_initializer='random_normal',
                        kernel_regularizer=tf.keras.regularizers.l2(0.03)))

def custom_loss(y_actual,y_pred):
    custom_loss=((y_actual-y_pred)**2)*(y_actual)**0
    return custom_loss

model.compile(optimizer=tf.keras.optimizers.Adam(learning_rate=0.001),
              loss='MeanSquaredError',
              metrics=['accuracy'])
model.fit(data_train_features,data_train_labels,epochs=10000,batch_size=1024)

endtime = datetime.datetime.now()
print('')
print("Total time spent: ")
print(endtime-starttime)

print('')
print('------Model summary------')
model.summary()
data_train_predict=model.predict(data_train_features)/amplification_factor
data_test_predict=model.predict(data_test_features)/amplification_factor
model.save('NN.h5')

print('')
print('------Training set------')
print('')
print('Maximum value: ',np.max(data_labels)/amplification_factor)
print('Position: ',np.argmax(data_labels))
print('')
print('Minimum value: ',np.min(data_labels)/amplification_factor)
print('Position: ',np.argmin(data_labels))

print('')
print('------Predict value------')
print('')
print('Maximum value: ',np.max(data_train_predict))
print('Position: ',np.argmax(data_train_predict))
print('')
print('Minimum value: ',np.min(data_train_predict))
print('Position: ',np.argmin(data_train_predict))

SSR=sum((data_test_predict-data_test_labels/amplification_factor)**2)
SST=sum((np.mean(data_test_labels/amplification_factor)-data_test_labels/amplification_factor)**2)
R_2=1-SSR/SST
print('')
print('------R^2------')
print(R^2)

plt.rcParams['xtick.direction']='in'
plt.rcParams['ytick.direction']='in'

fig=plt.figure(figsize=(4.2,4))

ax=fig.add_subplot(1,1,1)
ax_max=np.max(data_labels)/amplification_factor
ax_min=np.min(data_labels)/amplification_factor

x=np.array([ax_min,ax_max])
y1=x+(ax_max-ax_min)*0.1
y2=x-(ax_max-ax_min)*0.1
plt.fill_between(x,y1,y2,color='#3b6f7c',alpha=0.1)

ax.set_xlim(ax_min,ax_max)
ax.set_ylim(ax_min,ax_max)
ax.set_xlabel(r'$|F_2/F_1|$ by FEM',fontsize=14)
ax.set_ylabel(r'$|F_2/F_1|$ by NN',fontsize=14)

ax.plot(data_train_labels/amplification_factor,data_train_predict,'o',markersize='3',
        color='#8b5357',label='Training',alpha=1)
ax.plot(data_test_labels/amplification_factor,data_test_predict,'o',markersize='3',
        color='#123b57',label='Test',alpha=1)
ax.plot([ax_min,ax_max],[ax_min,ax_max],linewidth=0.5,ls='--',color='#8b5357',alpha=1)

plt.legend(loc='lower right',markerscale=2,frameon=False,handletextpad=0,borderaxespad=0,
           prop=font_manager.FontProperties(size=14))
fig.tight_layout() 
plt.savefig('NN',dpi=1000)
