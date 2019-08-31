function [eps,train_err, test_err ] = AdaBoost( X_tr, y_tr, X_te, y_te, n_trees )
%AdaBoost: Implement AdaBoost using decision stumps learned
%   using information gain as the weak learners.
%   X_tr: Training set
%   y_tr: Training set labels
%   X_te: Testing set
%   y_te: Testing set labels
%   n_trees: The number of trees to use

[n,p]=size(X_tr);
w=ones(n,1)./n; 
%the initial input weights are w1=w2=...=wn=1/n
[n_te,p_te]=size(X_te);

result_tr=zeros(n,n_trees);
result_te=zeros(n_te,n_trees);
%build two matrix to restore the predicting results.

alpha=zeros(n_trees,1);
eps=zeros(n_trees,1);

for i=1:n_trees

ct2=fitctree(X_tr,y_tr,'minparent',size(X_tr,1),'SplitCriterion','deviance','prune','off','mergeleaves','off','Weights',w);
%ct2 is the decision stumps learned using information gain as the weak
%learners as we used 'SplitCriterion'='deviance'. Also, when we train the
%weak learner, we minimizie the weighted training error (information gain)
%and the weights are w.

result_tr(:,i)=predict(ct2,X_tr);
%restore the predicting results of the training data by this weak learner.
result_te(:,i)=predict(ct2,X_te);
%restore the predicting results of the testing data by this weak learner.
eps(i,1)=sum(w.*(result_tr(:,i)~=y_tr));
alpha(i,1)=0.5*log((1-eps(i,1))/eps(i,1));
Z=2*sqrt(eps(i,1)*(1-eps(i,1)));
w=w./Z.*exp(-alpha(i,1).*(result_tr(:,i).*y_tr));
%update the weight

end

g_tr=sign((result_tr*alpha));
%calculate g(traindata)
g_te=sign((result_te*alpha));
%calculate g(testdata)

train_err=1/n*sum(g_tr~=y_tr);
test_err=1/n_te*sum(g_te~=y_te);
