intensity = zeros(32,1);
intensity([2 19])=1;
intensity([9 28 29])=-1;

onlypositive = 0;
p = ones(32,1) * 0.01;
coordfile = 'Orig_32';

%% POR coordinates check with labels
figure

% subplot(1,2,1)
plot3Dbrain_Ver2021_wlabel(intensity,onlypositive,p,coordfile, 1)
