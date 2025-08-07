function [intensity,p] = getIntensity(c,GroupStats,fdr,type)
%%
% This function does contrast and extract t-value and associated threshold
% p, or q(fdr corrected p)

% Input:
% c: contrast vector
% GroupStats: group level stats
% fdr: 1 or 0, 1= fdr
% type: 'hbo' or 'hbr'

% By Frank Hu, 3/26/2025
%%
Contrast=GroupStats.ttest(c);
Contrasttable=Contrast.table;
% intensity=Contrasttable.tstat(strcmp(Contrasttable.type,'hbo')&ismember(Contrasttable.source,[1 2 3 4 5 6 7 8]));

intensity=Contrasttable.tstat(strcmp(Contrasttable.type,type));
if fdr
    p=Contrasttable.q(strcmp(Contrasttable.type,type));
else
    p=Contrasttable.p(strcmp(Contrasttable.type,type));
end

end

