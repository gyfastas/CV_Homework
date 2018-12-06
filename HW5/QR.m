function result = QR( q )
% return the left quaternion-product 
% q: quaternion
result = [q(1),-q(2),-q(3),-q(4);
          q(2),q(1),q(4),-q(3);
          q(3),-q(4),q(1),q(2);
          q(4),q(3),-q(2),q(1);];

end

