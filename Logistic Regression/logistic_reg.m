function [ w, e_in ] = logistic_reg( X, y, w_init, max_its, eta )
%LOGISTIC_REG Learn logistic regression model using gradient descent
%   Inputs:
%       X : data matrix (without an initial column of 1s)
%       y : data labels (plus or minus 1)
%       w_init: initial value of the w vector (d+1 dimensional)
%       max_its: maximum number of iterations to run for
%       eta: learning rate
    
%   Outputs:
%       w : weight vector
%       e_in : in-sample error (as defined in LFD)

X = [ones(size(X,1),1) X];
y = 2*y -1;
old_w = w_init;
n_itr = 0;
tol = 0.001*2;
n = size(X,1);
while tol > 0.001 && n_itr < max_its
 g = -sum(y .* X ./ (1+exp(y.*X*old_w)))/n;
 new_w = old_w-eta*transpose(g);
 old_w = new_w;
 n_itr = n_itr+1;
 tol = max(abs(g)) ;
end
w = new_w;
e_in = sum(log(1+exp(-y.*X*w)))/n;
end

