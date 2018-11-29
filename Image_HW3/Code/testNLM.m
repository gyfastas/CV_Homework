%%Read Image, change the direction to use other test images
img_in = imread('../Resources/tests/lena.png');

%% part of Lena
img_in = img_in(471:550,471:550,:);

img_in =  rgb2gray(img_in);
subplot(131);
imshow(img_in);
[m,n] = size(img_in);

%% Noise generator  (changable)
img_noise = imnoise(img_in,'gaussian',0.01);
% Generate Gaussian White Noise

subplot(132);
imshow(img_noise);

out = NLM(img_noise,7,21,2,5);
subplot(133);
imshow(out);
diff = sum(sum((double(out) - double(img_in))))./(size(img_in,1)*size(img_in,2));
