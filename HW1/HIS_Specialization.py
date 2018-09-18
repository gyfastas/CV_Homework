import cv2
import numpy as np
import matplotlib.pyplot as plt
#read the image into matrix
img = cv2.imread('./image/test1.jpg')
img = cv2.cvtColor(img,cv2.COLOR_RGB2GRAY)

#calculate the histogram in opencv
hist = np.zeros([256,1])
for i in range (256):
    hist[i] = np.sum(img==i)

hist = hist/sum(hist)
#calculate the cumulative histogram
Cu_hist = np.cumsum(hist)

#plot plot plot!
fig,ax = plt.subplots()
ax.plot(Cu_hist)
ax.grid()
plt.show()

