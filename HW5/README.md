# HW4

## Requirement

Matlab 2015b (verified)



## Tutorial

#### Basic Module

-QL.m: A MATLAB Function that transform a quaternion into left skew matrix

Input: quaternion q (1*4 or 4*1)

Output: Skew Matrix(4*4)



-QR.m: A MATLAB Function that transform a quaternion into right skew matrix

Input: quaternion q (1* 4 or 4 *1)

Output: Skew Matrix(4 * 4)



-skew.m: A MATLAB Function that transform a 3-dimension vector into skew matrix

Input: vector x(1 * 3 or 3 * 1)

Output: Skew Matrix(3 * 3)



-target.m : A MATLAB Function that calculate the sum of square error

Input: Rotation Matrix R (3 * 3)

​	    Point set X (3 * n) 

​            Point set Y (3* n)

Output: $\sum_{i=1}^{n}(Rx_i-y_i)^2$



-q2r.m: A MATLAB Function that transform a quaternion into Rotation Matrix

Input: quaternion q( 4 * 1 or 1 * 4)

Output: Rotation Matrix (3 * 3)



-Qmult.m: A MATLAB Function that apply multiplication on two quaternion and return the result.

Input: quaternion q1,q2 (4 * 1 or 1 * 4)

Output: quaternion q



-DLT.m: A MATLAB Function that use Direct Linear Transform Method  to calculate the Rotation Matrix given point set X and point set Y

Input: Point set X (3 * n)

​	    Point set Y (3 * n)

Output: Rotation Matrix R (3 * 3)

​	       Sum of square error 



-QDLT.m: A MATLAB Function that use Absolute Orientation Method to  calculate the Rotation quaternion given point set X and Y

Input: Point set X (3 * n)

​	    Point set Y (3 * n)

Output: Rotation quaternion (4 * 1)

​	       Sum of square error 

-Gauss_Newton.m: A MATLAB Function that use Gauss Newton method to calculate the Rotation Matrix given point set X and Y

Input: Point set X (3 * n)

​	    Point set Y (3 * n)

​	    Iteration number m

Output: Rotation Matrix R (3 * 3)

​	       Sum of square error 



-findNeibor.m: A MATLAB Function that use KNN algorithm to find the nearest neighbor of source point cloud on destination point cloud

Input: Source Point Cloud X

 	    Destination Point Cloud Y

Output: 

​	   dis: Euclidean Distance between X and its neighbor

​            index: index of Y that is nearest to X



-solveTransform: A MATLAB Function that solve the transformation matrix based on gauss newton/ direct linear transform/ absolute orientation method

Input: Source Point Cloud X

​	    Destination Point Cloud Y

​	    Method: 1->Gauss Newton 2->Direct Linear Transform 3->Absolute Orientation

Output:

​	    R: Rotation Matrix

 	    t: translation vector	    



#### Test Program

Main.m:

You can run the script directly. To modify some the loaded data, method, try as the following tutorial.

 

To load your data, change the load function input as your data direction

~~~matlab
%% load data
data = load('./data/icp_xy.mat');
X = data.x;
Y = data.y;
X_i = X;
~~~

To use different method to solve the transformation matrix:

method = 1:Gauss Newton 2:DLT 3: Absolute Orientation

~~~matlab
    %% Step2 : Update (3 method)
    [R,t] = solveTransform(X,Y(:,index),2);
~~~



To add some noise on input data X:

~~~
X = X + random('noiseType',noisepara...,dimension,pointNumX)
~~~

ex.:

~~~matlab
%Add Gaussian Noise (mean = 0, sigma = 0.01) on X
X = X + random('Normal',0,0.01,dimension,pointNumX)
~~~













