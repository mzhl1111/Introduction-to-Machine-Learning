function [ train_err, test_err ] = AdaBoost( X_tr, y_tr, X_te, y_te, n_trees )



train_size  = size(X_tr,1);
test_size = size(X_te,1);
train_pred_pool = zeros(n_trees, train_size);
test_pred_pool = zeros(n_trees,test_size);
alpha = zeros(n_trees,1);
w = ones(train_size,1)./train_size;

for i = 1:n_trees
	model = fitctree(X_tr,y_tr,'minparent',train_size,'SplitCriterion','deviance','prune','off','mergeleaves','off','Weights',w);
	epsilon = sum(w .* (predict(model,X_tr)~= y_tr));

	if epsilon > 0.5 
		print(i-1);
		break
	end 

    % save the result of every week learner. 
	train_pred_pool(i,:) = predict( model, X_tr);
	test_pred_pool(i,:) = predict(model, X_te);

	alpha(i) = 0.5*log((1 - epsilon)/epsilon);
	Z = 2*sqrt(epsilon*(1 - epsilon));
	w = w .*(exp(-alpha(i) .*y_tr.* transpose(train_pred_pool(i,:))))/Z;

end 


train_tag = sign(sum(alpha .* train_pred_pool,1));
%tie = find(~train_tag);
%train_tag(tie) = datasample([-1,1],size(tie,2));
train_err = sum(train_tag ~= transpose(y_tr))/size(y_tr,1);

test_tag = sign(sum(alpha .* test_pred_pool,1));
%tie = find(~test_tag);
%test_tag(tie) = datasample([-1,1],size(tie,2));
test_err = sum(test_tag ~= transpose(y_te))/size(y_te,1);

end 