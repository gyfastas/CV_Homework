%read image and convert into grey
img1 = imread('./image./1.jpg');
img2 = imread('./image./2.jpg');
img1 = rgb2gray(img1);
img2 = rgb2gray(img2);
im1 = img1;
im2 = img2;
%make histogram
hist1 = zeros(1,256);
hist2 = zeros(1,256);
for i = 1:256
    hist1(i) = sum(sum(img1==i-1));
    hist2(i) = sum(sum(img2==i-1));
end
hist1 = hist1/sum(hist1);
hist2 = hist2/sum(hist2);
cu_hist1 = cumsum(hist1);
cu_hist2 = cumsum(hist2);
I = zeros(1,256);
%build look up table
for i = 1:256
    I(i) = min(find(abs(cu_hist2-cu_hist1(i))==min(abs(cu_hist2-cu_hist1(i)))));
    %map img1
    img1(find(im1==i-1)) = I(i);
end

%calculate histogram of changed image
hist3 = zeros(1,256);
for k = 1:256
    hist3(k) = sum(sum(img1==k-1));
end
hist3 = hist3/sum(hist3);


subplot(331);
plot(hist1);
subplot(332);
plot(cu_hist1);

subplot(333);
imshow(im1);

subplot(334);
plot(hist2);

subplot(335);
plot(cu_hist2);

subplot(336);
imshow(im2);

subplot(337);
plot(hist3);

subplot(338);
plot(I);

subplot(339);
imshow(img1);




