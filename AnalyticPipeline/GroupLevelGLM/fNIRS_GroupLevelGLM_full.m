%% fNIRS Data Analyses general pipeline part 2 - group level linear mixed effects model
% Created by Xiaosu Frank Hu 2/8/2025

%% Second (group) Level Analyses

% Data Analyses Pipile as listed below using Huppert et al NIRS Toolbox and
% inidividualized scripts created by Frank Hu.

% 1. Group Level (2nd) GLM (mixed effects)
% 2. Group Contrasts & Statistics
% 3. ANOVA

%% GLM group level analyses (mixed effects) - dummy coding = full
% Initalize GLM
grouplevelpipeline = nirs.modules.MixedEffects();
% to use robust regression also for the group level, but will take longer time
% grouplevelpipeline.robust=true; 
grouplevelpipeline.dummyCoding = 'full';

% grouplevelpipeline.formula ='beta ~ -1 + cond + (1|Subject)';

%% categorial variable 
% grouplevelpipeline.formula ='beta ~ -1 + Group:cond + (1|Subject)';

%% add controlling variable for the intercept
grouplevelpipeline.formula ='beta ~ -1 + Group:cond + Age + (1|Subject)';

%% add controlling variable for the slope
% grouplevelpipeline.formula ='beta ~ -1 + Group:cond + (age|Subject)';

%%
GroupStats= grouplevelpipeline.run(SubjStats);

% draw the results - simple version
% GroupStats.draw('tstat',[-4 4]);