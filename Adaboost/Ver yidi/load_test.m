load zip.test;

subsample_test = zip(find(zip(:,1)==1 | zip(:,1) == 3),:);
Y_te= subsample_test(:,1);
X_te= subsample_test(:,2:257);
Y_te=Y_te-2;

subsample_test2 = zip(find(zip(:,1)==5 | zip(:,1) == 3),:);
Y_te2= subsample_test2(:,1);
X_te2= subsample_test2(:,2:257);

Y_te2= Y_te2-4;

