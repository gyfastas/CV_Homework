# Final Project

## 1.Introduction

This is the final project of SJTU EE382-Visual Localization and Perception. It requires us to write a program to do pose estimation based on three images. The project includes camera calibration, feature matching, RANSAC\M-estimator algorithm, PnP-RANSA, Triangulation.

## 2.Tutorial

Require Matlab2016b+ (Matlab2017b verified)

Use MATLAB Camera Calibration APP to calibrate your camera before running the program. The result should be saved as cameraParameters object (see this https://www.mathworks.com/help/vision/ref/cameraparameters.html?s_tid=doc_ta for detailed documentation). The testing result(my own camera) is in Calib_params.mat 

To use your own data, replace the path in load function as your calibration result path.

```
%% step1: read image
get_img;
cali_data  = load('Your data.mat');  %use your own data
```



The program will ask you some input, they are:

1. the path of your input image (default: ./input_img/)
2. the base name of your input image (images should be named as  basename+number, ex. lib01.jpg)
3. the input format of your image (default: jpg) ---jpg,tif,png are supported
4. Do you want to distort your image (default: N ) if it is your frist time running the program, choose Y

 After these questions the program will do 3D-reconstruction automatically and pose estimation. 

Have fun :)



Most of the function can be found in Matlab Documentation https://ww2.mathworks.cn/help/matlab/

Matlab function used:

-triangulate()

-detectSURFFeatures()

-estimateFundamentalMatrix()

-estimteEssentialMatrix()

-matchFeatures()

-showMatchedFeatures()

-estimateWorldCameraPose()



## 3.Testing result

- Feature Mapping after RANSAC\M-estimator:

![1547204468883](D:\GIT\CV_Homework\FINAL\1547204468883.png)





- Pose Estimation result:

![1547204505059](D:\GIT\CV_Homework\FINAL\1547204505059.png)





### 4.Issue

Issue1: estimateEssentialMatrix is not a function in matlab 2015b or earlier release version.

Solution:

```
 [F,inliersindex] = estimateFundamentalMatrix(mPts12_1,mPts12_2);
 E = K'*F*K;
```

