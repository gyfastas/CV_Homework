function [R,error] = DLT(x,y)
% x: �任ǰ���꼯��
% y: �任��Ŀ�꼯��
%% DLT����
dimension = size(x,1);
pointNum = size(x,2);
X = zeros(dimension*pointNum,dimension*dimension);
Y = zeros(dimension*pointNum,1);
%% ������չ
for k  = 1:dimension:3*pointNum
    colzero = zeros(1,dimension);
    xx = x(:,1+floor(k/dimension));
    yy = y(:,1+floor(k/dimension));
    temp = [xx',colzero,colzero;colzero,xx',colzero;colzero,colzero,xx'];
    X(k:k+dimension-1,1:3*dimension) = temp;
    Y(k:k+dimension-1,1) = yy;
end
%% �õ�r����
r = inv(X'*X)*X'*Y;

%% �� r����õ���ת����R
R = reshape(r,[3,3])';

%% ��SVD
[U,D,V] = svd(R);
R = U*eye(3)*V';
%%�������
error = target(R,x,y);

end