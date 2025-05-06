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

%% Plot on 3D brain for hbo result
c = [1 0];
fdr = 0;
type = 'hbo';
flex_scale = 0;
coord_file = 'path-to-your-coordfile.mat';

[intensity,p] = getIntensity(c,GroupStats,fdr,type);

onlypositive = 1;

figure('Color',[1 1 1]) % Specifies a white background

subplot(1,2,1)
plot3Dbrain_Ver2021(intensity,onlypositive,p,coord_file,flex_scale) % Orig_32.mat will be a matrix containing the MNI coordinates

subplot(1,2,2)
plot3Dbrain_Ver2021(intensity,onlypositive,p,coord_file,flex_scale)
view(90,0)