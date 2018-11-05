%read Image and transfer into gray image
img = imread('./image/8.jpg');
subplot(221);
gray = rgb2gray(img);
imshow(gray);
title('Original');
%Thres hold low/high
TL = 0.1;
TH = 0.2;
%step1: Gaussian filter
sigma = 0.5;
Im1 = imgaussfilt(gray,sigma);
subplot(222);
imshow(Im1);
title('After Gaussian');

%% step2: Get Gradient
%using Sobel 
Dy = [-1,-2,-1;0,0,0;1,2,1];
Dx = [-1,0,1;-2,0,2;-1,0,1];
phiy = conv2(Im1,Dy);
phix = conv2(Im1,Dx);
phi = sqrt(phix.^2+phiy.^2);
%Calculating theta
theta = zeros(size(phi,1),size(phi,2));
for i = 1:size(phi,1)
    for j = 1:size(phi,2)
        if phix(i,j) >= 0
            theta(i,j) =  atan(phiy(i,j)/phix(i,j))*180/pi;%in degree
        else
            theta(i,j) = atan(phiy(i,j)/phix(i,j))*180/pi+180;
        end
    end
end 
%% step3: NMS
% Make theta into section
theta(theta>-22.5 & theta<=22.5) = 0;
theta(theta>22.5 & theta<=67.5) = 1;
theta(theta>67.5 & theta<=112.5) = 2;
theta(theta>112.5 & theta<=157.5) = 3;
theta(theta>157.5 & theta<=202.5) = 0;
theta(theta>202.5 & theta<=247.5) = 1;
theta(theta>247.5 | theta<=-67.5) = 2;
theta(theta>-67.5 & theta<=-22.5) = 3;

is_max = zeros(size(phi,1),size(phi,2));
% 3*3 NMS  Window
for x = 2:size(phi,1)-1
    for y = 2:size(phi,2) - 1 
        phi_near = phi(x-1:x+1,y-1:y+1);
        phi_near = phi_near.*(theta(x-1:x+1,y-1:y+1)==theta(x,y));
        is_max(x,y) = phi(x,y)==max(max(phi_near));
    end
end
%Maping!
phi = is_max.*phi;
%% step4:Thres
Edge = zeros(size(phi,1),size(phi,2));
phi_max = max(max(phi));
TH = TH*phi_max;
TL = TL*phi_max;
%4 neibour| 8 neibour
Nei4 = [0,1,0;1,0,1;0,1,0];
Nei8 = [1,1,1;1,0,1;1,1,1];
%High thres mapping
Edge(phi>TH) = 2;
Result_strong = double(gray);
Result_strong(Edge(2:end-1,2:end-1)>0) = 255;
Result_strong(Edge(2:end-1,2:end-1)<=0) = 0;
subplot(223);
imshow(Result_strong);
title('Strong Edge');
%Low thres mapping
for i = 2:size(phi,1)-1
    for j = 2:size(phi,2)-1
        if phi(i,j)<TL
            Edge(i,j) = 0;
        elseif phi(i,j)>=TL && phi(i,j)<TH
            Edge(i,j) = sum(sum((Edge(i-1:i+1,j-1:j+1).*Nei8>=1)))>0;
        end
    end
end
            

Edge = Edge(2:end-1,2:end-1);
Edge(Edge>0) = 1;
%Make output
Out = Edge.*double(gray);
Out(Out>0) = 255;
subplot(224);
imshow(Out);
title('Result');
