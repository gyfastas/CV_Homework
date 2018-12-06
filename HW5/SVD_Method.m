function [R,error] = SVD_Method(x,y)
% x: �任ǰ���꼯��
% y: �任��Ŀ�꼯��
%% ��ΪSVD�����������ο�
%% ��������
p_x = 1/size(x,2)*sum(x,2);
p_y = 1/size(y,2)*sum(y,2);

%% ����ȥ��������
q_x = x-repmat(p_x,1,size(x,2));
q_y = y-repmat(p_y,1,size(y,2));
%% ����W ����
W = zeros(3,3);
for k = 1:size(q_x,2)
    W = W + q_y(:,k)*q_x(:,k)';
end

%% ��SVD
[U,D,V] = svd(W);
R = U*V';
%%�������
error = target(R,x,y);

end