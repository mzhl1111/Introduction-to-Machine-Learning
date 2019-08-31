%Script that runs the set of necessary experiments

Q_f = 5:5:20; % Degree of true function
N = 40:40:120; % Number of training examples
var = 0:0.5:2; % Variance of stochastic noise

expt_data_mat = zeros(length(Q_f), length(N), length(var));
expt_data_mat_median = zeros(length(Q_f), length(N), length(var));
for ii = 1:length(Q_f)
    for jj = 1:length(N)
        for kk = 1:length(var)
            expt_data_mat(ii,jj,kk) = mean(computeOverfitMeasure(Q_f(ii),N(jj),1000,var(kk),500));
        end
    end
    fprintf('.');
end
 
for ii = 1:length(Q_f)
    for jj = 1:length(N)
        for kk = 1:length(var)
            expt_data_mat_median(ii,jj,kk) = median(computeOverfitMeasure(Q_f(ii),N(jj),1000,var(kk),500));
        end
    end
    fprintf('+');
end

% Same deterministic noise, different N and level of stochastic noise 

subplot(4,1,1)
plot(transpose(vertcat(expt_data_mat(1,:,1),expt_data_mat(1,:,2),expt_data_mat(1,:,3),expt_data_mat(1,:,4),expt_data_mat(1,:,5))))
subplot(4,1,2)
plot(transpose(vertcat(expt_data_mat(2,:,1),expt_data_mat(2,:,2),expt_data_mat(2,:,3),expt_data_mat(2,:,4),expt_data_mat(2,:,5))))
subplot(4,1,3)
plot(transpose(vertcat(expt_data_mat(3,:,1),expt_data_mat(3,:,2),expt_data_mat(3,:,3),expt_data_mat(3,:,4),expt_data_mat(3,:,5))))
subplot(4,1,4)
plot(transpose(vertcat(expt_data_mat(4,:,1),expt_data_mat(4,:,2),expt_data_mat(4,:,3),expt_data_mat(4,:,4),expt_data_mat(4,:,5))))

% Same stochastic noise, different N and deterministic noise 
subplot(5,1,5)
plot(transpose(expt_data_mat(:,:,5)))
subplot(5,1,4)
plot(transpose(expt_data_mat(:,:,4)))
subplot(5,1,3)
plot(transpose(expt_data_mat(:,:,3)))
subplot(5,1,2)
plot(transpose(expt_data_mat(:,:,2)))
subplot(5,1,1)
plot(transpose(expt_data_mat(:,:,1)))

subplot(3,1,1)
plot(horzcat( expt_data_mat(:,1,1),expt_data_mat(:,1,2),expt_data_mat(:,1,3),expt_data_mat(:,1,4),expt_data_mat(:,1,5)))
subplot(3,1,2)
plot(horzcat( expt_data_mat(:,2,1),expt_data_mat(:,2,2),expt_data_mat(:,2,3),expt_data_mat(:,2,4),expt_data_mat(:,2,5)))
subplot(3,1,3)
plot(horzcat( expt_data_mat(:,3,1),expt_data_mat(:,3,2),expt_data_mat(:,3,3),expt_data_mat(:,3,4),expt_data_mat(:,3,5)))


%#######################################################################################

% median 

subplot(4,1,1)
plot(transpose(vertcat(expt_data_mat_median(1,:,1),expt_data_mat_median(1,:,2),expt_data_mat_median(1,:,3),expt_data_mat_median(1,:,4),expt_data_mat_median(1,:,5))))
subplot(4,1,2)
plot(transpose(vertcat(expt_data_mat_median(2,:,1),expt_data_mat_median(2,:,2),expt_data_mat_median(2,:,3),expt_data_mat_median(2,:,4),expt_data_mat_median(2,:,5))))
subplot(4,1,3)
plot(transpose(vertcat(expt_data_mat_median(3,:,1),expt_data_mat_median(3,:,2),expt_data_mat_median(3,:,3),expt_data_mat_median(3,:,4),expt_data_mat_median(3,:,5))))
subplot(4,1,4)
plot(transpose(vertcat(expt_data_mat_median(4,:,1),expt_data_mat_median(4,:,2),expt_data_mat_median(4,:,3),expt_data_mat_median(4,:,4),expt_data_mat_median(4,:,5))))

% Same stochastic noise, different N and deterministic noise 
subplot(5,1,5)
plot(transpose(expt_data_mat_median(:,:,5)))
subplot(5,1,4)
plot(transpose(expt_data_mat_median(:,:,4)))
subplot(5,1,3)
plot(transpose(expt_data_mat_median(:,:,3)))
subplot(5,1,2)
plot(transpose(expt_data_mat_median(:,:,2)))
subplot(5,1,1)
plot(transpose(expt_data_mat_median(:,:,1)))

subplot(3,1,1)
plot(horzcat( expt_data_mat_median(:,1,1),expt_data_mat_median(:,1,2),expt_data_mat_median(:,1,3),expt_data_mat_median(:,1,4),expt_data_mat_median(:,1,5)))
subplot(3,1,2)
plot(horzcat( expt_data_mat_median(:,2,1),expt_data_mat_median(:,2,2),expt_data_mat_median(:,2,3),expt_data_mat_median(:,2,4),expt_data_mat_median(:,2,5)))
subplot(3,1,3)
plot(horzcat( expt_data_mat_median(:,3,1),expt_data_mat_median(:,3,2),expt_data_mat_median(:,3,3),expt_data_mat_median(:,3,4),expt_data_mat_median(:,3,5)))
