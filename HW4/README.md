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

-TestDLT.m Main Program, load the data and add noise then calculate the Rotation Matrix using Gauss Newton method, Direct Linear Transform and Absolute Orientation





#### Test Program

TestDLT.m:

 To add different Noise( use MATLAB random generator:

~~~matlab
%% Add Gaussion Noise
noise = random('Normal',0,0.01,dimension,pointNum);
x = x+noise;
y = y+noise;
~~~













