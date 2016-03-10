function mt_run(user)
% ** function mt_run(user)
% Main function that runs the resting state task. 
%
% All this is an adaptation of the far larger memory task program
% 'sleepmemory'. This is why there is some legacy code that is not really
% necessary.
%
% IMPORTANT: 
%  First you need to adjust the variables in "mt_setup.m"
%
% USAGE:
%       mt_run('user'); % works if user is specified in mt_profile
%
% Notes: 
%   fast/debug mode: enter 0 (zero) when prompted for subject number
%
% >>> INPUT VARIABLES >>>
% NAME              TYPE        DESCRIPTION
% user              char       	pre-defined user name (see mt_profile.m)
%
% 
% AUTHOR:   Jens Klinzing, jens.klinzing@uni-tuebingen.de

% Uncomment to get a half-transparent screen
% PsychDebugWindowConfiguration(0,.5)

%% PREPARE WORKSPACE & REQUEST USER INPUT
close all;                  % Close all figures
clearvars -except user;     % Clear all variables in the workspace

% Initialize workspace; includes user dialogues
dirRoot         = mt_prepare(user); 

% Load workspace information and properties
try
    load(fullfile(dirRoot, 'setup', 'mt_params.mat'))
    window      = cfg_window.window(1);
catch ME
    fprintf(['mt_params.mat could not be loaded.\n', ...
        'Check the save destination folder in mt_setup.m and parameter settings.\n'])
    error(ME.message)
end

%% START    

mt_fixationTask(dirRoot, fixRun);

% Show final screen
ShowCursor(CursorType, window);
mt_showText(dirRoot, textOutro, window, [], 1);
sca;
end