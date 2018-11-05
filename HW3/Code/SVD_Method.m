function [R,error] = SVD_Method(x,y)
% x: 变换前坐标集合
% y: 变换后目标集合
%% 此为SVD方法，仅供参考
%% 计算质心
p_x = 1/size(x,2)*sum(x,2);
p_y = 1/size(y,2)*sum(y,2);

%% 计算去质心坐标
q_x = x-repmat(p_x,1,size(x,2));
q_y = y-repmat(p_y,1,size(y,2));
%% 计算W 矩阵
W = zeros(3,3);
for k = 1:size(q_x,2)
    W = W + q_y(:,k)*q_x(:,k)';
end

%% 求SVD
[U,D,V] = svd(W);
R = U*V';
%%计算误差
error = target(R,x,y);

end