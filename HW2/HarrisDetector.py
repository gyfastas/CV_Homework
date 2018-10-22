# HW2 Harris Detector implement
# HarrisDetector class
# Author : Yuanfan Guo
# Rev.0 2018.10.8
# Rev.1 2018.10.9
import cv2
import numpy as np
import matplotlib.pyplot as plt


class HarrisDetector():
    def __init__(self,ThresHold = 0.02, WindowSize = 5 , K=0.05, Blocksize = 5):
        self.ThresHold = ThresHold      #Above threshold will count as corner
        self.K = K                      #K is Empirical Constant, 0.04~0.06
        self.WindowSize = WindowSize    #The size of the window
        self.Blocksize = Blocksize            #The Blocksize (usually 3 or 5)
    def SetPara(self,ThresHold,WindowSize,K,Blocksize):
        #Set ThresHold, WindowSize and K and Blocksize of detector

        self.ThresHold = ThresHold
        self.K = K
        self.WindowSize = WindowSize
        self.Blocksize = Blocksize
    def DetectCorner(self,InImg):
        #InImg : image matrix (gray or color)
        #Detect corners in an img and return Corner list and new image
        Result = InImg.copy()
        gray_img = cv2.cvtColor(InImg, cv2.COLOR_BGR2GRAY)

        img = np.array(gray_img,dtype=np.float64)
        CornerResponse = np.zeros([img.shape[0],img.shape[1]])
        #Calculate Ixx Ixy and Iyy
        Ixx,Ixy,Iyy = self.CalGradient(img)

        Half_w = int(self.WindowSize/2)
        for x in range(Half_w, img.shape[0]-Half_w):
            for y in range(Half_w , img.shape[1]-Half_w):

                ##Compute sums of derivatives

                M11 = sum(Ixx[x - Half_w: x + Half_w + 1, y - Half_w: y + Half_w + 1].ravel())
                M12 = sum(Ixy[x - Half_w: x + Half_w + 1, y - Half_w: y + Half_w + 1].ravel())
                M22 = sum(Iyy[x - Half_w: x + Half_w + 1, y - Half_w: y + Half_w + 1].ravel())

                ##Get Eigen Value and R
                Det = M11*M22 - M12**2
                Trace = M11 + M22

                R = Det - self.K*(Trace**2)
                CornerResponse[x][y] = R
        #Find Local max  Value and plot corner
        Cornerlist = []
        CornerMax = max(CornerResponse.ravel())
        HalfBlcok = int(self.Blocksize/2)
        for x in range(HalfBlcok, img.shape[0]-HalfBlcok):
            for y in range(HalfBlcok , img.shape[1]-HalfBlcok):
                LocalMax = max(CornerResponse[x - HalfBlcok:x+HalfBlcok+1,y-HalfBlcok:y+HalfBlcok+1].ravel())
                #only the Localmax value count as corner
                if (CornerResponse[x, y] >= CornerMax * self.ThresHold) and (CornerResponse[x, y] == LocalMax):
                    Cornerlist.append((x, y))
                    #Plot the Corner point
                    Result[x - HalfBlcok:x+HalfBlcok+1,y-HalfBlcok:y+HalfBlcok+1] = [0,0,255]
        return Result, Cornerlist



    def CalGradient(self,img):
        dy, dx = np.gradient(img)
        Ixx = dx**2
        Iyy = dy**2
        Ixy = dx*dy

        return Ixx,Ixy,Iyy
