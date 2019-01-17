function P = findProject2( E,KK,P1,pt1,pt2 )
%E: Essential Matrix , 3*3 Matrix
%KK: Camera Matrix,    3*3 Matrix
%P1: projection matrix of view1 , 3*4 Matrix
%pt1: sample point of view1  (SURFPoints type) 
%pt2: sample point of view2  (SURFPoints type)

%只要找到深度为正的即可
loc1 = pt1.Location;
loc2 = pt2.Location;
%% Find four possible Project Matrix
[U,D,V] = svd(E);
if det(U*V')<0
    V = -V;
end
tempM1 = [0,1,0;-1,0,0;0,0,0];
tempM2 = [0,-1,0;1,0,0;0,0,1];
t_skew1 = U*tempM1*U';
t1 = [-t_skew1(2,3),t_skew1(1,3),-t_skew1(1,2)]';
R1 = U*tempM2*V';
R2 = U*tempM2'*V';
% 4 possible solution
P21 = [R1,t1]; 
P22 = [R1,-t1]; 
P23 = [R2,t1]; 
P24 = [R2,-t1];
P2_all = [P21,P22,P23,P24];
for k = 1:4:16
    P20 = P2_all(:,k:k+3);
   % s2 = (-P20(4,:)*skew(loc1))*inv(loc2*P20(1:3,:)*skew(loc1));
    P20 = KK*P20;
    d1 = py.cv2.triangulatePoints(P1,P20,py.numpy.array(loc1),loc2);
    d1 = d1./d1(4);
    P20_Homo  = inv([P20;[0,0,0,1]]);
    P20_Homo = P20_Homo(1:3,:);
    d2 = P20_Homo*[d1;1];
    if d1(3)>0 && d2(3)>0
        P = P20;
end



end

