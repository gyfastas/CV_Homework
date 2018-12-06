function [R,error] =  Gauss_Newton(x,y,iter)
% x:�任ǰ������
% y:�任�������
% iter:��������
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
    %���������
    for k = 1: size(x,2)
        J = skew(R*x(:,k));
        z = y(:,k) - R*x(:,k);
        H =  H+J'*J;
        g = g+J'*z;
    end
    %��ⷽ��
    delta_theta = -inv(H)*g;
    the = norm(delta_theta,2);
    n = delta_theta./the;
    %��������
    R = R*(cos(the)*eye(3)+(1-cos(the))*n*n'+sin(the)*skew(n));
    %svd
    [U,D,V] = svd(R);
    R = U*V';
    %�������
    error(m) = target(R,x,y);
end
error = min(error);
end