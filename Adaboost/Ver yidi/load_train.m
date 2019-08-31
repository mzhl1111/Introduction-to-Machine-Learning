load zip.train;

subsample= zip(find(zip(:,1)==1 | zip(:,1) == 3),:);
Y_tr = subsample(:,1);
X_tr = subsample(:,2:257);
Y_tr=Y_tr-2;

subsample2= zip(find(zip(:,1)==5 | zip(:,1) == 3),:);
Y_tr2 = subsample2(:,1);
X_tr2 = subsample2(:,2:257);
Y_tr2=Y_tr2-4;