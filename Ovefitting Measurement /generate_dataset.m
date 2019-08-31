function [ train_set test_set ] = generate_dataset( Q_f, N_train, N_test, sigma )
%GENERATE_DATASET Generate training and test sets for the Legendre
%polynomials example
%   Inputs:
%       Q_f: order of the hypothesis
%       N_train: number of training examples
%       N_test: number of test examples
%       sigma: standard deviation of the stochastic noise
%   Outputs:
%       train_set and test_set are both 2-column matrices in which each row
%       represents an (x,y) pair

q_a = normrnd(0,1,[Q_f+1,1]) / sqrt(sum(1./(1:2:(2*Q_f+2))));

xs = 2*rand(1,N_train+N_test)-1;

ys = sum(computeLegPoly(xs,Q_f) .* q_a)+ sigma*normrnd(0,1,[1,N_train+N_test]);

data = vertcat(xs,ys);

train_set = transpose(data(:,1:N_train));

test_set = transpose(data(:,(N_train+1): (N_test+N_train)));










end
