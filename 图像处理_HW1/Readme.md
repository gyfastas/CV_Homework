# Image Processing HW1

  This is my homework for Image Processing

## HW1

### Requirement

Write a small program to implement a histogram specialization algorithm. Write a small program to implement canny edge detection algorithm.

### Environment Required

The program is implemented by Matlab. You should have Matlab 2015b+ to run the program.



### Tutorial

####Histogram Specialization

To run the program, use matlab to open His_specialization.m and click run.

To adjust original image and target image, change the direction of img1 and img2 in this program.

```matlab
%img1 is the original image
img1 = imread('./image./3.jpg');
%img2 is the target image
img2 = imread('./image./4.jpg');
```

The test images are in **image** folder



#### Canny

To run the program, use matlab to open Canny.m and click run.

To change input image, change the direction of img:

```matlab
%read Image and transfer into gray image
img = imread('./image/8.jpg');  %change the direction to change input image
```

To adjust Lower-Threshold and Higher-Threshold, change the value of TL,TH; To adjust standard derivation of Gaussian Filter, change sigma： 

```matlab
%Thres hold low/high
TL = 0.1;
TH = 0.2;
%step1: Gaussian filter
sigma = 1;
Im1 = imgaussfilt(gray,sigma);
```

To use 4Neibour/8Neibour to connect edge:

```
%4 neibour| 8 neibour
Nei4 = [0,1,0;1,0,1;0,1,0];
Nei8 = [1,1,1;1,0,1;1,1,1];
%High thres mapping
Edge(phi>TH) = 2;
%Low thres mapping
for i = 2:size(phi,1)-1
    for j = 2:size(phi,2)-1
        if phi(i,j)<TL
            Edge(i,j) = 0;
        elseif phi(i,j)>=TL && phi(i,j)<TH
            Edge(i,j) = sum(sum((Edge(i-1:i+1,j-1:j+1).*Nei8>2)))>0; %Nei4 is 4Neibour
        end
    end
end
```

