function result = undistort(input,resolution,KK,kc)
%input: input image matrix
%resolution: [Height,Width]
%KK: Camera Matrix
%kc: Distored Vector
H = resolution(1);
W = resolution(2);
input = double(input);
result = zeros(H,W);
fx = KK(1,1);
fy = KK(2,2);
u0 = KK(1,3);
v0 = KK(2,3);
k1 = kc(1);
k2 = kc(2);
k3 = kc(3);
p1 = kc(4);
p2 = kc(5);

u = 1:H;
v = 1:W;
x = (u-u0)./fx; %pixel coordinate ->camera coordinate
y = (v-v0)./fy; %pixel coordinate ->camera coordinate

%undistortion
r = x.*x+y.*y;
xx = x.*(1+k1.*r+k2.*(r.*r)+k3.*(r.*r.*r)) + 2*p1.*x.*y + p2*(r + 2*x.*x);
yy = y.*(1+k1.*r+k2.*(r.*r)+k3.*(r.*r.*r)) + 2*p2.*x.*y + p1*(r + 2*y.*y);

%reproject
u1 = xx.*fx +u0;
v1 = yy.*fy +v0;
uu = repmat(u1,[H,1]);
vv = repmat(v1',[1,W]);
weightUL = (floor(uu+1)-uu).*(floor(vv+1) - vv);
weightDL = (floor(uu+1)-uu).*(vv - floor(vv));
weightUR = (uu - floor(uu)).*(floor(vv+1) - vv);
weightDR = (uu - floor(uu)).*(vv - floor(vv));
%Bilinear interpolation
result = weightUL.*input(floor(u1),floor(v1)) + weightDL.*input(floor(u1+1),floor(v1)) + weightUR.*input(floor(u1),floor(v1+1))+ weightDR.*input(floor(u1+1),floor(v1+1));

result =  uint8(result);
end

