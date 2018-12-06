function result = Qmult( p,q )
%This function define quaternion multiplication
result = zeros(1,4);
result(1) = p(1)*q(1)-p(2)*q(2)-p(3)*q(3)-p(4)*q(4);
result(2) = p(1)*q(2)+p(2)*q(1)+p(3)*q(4)-p(4)*q(2);
result(3) = p(1)*q(3) -p(2)*q(4)+p(3)*q(1)+p(4)*q(2);
result(4) = p(1)*q(4) + p(2)*q(3)-p(3)*q(2)+p(4)*q(1);


end

