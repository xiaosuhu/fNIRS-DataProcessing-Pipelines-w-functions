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
grouplevelpipeline.dummycoding = 'full';

grouplevelpipeline.formula ='beta ~ -1 + cond + (1|Subject)';
% categorial variable 
% grouplevelpipeline.formula ='beta ~ -1 + group:cond + (1|Subject)';
% grouplevelpipeline.formula ='beta ~ -1 + group:task:cond + (1|Subject)';

% add controlling variable for the intercept
% grouplevelpipeline.formula ='beta ~ -1 + group:task:cond + age + (1|Subject)';

% add controlling variable for the slope
% grouplevelpipeline.formula ='beta ~ -1 + group:task:cond + (age|Subject)';

GroupStats= grouplevelpipeline.run(SubjStats);
% draw the results
% GroupStats.draw('tstat',[-4 4]);