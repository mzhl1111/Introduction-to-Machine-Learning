
n =50;

load zip.train;

subsample= zip(find(zip(:,1)==1 | zip(:,1) == 3),:);
Y_tr = subsample(:,1);
X_tr = subsample(:,2:257);
Y_tr=Y_tr-2;

subsample2= zip(find(zip(:,1)==5 | zip(:,1) == 3),:);
Y_tr2 = subsample2(:,1);
X_tr2 = subsample2(:,2:257);
Y_tr2=Y_tr2-4;

load zip.test;

subsample_test = zip(find(zip(:,1)==1 | zip(:,1) == 3),:);
Y_te= subsample_test(:,1);
X_te= subsample_test(:,2:257);
Y_te=Y_te-2;

subsample_test2 = zip(find(zip(:,1)==5 | zip(:,1) == 3),:);
Y_te2= subsample_test2(:,1);
X_te2= subsample_test2(:,2:257);

Y_te2= Y_te2-4;


[c,d] = scplot(X_tr,Y_tr, X_te,Y_te,n);
[e,f] = scplot(X_tr2,Y_tr2, X_te2,Y_te2,n);

subplot(2,1,1)
plot(1:n,c,1:n,d)
subplot(2,1,2)
plot(1:n,e,1:n,f)

