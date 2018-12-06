function [qOut,error] = QDLT(x,y)
%  return the unit quaternion and error
%  x:变换前坐标集合
%  y:变换后坐标集合
dimension = size(x,1);
pointNum = size(x,2);
qOut = zeros(4,1);
A = zeros(4,4);
for k = 1:pointNum 
    xq = [0;x(:,k)];
    yq = [0;y(:,k)];
    A = A+QL(yq)'*QR(xq);
end
%Find max eigenvector 
[eigvec,eigmat] = eig(A);
qOut = eigvec(:,find(diag(eigmat)==max(diag(eigmat))));
R = q2r(qOut);
% Calculate Error
error = target(R,x,y);

end

