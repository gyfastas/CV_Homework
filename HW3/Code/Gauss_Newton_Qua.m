%% load data
data= load('xy.mat');
x = data.x;
y = data.y;
R_m = load('R_m.mat');
R_m = R_m.R;
%% 引入随机扰动
q = r2q(R_m)+rand(1)*1;
q = q./norm(q,2);
error = zeros(1,10000);
error(1) = target(q2r(q),x,y);	
for m = 1:5000
    %% 将四元数转换为旋转矩阵
    R = q2r(q);
    %% 计算误差项
    J = zeros(3,3);
    z = zeros(3,1);
    H = zeros(3,3);
    g = zeros(3,1);
    for k = 1: size(x,2)
        J = skew(R*x(:,k));
        z = y(:,k) - R*x(:,k);
        H =  H+J'*J;
        g = g+J'*z;
    end
    %% 求解非线性方程
    delta_theta = -inv(H)*g;
    the = norm(delta_theta,2);  %提取旋转角
    %% 如果 the 过小，采用近似公式
    if the<0.01 
        n = delta_theta./the;   %旋转轴
        q = Qmult(q,[1,delta_theta'/2]); %近似公式
    else
        n = delta_theta./the;  
        q  = Qmult(q,[cos(the/2),sin(the/2)*n']);
    end
    %% 保证q的单位性
    q = q./norm(q,2);
    R = q2r(q); %将四元数转换为旋转矩阵
    error(m+1) = target(R,x,y);
end
error = error';
plot(error);
axis([1 10 0 1]);