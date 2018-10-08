#HW2 Test and show result
#
#Author: Yuanfan Guo
#Rev.0 2018.10.8

import cv2
import numpy as np

from HarrisDetector import HarrisDetector



Detector = HarrisDetector()
TestImg = cv2.imread('./image/TX2.png')
result,Cornerlist = Detector.DetectCorner(TestImg)
print(Cornerlist)
cv2.imshow('Adjusted',result)
cv2.waitKey(0)
