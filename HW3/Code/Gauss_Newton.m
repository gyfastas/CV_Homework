%% load data
data= load('xy.mat');
x = data.x;
y = data.y;

%% set Initial Value of theta
% make a random rotation matrix
R = load('R_m.mat');
R = R.R;
%% ��������Ŷ�
%R = R +rand(1)*0.01;
%% ���������
R = rand(3,3);
R = orth(R);

theta = zeros(3,1);

f_x = target(R,x,y);
%% Find min of target function
alpha = 1;
error =zeros(1,10000);
%% m controls the iter numbers
for m = 1:5000
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

error = error';
plot(error);
axis([1 10 0 1]);
