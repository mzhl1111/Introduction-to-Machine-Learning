function[train_err,test_err]=scplot(X_tr, y_tr, X_te, y_te, max_trees)
    train_err=zeros(max_trees,1);
    test_err=zeros(max_trees,1);
    for j=1:max_trees
        [a,b]=AdaBoost(X_tr, y_tr, X_te, y_te,j);
        train_err(j,1)=a;
        test_err(j,1)=b;
    end

end