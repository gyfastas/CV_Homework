function [R,error] = DLT(x,y)
% x: 变换前坐标集合
% y: 变换后目标集合
%% DLT方法
dimension = size(x,1);
pointNum = size(x,2);
X = zeros(dimension*pointNum,dimension*dimension);
Y = zeros(dimension*pointNum,1);
%% 矩阵拓展
for k  = 1:dimension:3*pointNum
    colzero = zeros(1,dimension);
    xx = x(:,1+floor(k/dimension));
    yy = y(:,1+floor(k/dimension));
    temp = [xx',colzero,colzero;colzero,xx',colzero;colzero,colzero,xx'];
    X(k:k+dimension-1,1:3*dimension) = temp;
    Y(k:k+dimension-1,1) = yy;
end
%% 得到r矩阵
r = inv(X'*X)*X'*Y;

%% 从 r矩阵得到旋转矩阵R
R = reshape(r,[3,3])';

%% 求SVD
[U,D,V] = svd(R);
R = U*eye(3)*V';
%%计算误差
error = target(R,x,y);

end