%% fNIRS Data Analyses general pipeline part 2 - group level linear mixed effects model
% Created by Xiaosu Frank Hu 2/8/2025

%% Second (group) Level Analyses

% Data Analyses Pipile as listed below using Huppert et al NIRS Toolbox and
% inidividualized scripts created by Frank Hu.

% 1. Group Level (2nd) GLM (mixed effects)
% 2. Group Contrasts & Statistics

%% GLM group level analyses (mixed effects) - dummy coding = reference
% Initalize GLM
grouplevelpipeline = nirs.modules.MixedEffects();
% to use robust regression also for the group level, but will take longer time
% grouplevelpipeline.robust=true; 
grouplevelpipeline.dummycoding = 'reference';

%% mixed ANCOVA with random effect
grouplevelpipeline.formula ='beta ~ group*cond + age + (1|Subject)';

%% NOTE if you remove age and reandom effect, this will become a standard
% ANOVA
% grouplevelpipeline.formula ='beta ~ group*cond';

%% add controlling variable for the slope
% grouplevelpipeline.formula ='beta ~ -1 + group*task*cond + (age|Subject)';

%%
GroupStats= grouplevelpipeline.run(SubjStats);
% draw the results
% GroupStats.draw('tstat',[-4 4]);


