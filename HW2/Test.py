#HW2 Test and show result
#
#Author: Yuanfan Guo
#Rev.0 2018.10.8

import cv2
import numpy as np

from HarrisDetector import HarrisDetector



Detector = HarrisDetector(K = 0.04)
TestImg = cv2.imread('./image/2.jpg')
ColorImg = TestImg.copy()
gray = cv2.cvtColor(TestImg,cv2.COLOR_BGR2GRAY)
dst = cv2.cornerHarris(gray,2,3,0.04)
dst = cv2.dilate(dst,None)
ColorImg[dst>0.01*dst.max()] = [0,0,255]
cv2.namedWindow('OpencvHarris')
cv2.imshow('OpencvHarris',ColorImg)
Result, Cornerlist = Detector.DetectCorner(TestImg)

cv2.namedWindow('Original Image')
cv2.namedWindow('Detected Image')
cv2.imshow('Detected Image',Result)
cv2.imshow('Original Image',TestImg)
cv2.waitKey(0)


cv2.destroyAllWindows()
