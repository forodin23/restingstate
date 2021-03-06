function mt_fixationTask(dirRoot, fixRun)
% ** function mt_controlTask(user)
% This function initiates the fixation task.
%
% USAGE:
%     mt_fixationTask(user)
%
% >>> INPUT VARIABLES >>>
% NAME              TYPE        DESCRIPTION
% user              char       	pre-defined user name (see mt_loadUser.m)
%
%
% AUTHOR:   Marco R�th, contact@marcorueth.com
%           Jens Klinzing, jens.klinzing@uni-tuebingen.de

%% Load parameters specified in mt_setup.m
addpath(genpath(dirRoot));
load(fullfile(dirRoot, 'setup', 'mt_params.mat'))   % load workspace information and properties

if sendTrigger
    loadlibrary('trigger/inpoutx64', 'trigger/inpout32.h')
    port = hex2dec('0378'); % LPT1: 0378 - 037F, 0778 - 077F
    calllib('inpoutx64', 'Out32', port, 0)
end

%% Set window parameters
% Specify the display window 
window             = cfg_window.window(1);

%% Show instructions
if cfg_dlgs.sesstype == 1
    mt_showText(dirRoot, textFixation1, window);
elseif cfg_dlgs.sesstype == 2
    mt_showText(dirRoot, textFixation2, window);
elseif cfg_dlgs.sesstype == 3
    mt_showText(dirRoot, textFixation3, window);
else
    error('Invalid session type (not 1, 2, or 3)!')
end

%% Show fixation cross 
HideCursor(window);

% Save start time of fixation task
SessionTime         = {datestr(now, 'HH:MM:SS')};
TrialTime           = {datestr(now, 'HH:MM:SS.FFF')};
run                 = {''};
% dummies
correct             = {''};
imageShown          = {''};
imageClicked        = {''};
mouseData           = [0, 0, 0];
coordsShown         = {''};
coordsClicked       = {''};
performance         = table(SessionTime, TrialTime, run, correct, imageShown, imageClicked,  mouseData, coordsShown, coordsClicked);

mt_saveTable(dirRoot, performance, 0, 0)

% Draw the cross
% imageDot	= Screen('MakeTexture', window, imgDot);
% fixRect     = reshape(fixRect, 4, 1);
% Screen('DrawTexture', window, imageDot, [], fixRect);
Screen('Flip', window, flipTime);
% Screen('Close', imageDot);
if sendTrigger
    calllib('inpoutx64', 'Out32', port, EEGtriggerOn{cfg_dlgs.lab})
end
pause(fixationDisplay);
if sendTrigger
    calllib('inpoutx64', 'Out32', port, EEGtriggerOff{cfg_dlgs.lab})
end

% Save end time of fixation task
SessionTime         = {datestr(now, 'HH:MM:SS')};
TrialTime           = {datestr(now, 'HH:MM:SS.FFF')};
performance         = table(SessionTime, TrialTime, run, correct, imageShown, imageClicked,  mouseData, coordsShown, coordsClicked);
mt_saveTable(dirRoot, performance, 0, 0)


end