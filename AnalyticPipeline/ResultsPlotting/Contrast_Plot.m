% Usually you will calculate a contrast and then plot that contrast. 

% A contrast specifies a specific comparison or effect that you want to test 
% in your statistical model. It represents the difference in brain activation 
% between experimental conditions (e.g., Task vs. Baseline, Condition A > Condition B), 
% or the association between brain activity and a behavioral or demographic variable 
% (e.g., activation correlated with age).

% A contrast vector is a numerical representation of that comparison, tailored
% to the design matrix of your model. Each element of the vector corresponds to 
% one regressor (or column) in your design matrix. The values in the vector (e.g., 1, -1, 0) 
% define how much each regressor contributes to the contrast.
%% Contrast 

c = [1 0 0]; % contrast vector
Contrast = GroupStats.ttest(c);
Contrast_table = Contrast.table; % convert the contrast results to a table


%% Plot on 3D brain for hbo result
beta_oi = Contrast_table.tstat(1:2:end-1);
p_oi = Contrast_table.q(1:2:end-1);

intensity = beta_oi;
p=p_oi;
onlypositive = 1;

figure('Color',[1 1 1])

subplot(1,2,1)
plot3Dbrain_Ver2021(intensity,onlypositive,p,'Orig_32.mat') % Orig_32.mat will be a matrix containing the MNI coordinates

subplot(1,2,2)
plot3Dbrain_Ver2021(intensity,onlypositive,p,'Orig_32.mat')
view(90,0)