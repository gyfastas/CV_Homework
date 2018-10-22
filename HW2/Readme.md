# CV_Homework

  This is my homework for EE382-Visual localization &Perception

## HW2

### Requirement

Write a small program to implement Harris detector

### Environment Required

The program implemented in Python.

Read requirements.txt for packages that should be installed



### Tutorial for this program

To run this program, import HarrisDetector class from HarrisDetector.py:

```python
import cv2
import numpy as np
from HarrisDetector import HarrisDetector

#create an detector
Detector = HarrisDetector()
img = cv2.imread('filename')
#Detect Corner, return cornerlist and adjusted image
Result, CornerList = Detector.DetectCorner(img)

cv2.imshow('Result',Result)
cv2.waitKey(0)

cv2.destroyAllWindows()

```



The test images are in **image** folder



