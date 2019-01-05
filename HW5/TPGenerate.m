function [X,Y,pointNumX,pointNumY] = TPGenerate(sigma,num,R,t)
%Generate Test Point Cloud based on my shape
%input: 
%sigma-> noise variance
%num: noise point num
%R: Rotation Matrix (as Answer!)
%t: translation vector (as Answer!)
X = zeros(3,250);
pointNumX = 250;
pointNumY = 250;

%% 让我们生成一个帆字
X(1,1:20) = 0; X(2,1:20) = 0; X(3,1:20) = linspace(-4,2,20);
X(1,21:40) = 0; X(2,21:40) = linspace(-1,1,20); X(3,21:40) = 0;
X(1,41:60) = 0; X(2,41:60) = -1; X(3,41:60) = linspace(-1,0,20);
X(1,61:80) = 0; X(2,61:80) = 1; X(3,61:80) = linspace(-1,0,20);
X(1,81:100) = 0; X(2,81:100) = linspace(0.8,1,20); X(3,81:100) = linspace(-0.8,-1,20);
X(1,101:140) = 0; X(2,101:140) = 2; X(3,101:140) = linspace(-4,0,40);
X(1,141:160) = 0; X(2,141:160) = linspace(2,3.5,20); X(3,141:160) = 0;
X(1,161:200) = 0; X(2,161:200) = 3.5; X(3,161:200) = linspace(-4,0,40);
X(1,201:220) = 0; X(2,201:220) = linspace(3.5,4,20); X(3,201:220) = linspace(-4,-3,20);
X(1,221:250) = 0; X(2,221:250) = linspace(2.5,3.0,30); X(3,221:250) = linspace(-0.4,-1.6,30);

Y = R*X + repmat(t,[1,pointNumX]);

mean_Y = mean(Y,2);
%% 加点噪声！
noise_y = random('Normal',0,sigma,3,num);
noise_y = repmat(mean_Y,[1,num]) + noise_y;

Y = [Y,noise_y];
%% 打乱排序吧！
pointNumY = pointNumY + num;
randindex = randperm(pointNumY);
Y = Y(:,randindex);

end

