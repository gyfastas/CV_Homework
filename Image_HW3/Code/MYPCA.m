function [Pvec,Wcols] = MYPCA(A,M)
%my PCA functiton
%A: differ matrix
%M: number we want to keep
Pvec = zeros(size(A,1),M);
[u,s,v] = svd(A,'econ');
u = u(:,1:M);
s = s(1:M,1:M);
v = v(:,1:M);
% Get Principle Vector and Weight Cols
Pvec = u;
Wcols = s*v';


end

