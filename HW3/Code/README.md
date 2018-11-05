# CV_Homework-HW3

Gaussian-Newtown Method of ICP Problem

## Environment

Matlab 2015b+



## Program Tutorial 

Gauss_Newton.m - Rotation Matrix expression Gauss_Newton method test on xy.mat

Gauss_Newton_Qua.m Quaternion expression Gauss_Newton method test on xy.mat

SVD_Method.m -SVD Method of 3D-3D ICP problem , can be used to test the result of gauss-newton

skew.m -function that transfer a 3d vector to skew-symmetric matrix

r2q.m - function that transform rotation matrix into quaternion

q2r.m - function that transform quaternion into rotation matrix

target.m -function that calculate error

Qmult.m -function that calculate quaternion multiplication.



**Gauss_Newton.m/Gauss_Newton_Qua.m**:

run these to test on xy.mat

to see the result after iteration, see variable error (also the error is plot from 1 to 10 iterations)

**SVD_Method.m**:

input : 

x: **$X_{3*N}$** N 3d point

y:**$Y_{3*N}$**N 3d point after rotation

output:

R: Approximated Rotation Matrix

error: sum square error between y and Rx

