function q = r2q( R )
%Transfer Rotation matrix into quaternion
q = zeros(1,4);
q(1) = sqrt(trace(R)+1)/2;
q(2) = (R(3,2)-R(2,3))/(4*q(1));
q(3) = (R(1,3)-R(3,1))/(4*q(1));
q(4) = (R(2,1)-R(1,2))/(4*q(1));


end

