%read image and convert into grey
%img1 is the original image
img1 = imread('./image./9.jpg');
%img2 is the target image
img2 = imread('./image./10.jpg');

img1 = rgb2gray(img1);
img2 = rgb2gray(img2);
im1 = img1;
im2 = img2;
% histogram
hist1 = zeros(1,256);
hist2 = zeros(1,256);
for i = 1:256
    hist1(i) = sum(sum(img1==i-1));
    hist2(i) = sum(sum(img2==i-1));
end
%Normalization
hist1 = hist1/sum(hist1);
hist2 = hist2/sum(hist2);

%cumulative histogram of img1 and img2
cu_hist1 = cumsum(hist1);
cu_hist2 = cumsum(hist2);
I = zeros(1,256);
%build look up table by looking arg min(|cu(I_i)-cu(I_j)|
for i = 1:256
    I(i) = min(find(abs(cu_hist2-cu_hist1(i))==min(abs(cu_hist2-cu_hist1(i)))));
    %map img1
    img1(find(im1==i-1)) = I(i);
end

%calculate histogram of adjusted image
hist3 = zeros(1,256);
for k = 1:256
    hist3(k) = sum(sum(img1==k-1));
end
hist3 = hist3/sum(hist3);

%Result Visualization

subplot(331);
plot(hist1);
title('Histogram of img1');
subplot(332);
plot(cu_hist1);
title('Cumulative Histogram of img1');

subplot(333);
imshow(im1);


subplot(334);
plot(hist2);
title('Histogram of img2');

subplot(335);
plot(cu_hist2);
title('Cumulative Histogram of img2');

subplot(336);
imshow(im2);

subplot(337);
plot(hist3);
title('Historgram of adjusted img1');

subplot(338);
plot(I);
title('Lookup Table');

subplot(339);
imshow(img1);




