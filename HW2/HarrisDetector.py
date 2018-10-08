# HW2 Harris Detector implement
# HarrisDetector class
# Author : Yuanfan Guo
# Rev.0 2018.10.8

import cv2
import numpy as np
import matplotlib.pyplot as plt


class HarrisDetector():
    def __init__(self,ThresHold = 20000, WindowSize = 4 , K=0.05):
        self.ThresHold = ThresHold      #Above threshold will count as corner
        self.K = K                      #K is Empirical Constant, 0.04~0.06
        self.WindowSize = WindowSize    #The size of the window

    def SetPara(self,ThresHold,WindowSize,K):
        #Set ThresHold, WindowSize and K of detector

        self.ThresHold = ThresHold
        self.K = K
        self.WindowSize = WindowSize

    def DetectCorner(self,InImg):
        #InImg : image matrix (gray or color)
        #Detect corners in an img and return Corner list and new image
        img = cv2.cvtColor(InImg, cv2.COLOR_BGR2GRAY)
        CornerList = []
        #Calculate dx and dy in img
        dy, dx = np.gradient(img)
        Ixx = dx**2
        Iyy = dy**2
        Ixy = dx*dy
        Half_w = int(self.WindowSize/2)
        print(Half_w)
        for i in range(Half_w, img.shape[0]-Half_w):
            for j in range(Half_w , img.shape[1]-Half_w):

                ##Compute sums of derivatives

                Wxx =  Ixx[i - Half_w:i + Half_w + 1,j - Half_w:j + Half_w + 1]
                Wxy =  Ixy[i - Half_w:i+ Half_w + 1,j - Half_w:j + Half_w + 1]
                Wyy =  Iyy[i - Half_w:i + Half_w + 1,j - Half_w:j + Half_w + 1]
                M11 = Wxx.sum()
                M12 = Wxy.sum()
                M22 = Wyy.sum()

                ##Get Eigen Value and R
                Det = M11*M22 - M12**2
                Trace = M11 + M22

                R = Det - self.K*(Trace**2)

                ##Find R > ThresHold
                if R > self.ThresHold:
                    CornerList.append([j,i,R])
                    InImg.itemset((i, j, 0), 0)
                    InImg.itemset((i, j, 1), 0)
                    InImg.itemset((i, j, 2), 255)
        return InImg, CornerList


    def PlotCorner(self,img,Cornerlist):
        #Show all the Corner point in image
        #:para Cornerlist: Cornerpoint list [x,y,R]
        #we use red point to show corner
        OldImg = img
        for points in Cornerlist:
            img[points[1]][points[0]][0] = 0
            img[points[1]][points[0]][1] = 0
            img[points[1]][points[0]][2] = 0

        cv2.namedWindow('Original image')
        cv2.imshow('Original image',OldImg)
        cv2.namedWindow('Detected image')
        cv2.imshow('Detecte image',img)
        cv2.waitKey(0)


