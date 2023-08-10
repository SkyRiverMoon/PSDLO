![image](https://github.com/SkyRiverMoon/PSDLO/blob/main/Figure/1.png)
# Physics-supervised Deep Learning–based Optimization (PSDLO) with Accuracy and Efficiency
![image](https://github.com/SkyRiverMoon/PSDLO/blob/main/Figure/2.png)

1. PSDLO_GA.py and PSDLO_PSO.py are the main codes for the PSDLO, based on Genetic Algorithm (GA) and Particle Swarm Optimization (PSO), respectively.

2. NN.py is the code for training the neural network using Tensorflow (v2.11.0).

3. PSDLO to MATLAB.m is the communication file between Python and MATLAB. It needs to be opened before running the main PSDLO code.

4. Model.m is a COMSOL LiveLink™ file for MATLAB.

5. Data.csv contains the training and testing sets. In the main PSDLO code, the test set is randomly selected, comprising 10% of the total points.

6. Data distribution.py can display the distribution, maximum, and minimum of the data set.

Overall workflow of iterative evolution of PSDLO method. Icons represent different components: the function graph symbolizes the NN, the gene icon represents the GA, and the atom icon denotes physics.

![image](https://github.com/SkyRiverMoon/PSDLO/blob/main/Figure/3.png#pic_center)
