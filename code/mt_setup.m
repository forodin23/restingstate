function dirRoot = mt_setup(user)
% ** function mt_setup(user) 
% This script allows to adjust the most important parameters for the memory
% task. Define the variables here before you run mt_run.m.
% 
% IMPORTANT:    Do not change the order in which the variables are defined.
%               Some variables have mutual dependencies.
%
% >>> INPUT VARIABLES >>>
% NAME              TYPE        DESCRIPTION
% user              char       	pre-defined user name (see mt_loadUser.m)

% <<< OUTPUT VARIABLES <<<
% NAME              TYPE        DESCRIPTION
% dirRoot           char        path to root working directory
%
% 
% AUTHOR:   Marco R�th, contact@marcorueth.com
%           Jens Klinzing, jens.klinzing@uni-tuebingen.de

%% ============================== BASICS ================================ %
% IMPORTANT: add your user profile in mt_loadUser
[dirRoot, dirPTB]   = mt_profile(user);

% Expermimental Details
experimentName      = 'Sleep Connectivity'; % name of your study
nLearningSess       = 3; % number of learning runs for learning
nInterferenceSess   = 3; % number of learning runs for interference
nMinRecall          = 1; % minimum runs for immediate recall (with feedback)
nMaxRecall          = 1; % maximum runs for immediate recall (to exclude if too poor performance)
nFinalRecall        = 1; % number of runs for final recall (incl. one last session w/o feedback)
RecallThreshold     = 40;% miniumum correct answers in recall (in percent)
fixationDisplay     = (8 * 60);     % Duration of fixation task

% System
% screenNumber    = 2; % select specific screen
priority_level      = 0; % 'max' or number, put 0 if you don't have privileged rights

EEGtrigger          = 0;
EEGtriggerOn        = {0, 64, 4};
EEGtriggerOff       = {0, 128, 8};


%% ================================ TEXT ================================ %
% Text strings used during the program

textFixation1 = { ...
    ''
    'Anweisung:'
    ''
    'Es ist wichtig, dass du bei der Aufgabe nicht einschl�fst.'
    ''
    ['Dies wird etwa ' num2str(fixationDisplay/60) ' Minuten dauern.']
};
textFixation2 = { ...
    ''
    'Anweisung:'
    ''
    'Denke bitte an die gelernten Bildpaare und wo sie sind.'
    ''
    'Es ist wichtig, dass du bei der Aufgabe nicht einschl�fst.'
    ''
    ['Dies wird etwa ' num2str(fixationDisplay/60) ' Minuten dauern.']
};
textFixation3 = { ...
    ''
    'Anweisung:'
    ''
    'Denke bitte an die gelernten Bildpaare und wo sie sind.'
    ''
    'Es ist wichtig, dass du bei der Aufgabe nicht einschl�fst.'
    ''
    ['Dies wird etwa ' num2str(fixationDisplay/60) ' Minuten dauern.']
}; 
textFixationWait = { ...
    ''
    ['Wait for ' fixationDisplay ' min.']
};
textOutro = { ...
    ''
    ''
    ''
    'Ende'
    ''
    'Vielen Dank!'
    ''
};

% Text Properties
textDefSize     = 25;           % default Text Size
textDefFont     = 'Arial';      % default Text Font
textDefColor    = [0 0 0];      % default Text Color
textSx          = 'center';     % default Text x-position
textSy          = 10;           % default Text y-position
textVSpacing    = 2;            % default Text vertical line spacing


%% ============================== OPTIONAL ============================== %
% Change Cursor Type
CursorType          = 'Arrow';

% Set Display properties
% Define which window size is used as reference to display the cards
windowSize          = get(0, 'MonitorPositions'); % [1024 768];
windowSize          = [(4/3 * windowSize(end)) windowSize(end)];
screenBgColor       = [1 1 1]*0.9; % greyish background
textBgColor         = [1 1 1]*0.9; % greyish background

% Define which display window is used (put a number)
% Note: by default external screens are automatically used if connected 
% window              = ;


%% ======================= DO NOT CHANGE FROM HERE ====================== %
% Unless you know what you are doing...
% !!!!! Changes need further adjustments in other files and scripts !!!!! %

% Folder for configurations
setupdir            = fullfile(dirRoot, 'setup');
if ~exist(setupdir, 'dir')
    mkdir(setupdir) % create folder in first run
end

dirData = dirRoot;
dirSplit = strsplit(dirRoot,'\');
if strcmp(dirSplit(end), '')
    dirData = dirRoot(1:end-1);
    dirData = strrep(dirData, dirSplit(end-1), '');
else
    dirData = strrep(dirData, dirSplit(end), '');
end
dirData = dirData{:};
% Folder for data
if ~exist(fullfile(dirData, 'DATA'), 'dir')
    mkdir(fullfile(dirData, 'DATA')) % create folder in first run
    mkdir(fullfile(dirData, 'BACKUP'))
end

% Changing the accepted cases also requires to change mt_dialogues.m
cfg_cases.nights    = {'1', '2'};                       % Night 1 or 2
cfg_cases.sesstype  = {'1', '2', '3'};                  % Session Type
cfg_cases.lab       = {'SL3', 'SL4'};                   % Lab/Location
cfg_cases.sessNames = {'Pre-Learning', 'Post-Learning', 'Post-Recall'};

% Save configuration in workdir
cd(dirRoot)
save(fullfile(setupdir, 'mt_params.mat'))
end