function [ train_err, test_err ] = AdaBoost( X_tr, y_tr, X_te, y_te, n_trees )
%AdaBoost: Implement AdaBoost using decision stumps learned
%   using information gain as the weak learners.
%   X_tr: Training set
%   y_tr: Training set labels
%   X_te: Testing set
%   y_te: Testing set labels
%   n_trees: The number of trees to use

D = ones(1,n_trees)/n_trees;
X_size = size(X_tr,1);
model_pool = cell(1,n_trees);
train_err_recorder = 1; 
for i = 1:n_trees
    index = datasample(1:X_size, X_size);
    model = fitctree(X_tr(index,:),  y_tr(index,:),'SplitCriterion','deviance');
    model_pool(i) = model;
    train_error = sum(D .* (predict(model,X_tr)~= y_tr));
    if train_error <= train_err_recorder
        train_err_recorder= train_error;
    end 
    if train_error > 0.5
        n_trees = i-1;
        break
    end
   beta = train_error/(1-train_error);
   Z = 2*sqrt(train_error*(1-train_error));
   D = D .*((predict(model,X_tr)== y_tr)*(beta-1) +1 )/Z;
   
end

test_tag_pool = zeros(n_trees,size(X_tr,1));

for j = i:n_trees
    test_tag_pool(1,:) = D .* (predict(model_pool(i),X_te)-4);
end 

test_tag = sign(sum(test_tag_pool));
tie = find(~test_tag);
test_tag(tie) = datasample([-1,1],size(tie,2));

test_tag = test_tag+4;
test_err = sum(test_tag ~= y_te)/size(y_te,1);

train_err = train_err_recorder;






    
    
    






end

