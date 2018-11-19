% Script to load data from zip.train, filter it into datasets with only one
% and three or three and five, and compare the performance of plain
% decision trees (cross-validated) and bagged ensembles (OOB error)
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



fprintf('Working on the one-vs-three problem...\n\n');

%%%%%%%%%%%%%%%%%%%%%  a) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
recorder = zeros(1,100);
for i = 1:100
    recorder(i) = BaggedTrees(X_tr, Y_tr, i);
    if rem(i,20)==0 
        fprintf('=')
    end 
end 


%%%%%%%%%%%%%%%%%%%% b) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ct = fitctree(X_tr,Y_tr,'CrossVal','on');
fprintf('The cross-validation error of decision trees is %.4f\n', ct.kfoldLoss);
bee = BaggedTrees(X_tr, Y_tr, 200);
fprintf('The OOB error of 200 bagged decision trees is %.4f\n', bee);

%%%%%%%%%%%%%%%%%%%% c)    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ct = fitctree(X_tr,Y_tr);
fprintf('The TEST error of decision trees is %.4f\n', sum(predict(ct, X_te) ~= Y_te)/430 );
bee = BaggedTrees_testErr( X_tr, Y_tr,X_te, Y_te, 200);
fprintf('The TEST error of 200 bagged decision trees is %.4f\n', bee);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fprintf('\nNow working on the three-vs-five problem...\n\n');

%%%%%%%%%%%%%%%%%%%%%%%%%  a) %%%%%%%%%%%%%%%%%%%%%%%%%%%%
recorder1 = zeros(1,100);
for i = 1:100
    recorder1(i) = BaggedTrees(X_tr2, Y_tr2, i);
    if rem(i,20)==0 
        fprintf('=')
    end 
end 
plot(1:100,recorder1,1:100,recorder)
%%%%%%%%%%%%%%%%%%%%%%%%%  b) %%%%%%%%%%%%%%%%%%%%%%%%%%%%
ct = fitctree(X_tr2,Y_tr2,'CrossVal','on');
fprintf('The cross-validation error of decision trees is %.4f\n', ct.kfoldLoss);
bee = BaggedTrees(X_tr2, Y_tr2, 200);
fprintf('The OOB error of 200 bagged decision trees is %.4f\n', bee);

%%%%%%%%%%%%%%%%%%%%%%%%%  c) %%%%%%%%%%%%%%%%%%%%%%%%%%%%

ct = fitctree(X_tr2,Y_tr2);
fprintf('The TEST error of decision trees is %.4f\n', sum(predict(ct, X_te2) ~= Y_te2)/size(Y_te2,1) );
bee = BaggedTrees_testErr( X_tr2, Y_tr2,X_te2, Y_te2, 200);
fprintf('The TEST error of 200 bagged decision trees is %.4f\n', bee);





