import cv2
import numpy as np
import matplotlib.pyplot as plt
#read the image into matrix
img = cv2.imread('./image/1.jpg')
img_2 = cv2.imread('./image/2.jpg')
img_2 = cv2.cvtColor(img_2,cv2.COLOR_RGB2GRAY)
img = cv2.cvtColor(img,cv2.COLOR_RGB2GRAY)

hist = np.zeros([256,1])
hist_2 = np.zeros([256,1])

for i in range (256):
    hist[i] = np.sum(img==i)
    hist_2[i] = np.sum(img_2==i)
#normalization
hist = hist/sum(hist)
hist_2 = hist_2/sum(hist_2)
#calculate the cumulative histogram
Cu_hist = np.cumsum(hist)
Cu_hist_2 = np.cumsum(hist_2)

#build the look up table
I = np.zeros([256,2])
for i in range(256):
    I[i] = np.min(np.argwhere(Cu_hist_2-Cu_hist[i]==np.min(abs(Cu_hist_2-Cu_hist[i]))))[0][0]
#plot plot plot!

plt.figure(1,figsize=(9,9))
plt.subplot(321)
plt.plot(hist)
plt.title('Histogram of first image')

plt.subplot(322)
plt.plot(Cu_hist)
plt.title('Cumulative Histogram of first image')

plt.subplot(323)
plt.plot(hist_2)
plt.title('Histogram of second image')

plt.subplot(324)
plt.plot(Cu_hist_2)
plt.title('Cumulative Histogram of second image')

plt.subplot(325)
plt.plt(I)
plt.title('The look up table I')

plt.show()
