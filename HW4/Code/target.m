function f = target(R,x,y)
%Target function of error
f = 0;
for k = 1: size(x,2)
    f = f + norm(y(:,k)-R*x(:,k),2)*(norm(y(:,k)-R*x(:,k),2));
end
end

