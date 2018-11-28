%%Read Image
img_in = imread('../Resources/tests/0.jpg');
img_in = rgb2gray(img_in);
subplot(221);
imshow(img_in);
[m,n] = size(img_in);
% Generate Gaussian White Noise

subplot(222);
imshow(img_in);

out = FastNLM(img_in,7,21,2,0.3,1);
subplot(223);
imshow(out);
