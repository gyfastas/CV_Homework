%% load data
data= load('xy.mat');
x = data.x;
y = data.y;
R_m = load('R_m.mat');
R_m = R_m.R;
%% ��������Ŷ�
q = r2q(R_m)+rand(1)*1;
q = q./norm(q,2);
error = zeros(1,10000);
error(1) = target(q2r(q),x,y);	
for m = 1:5000
    %% ����Ԫ��ת��Ϊ��ת����
    R = q2r(q);
    %% ���������
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
    %% �������Է���
    delta_theta = -inv(H)*g;
    the = norm(delta_theta,2);  %��ȡ��ת��
    %% ��� the ��С�����ý��ƹ�ʽ
    if the<0.01 
        n = delta_theta./the;   %��ת��
        q = Qmult(q,[1,delta_theta'/2]); %���ƹ�ʽ
    else
        n = delta_theta./the;  
        q  = Qmult(q,[cos(the/2),sin(the/2)*n']);
    end
    %% ��֤q�ĵ�λ��
    q = q./norm(q,2);
    R = q2r(q); %����Ԫ��ת��Ϊ��ת����
    error(m+1) = target(R,x,y);
end
error = error';
plot(error);
axis([1 10 0 1]);