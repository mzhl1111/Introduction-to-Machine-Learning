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

train_x = zeros(N_train,1);
train_y = zeros(N_train,1);
train_a = normrnd(0,1,[1,Q_f+1]) / sum(sqrt(1./(1:2:(2*Q_f+2))));



for i = 1:N_train
    train_x(i) = 2*rand(1)-1;
    for j = 0:Q_f
        train_y(i)= train_y(i) + train_a(i)*computeLegPoly(train_x(i),j);
    end  
    train_y(i) = train_y(i)+sigma*normrnd(0,1);
end 

test_x = zeros(N_test,1);
test_y = zeros(N_test,1);
for i = 1:N_test
    test_x(i) = 2*rand(1)-1;
    for j = 0:Q_f
        test_y(i)= test_y(i) + train_a(i)*computeLegPoly(test_x(i),j);
    end  
    test_y(i) = test_y(i)+sigma*normrnd(0,1);
end 
train_set = [train_x train_y];
test_set = [test_x test_y];

end
