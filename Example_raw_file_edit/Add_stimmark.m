%% Add stim marks to fNIRS raw file with only the first stim mark
% Created by Xiaosu Frank Hu 9/8/2025

%%

% Load the data file
load('test0_no_stim.nirs','-mat');

% Load the time file
T=readtable('time_table.csv');

c1_time = T.cond1;
c2_time = T.cond2;

% calc the freq of the data
fs=1/mean(diff(t));

% make a temp s to store the updated stim vector
s_tmp = zeros(length(s), 2);

% get the start point of the stim marks
s_start = find(diff(s)==-1);

% calc the time points in fNIRS data
c1_time_pts = c1_time .* fs + s_start;
c2_time_pts = c2_time .* fs + s_start;

% asign s_tmp with the stim marks
s_tmp(round(c1_time_pts), 1) = 1;
s_tmp(round(c2_time_pts), 2) = 1;

s = s_tmp;

% save the file back
save('test0_w_stim.nirs','t','SD','d','aux','s');
