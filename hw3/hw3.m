train = csvread('clevelandtrain.csv',1,0);
train_x = train(:,1:13);
train_y =  train(:,14);

test = csvread('clevelandtest.csv',1,0);
test_x = test(:,1:13);
test_y = test(:,14);


[w_10k,e_10k] = logistic_reg(train_x,train_y,zeros(14,1),10000,0.00001);
[w_100k,e_100k] = logistic_reg(train_x,train_y,zeros(14,1),100000,0.00001);
[w_1m,e_1m] = logistic_reg(train_x,train_y,zeros(14,1),1000000,0.00001);


train_error_10k = find_test_error(w_10k,train_x,train_y)
test_error_10k = find_test_error(w_10k,test_x,test_y)

train_error_100k = find_test_error(w_100k,train_x,train_y)
test_error_100k = find_test_error(w_100k,test_x,test_y)

train_error_1m = find_test_error(w_1m,train_x,train_y)
test_error_1m = find_test_error(w_1m,test_x,test_y)




glm_w = glmfit(train_x,train(:,14) , 'binomial');

e_glm = sum(log(1+exp(-(2*train_y-1).*[ones(size(train_x,1),1) train_x]*glm_w)))/size(train_x,1)
glm_train_error = find_test_error(glmfit(train_x,train(:,14) , 'binomial'),train_x,train_y)
glm_test_error = find_test_error(glmfit(train_x,train(:,14) , 'binomial'),test_x,test_y)

glm_time = @() glmfit(train_x,train(:,14) , 'binomial');
glm_time = timeit(glm_time)
my_time = @() logistic_reg(train_x,train_y,zeros(14,1),1000000,0.00001);
my_time = timeit(my_time)

 stand_train_x = zscore(train_x);



[w_std1,e_std1, n_std1] = logistic_reg2(stand_train_x, train_y, zeros(14,1),0.1)

[w_std2,e_std2, n_std2] = logistic_reg2(stand_train_x, train_y, zeros(14,1),0.01)

[w_std3,e_std3, n_std3] = logistic_reg2(stand_train_x, train_y, zeros(14,1),0.001)

[w_std4,e_std4, n_std4] = logistic_reg2(stand_train_x, train_y, zeros(14,1),0.0001)

[w_std5,e_std5, n_std5] = logistic_reg2(stand_train_x, train_y, zeros(14,1),0.00001)

%[w_std6,e_std6, n_std6] = logistic_reg2(stand_train_x, train_y, zeros(14,1),0.000001);


train_error_std1 = find_test_error(w_std1,stand_train_x,train_y)
train_error_std2 = find_test_error(w_std2,stand_train_x,train_y)
train_error_std3 = find_test_error(w_std3,stand_train_x,train_y)
train_error_std4 = find_test_error(w_std4,stand_train_x,train_y)
train_error_std5 = find_test_error(w_std5,stand_train_x,train_y)

