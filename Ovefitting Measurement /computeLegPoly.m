function [ z ] = computeLegPoly( x, Q )
%COMPUTELEGPOLY Return the Qth order Legendre polynomial of x
%   Inputs:
%       x: vector (or scalar) of reals in [-1, 1]
%       Q: order of the Legendre polynomial to compute
%   Output:
%       z: matrix where each column is the Legendre polynomials of order 0 
%          to Q, evaluated at the corresponding x value in the input

z = zeros(Q+1,length(x));
z(1,:) = ones(1,length(x));
for i = 1:Q
    for j = 0:i
    z(i+1,:) = z(i+1,:)+((nchoosek(i,j))^2*(x-1).^(i-j).*(x+1).^j)/2^i;
    end
end 
z;
end 