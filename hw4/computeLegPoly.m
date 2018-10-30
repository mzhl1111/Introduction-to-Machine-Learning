function [ z ] = computeLegPoly( x, Q )
%COMPUTELEGPOLY Return the Qth order Legendre polynomial of x
%   Inputs:
%       x: vector (or scalar) of reals in [-1, 1]
%       Q: order of the Legendre polynomial to compute
%   Output:
%       z: matrix where each column is the Legendre polynomials of order 0 
%          to Q, evaluated at the corresponding x value in the input

z = 0;
for i = 0:Q
    z = z+ nchoosek(Q,i)^2*(x-1)^(Q-i)*(x+1)^i/2^Q;
end 
z;
end 