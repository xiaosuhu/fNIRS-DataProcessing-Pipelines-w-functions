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
%%
% I have made a function that takes in contrast vector and group level
% stats and return intensity and p(q) values for plotting

% function [intensity,p] = getIntensity(c,GroupStats,fdr,type)

% This function does contrast and extract t-value and associated threshold
% p, or q(fdr corrected p)

% Input:
% c: contrast vector
% GroupStats: group level stats
% fdr: 1 or 0, 1= fdr
% type: 'hbo' or 'hbr'

% By Frank Hu, 3/26/2025

%% Plot on 3D brain for hbo result -- Now this is based on the sample data
% see group level and first level analysis for how to get GroupStats
c = [1 0 0 0 0 0 0]; % This is to get the age related correlation
fdr = 0;
type = 'hbo';
onlypositive = 1;
coord_file = './Example_dataset/MNICoord_for_Plot/Orig_32.mat';

[intensity,p] = getIntensity(c,GroupStats,fdr,type);


figure('Color',[1 1 1]) % Specifies a white background

subplot(1,2,1)
plot3Dbrain_Ver2021(intensity,onlypositive,p,coord_file,'mx',4,'mn',-4); % mx and mn is the max and min scale for the plot

subplot(1,2,2)
plot3Dbrain_Ver2021(intensity,onlypositive,p,coord_file,'mx',4,'mn',-4);
view(90,0)