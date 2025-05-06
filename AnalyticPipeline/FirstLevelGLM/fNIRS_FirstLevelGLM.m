%% fNIRS Data Analyses general pipeline part 1 - preprocess and first level glm
% Created by Xiaosu Frank Hu 2/8/2025

%% Preprocessing & GLM First (individual) Level Analyses

% Data Analyses Pipile as listed below using Huppert et al NIRS Toolbox and
% inidividualized scripts created by Frank Hu.

% 2. Preprocessing
%    - Add SS channel
%    - Resample data at lower frequency
%    - MBLL to Hb data
%    - Trim the data section not needed for first level GLM
% 3. Subject (1st) Level GLM
% 4. Demographic variable add

%% Define data directory and load raw rataset
clear
% use this line to select data dir by GUI
datadir = uigetdir(); 
% or use this line to specify your data dir directly
% datadir = 'PATH TO YOUR DATA DIR'; 

%load Data with different levels, the group task and subjet will be used as
%demographics
% rawdata = nirs.io.loadDirectory(datadir, {'Group', 'Task', 'Subject'});
rawdata = nirs.io.loadDirectory(datadir, {'Group','Subject'});
% rawdata = nirs.io.loadDirectory(datadir, {'Subject'});

%% Initialize GLM (Subject-Level) 
% label short separation channels if you use SS in your data collection
disp('Adding SS to the pipeline...')
j_ss = nirs.modules.LabelShortSeperation();
rawdata = j_ss.run(rawdata);

% optical density conversion
disp('Converting Optical Density...')
odconv=nirs.modules.OpticalDensity();
od=odconv.run(rawdata);

% Optional TDDR motion correction
disp('TDDR step...')
tddr = nirs.modules.TDDR();
tddr.usePCA = 1; 
od=tddr.run(od);

% Downsample the data
disp('Running data resample...')
resample=nirs.modules.Resample();
resample.Fs=2; % Resample the data to 2 Hz
downod=resample.run(od);

% Modified Beer-Lambert law to get HbO and HbR data
disp('Applying  Modified Beer Lambert Law...')
mbll=nirs.modules.BeerLambertLaw();
hb=mbll.run(downod);

% Trimming the timeseries to remove the unnecessary sections
disp('Trimming .nirs files...')
trim=nirs.modules.TrimBaseline();
trim.preBaseline=5; % 5 sec before the first stim
trim.postBaseline=5; % 5 sec after the last stim
hb_trim=trim.run(hb);

% save('Data_preprocessed_hb.mat','hb_trim','-v7.3','-nocompression')

%% First level analysis
disp('Now running subject-level GLM!')
firstlevelglm=nirs.modules.GLM();

firstlevelglm.type = 'AR-IRLS';
firstlevelglm.AddShortSepRegressors = true; % SS channel set up

firstlevelbasis = nirs.design.basis.Canonical();
% Adding temporal & dispersion derivatives to canonical HRF function
% firstlevelbasis.incDeriv=1;

% DCT matrix to account for signal drift over time
% firstlevelglm.trend_func=@(t) nirs.design.trend.dctmtx(t,0.008);

% HRF peak time = 6s based on Friederici and Booth papers (e.g. Brauer, Neumann & Friederici, 2008, NeuroImage)
firstlevelbasis.peakTime = 6;

% Run
firstlevelglm.basis('default') = firstlevelbasis;
SubjStats=firstlevelglm.run(hb_trim);
disp('Ready to save SubjStats...')

save('SubjStats.mat','SubjStats','-v7.3','-nocompression')
disp('Done!')

%% Add Age & Gender for demographic as example
% the path to a csv file containing demographics
% NOTE:if you are using mac, you may gets an error when reading the table

Demo = nirs.modules.AddDemographics();
Demo.demoTable = readtable('./Demographic_fake.csv');
Demo.varToMatch='Subject';
SubjStats = Demo.run(SubjStats);

