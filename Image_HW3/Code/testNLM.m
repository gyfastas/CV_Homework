%%Read Image
img_in = imread('../Resources/tests/1.jpg');
img_in = rgb2gray(img_in);
img_in = imresize(img_in,[60,80]);
subplot(221);
imshow(img_in);
[m,n] = size(img_in);
% Generate Gaussian White Noise
White_noise  = wgn(m,n,5);
img_in = uint8(double(img_in)+White_noise);
subplot(222);
imshow(img_in);

out = NLM(img_in,7,21,2,1);
subplot(223);
imshow(out);
