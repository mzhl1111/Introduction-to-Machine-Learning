function [ overfit_m ] = computeOverfitMeasure( true_Q_f, N_train, N_test, var, num_expts )
%COMPUTEOVERFITMEASURE Compute how much worse H_10 is compared with H_2 in
%terms of test error. Negative number means it's better.
%   Inputs
%       true_Q_f: order of the true hypothesis
%       N_train: number of training examples
%       N_test: number of test examples
%       var: variance of the stochastic noise
%       num_expts: number of times to run the experiment
%   Output
%       overfit_m: vector of length num_expts, reporting each of the
%                  differences in error between H_10 and H_2


overfit_m = zeros(num_expts,1);

for i = 1:num_expts
    [train, test] = generate_dataset(true_Q_f,N_train,N_test,sqrt(var));
    train_x = train(:,1);
    train_y = train(:,2);
    test_x = test(:,1);
    test_y = test(:,2);
    
    H_2_x = [train_x train_x.^2];
    H_10_x = [train_x train_x.^2 train_x.^3 train_x.^4 train_x.^5 train_x.^6 train_x.^7 train_x.^8 train_x.^9 train_x.^10];
    H_2_w = glmfit(H_2_x,train_y,'normal','constant','off');
    H_10_w = glmfit(H_10_x,train_y,'normal','constant','off');
    
    
    test_error_2 = sum((test_y - [test_x.^1 test_x.^2]* H_2_w).^2)/N_test;
    test_error_10 = sum((test_y - [test_x.^1 test_x.^2 test_x.^3 test_x.^4 test_x.^5 test_x.^6 test_x.^7 test_x.^8 test_x.^9 test_x.^10]* H_10_w).^2)/N_test;
    
    overfit_m(i) = -test_error_2 + test_error_10;
    
end


end