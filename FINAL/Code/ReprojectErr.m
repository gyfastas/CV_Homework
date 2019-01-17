function error = ReprojectErr( points2D,points3D,P )
%points2D: M*2 Matrix[x,y], object 2Dpoints
%points3D: M*3 Matrix[X,Y,Z], 3D points
%P: projection matrix
ptnum = size(points3D,1);
onevec = ones(ptnum,1);
points3D = [points3D,onevec]; %转换到齐次坐标
Pc = points3D*P;
dvec = repmat(Pc(:,3),[1,3]);
Pc = Pc./dvec; %归一化
Pc = Pc(:,1:2); %取像素坐标

diff = points2D-Pc;

error = sum(sum(diff.*diff))./ptnum; %取均方误差
end

