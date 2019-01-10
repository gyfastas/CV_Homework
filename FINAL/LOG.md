# Visual Localization and perception

## 1.5

camera calibration toolbox http://www.vision.caltech.edu/bouguetj/calib_doc/

Issue1: calibration的时候要用灰度图

solution1: 写一个灰度图转换保存即可

issue2: SIFT算子特征匹配后得到的结果是什么呢？

```matlab
img = imread('Image3.jpg');
gray = rgb2gray(img);
imwrite(gray,'Image3.tif');

```

 Reprojection of grid image:

![1546654842947](D:\GIT\CV_Homework\FINAL\1546654842947.png)

![1546654950991](D:\GIT\CV_Homework\FINAL\1546654950991.png)

 得到的标定error 大概是0.26，算不算大呢？

 得到的去除畸变后的图像怎么用呢？

Focal length->焦距->fc

Principal point->主点->cc

Skew coefficient->$\alpha_c$

Distortions: 畸变因子

![1546671207953](D:\GIT\CV_Homework\FINAL\1546671207953.png)

内参矩阵



https://blog.csdn.net/gaotihong/article/details/78902798 去除畸变自己写程序

![1546676433575](D:\GIT\CV_Homework\FINAL\1546676433575.png)

实验1: 自己编写的去畸变程序(左边是原图，右边是去除噪声后)

怎么对比自己写的去畸变函数跟自带的去畸变函数的性能的差异呢？







### SIFT/SURF特征点提取和匹配

https://www.cs.ubc.ca/~lowe/keypoints/ Matlab实现



![1546695258317](D:\GIT\CV_Homework\FINAL\1546695258317.png)

RANSAC算法的流程



第一次进行特征点匹配的结果:(使用SIFT算子的闭源程序)

![1546696606948](D:\GIT\CV_Homework\FINAL\1546696606948.png)

使用Matlab自带的surf呢？:

