%% Test DLT method on noise

%% load data
data= load('xy.mat');
x = data.x;
y = data.y;
R_m = load('R_m.mat');
R_m = R_m.R;

%¸½¼Óµã
x_add = randn(3,100);
y_add = R_m*x_add;
x = [x,x_add];
y = [y,y_add];

dimension = size(x,1);
pointNum = size(x,2);
%% Add Gaussion Noise
noise = random('Normal',0,0.01,dimension,pointNum);
x = x+noise;
y = y+noise;
[R,error] = DLT(x,y);
[Qout,error2] = QDLT(x,y);
[R1,error3] = Gauss_Newton(x,y,100);
[R2,error4] = SVD_Method(x,y);