function [ test_Err] = BaggedTrees_testErr( X, Y,test_x,test_y, numBags )
%BAGGEDTREES Returns out-of-bag classification error of an ensemble of
%numBags CART decision trees on the input dataset, and also plots the error
%as a function of the number of bags from 1 to numBags
%   Inputs:
%       X : Matrix of training data
%       Y : Vector of classes of the training examples
%       numBags : Number of trees to learn in the ensemble
%
%   You may use "fitctree" but do not use "TreeBagger" or any other inbuilt
%   bagging function

bag_size = size(X,1);
test_err_record = zeros(numBags,size(test_x,1));
%ooberr_record = zeros(numBags,bag_size);
for i= 1: numBags
    index = datasample(1:bag_size, bag_size);
    %oob_index = setdiff(1:bag_size,unique(index));
    model = fitctree(X(index,:),  Y(index,:));
    %oob_label = predict(model,X(oob_index,:));
    %ooberr_record(i,oob_index) = oob_label;
    test_err_record(i,:) = predict(model, test_x);
end 
   test_pred = sum(test_err_record);
   tie = find(~test_pred);
   test_pred(tie) = datasample([-1,1],size(tie,2));
   test_Err = sum(sign(test_pred) ~= transpose(test_y))/size(test_y,1);
   
   
end
