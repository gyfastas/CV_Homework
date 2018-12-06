function A = skew( x )
%Make a 3D vector into skew-symetric matrix
A = [0,-x(3),x(2);x(3),0,-x(1);-x(2),x(1),0];


end

