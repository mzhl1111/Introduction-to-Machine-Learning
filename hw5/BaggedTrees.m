function [ oobErr ] = BaggedTrees( X, Y, numBags )
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
ooberr_record = zeros(numBags,size(X,1));
for i= 1: numBags
    index = datasample(1:bag_size, bag_size);
   oob_index = setdiff(1:bag_size,unique(index));
    model = fitctree(X(index,:),  Y(index,:));
    oob_label = predict(model,X(oob_index,:));
    %ooberr_record(i,oob_index) = oob_label ~= Y(oob_index,:);
    ooberr_record(i,:) = predict(model,X)-4;
end 

   
end
