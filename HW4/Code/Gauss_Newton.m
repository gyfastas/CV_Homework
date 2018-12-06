function [R,error] =  Gauss_Newton(x,y,iter)
% x:变换前的坐标
% y:变换后的坐标
% iter:迭代次数
theta = zeros(3,1);

%% Find min of target function
error =zeros(1,iter);

R = randn(3,3);
R = orth(R);
%% m controls the iter numbers
for m = 1:iter
    %Get Approximate Hessian matrix
    J = zeros(3,3);
    z = zeros(3,1);
    H = zeros(3,3);
    g = zeros(3,1);
    %计算误差项
    for k = 1: size(x,2)
        J = skew(R*x(:,k));
        z = y(:,k) - R*x(:,k);
        H =  H+J'*J;
        g = g+J'*z;
    end
    %求解方程
    delta_theta = -inv(H)*g;
    the = norm(delta_theta,2);
    n = delta_theta./the;
    %参数更新
    R = R*(cos(the)*eye(3)+(1-cos(the))*n*n'+sin(the)*skew(n));
    %svd
    [U,D,V] = svd(R);
    R = U*V';
    %计算误差
    error(m) = target(R,x,y);
end
error = min(error);
end