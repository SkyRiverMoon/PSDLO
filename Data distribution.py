import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

Data=pd.read_csv('Data.csv')
labels=np.array(Data['F2/F1'])

n=50
y=np.zeros(n)

data_min=0
data_max=0.8
data_space=(data_max-data_min)/n

for i in range(len(labels)):
    for j in range(n):
        if (data_min+j*data_space)<labels[i]<=(data_min+(j+1)*data_space):
            y[j]=y[j]+1

x=data_min+(np.arange(n)+0.5)*data_space

plt.rcParams['xtick.direction']='in'
plt.rcParams['ytick.direction']='in'

ax=plt.figure(figsize=(2.9,2.9)).add_subplot(111)
ax.bar(x,y,width=0.9*data_space,color='#3b6f7c')

###### Cut_off ######
data_mean=sum(labels)/sum(y)
cut_off=(data_mean+data_max)/2
# plt.fill_betweenx([0,max(y)*1.02],[cut_off,cut_off],[data_max,data_max],color='#8b5357',alpha=0.1)
# ax.plot([cut_off,cut_off],[0,max(y)*1.02],linewidth=2,ls='--',color='#8b5357')

ax.set_ylabel(r'Counts',fontsize=11)   
ax.set_xlabel(r'$|F_2/F_1$|',fontsize=11)

ax.set_ylim(0,59)
ax.set_xlim(0,0.8)

plt.savefig('Data',dpi=1000,bbox_inches='tight')

print('Total: ',len(labels))
print('Minimum：',data_min)
print('Maxmum：',data_max)
print('Mean：',data_mean)
print('Cut-off:',cut_off)
