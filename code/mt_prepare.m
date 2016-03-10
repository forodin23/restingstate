function dirRoot = mt_prepare(user)
% ** function dirRoot = mt_prepare(user)
% Initialization procedure for configuration. 
%
% 
% AUTHOR:   Marco Rüth, contact@marcorueth.com
%           Jens Klinzing, jens.klinzing@uni-tuebingen.de

if ~nargin
    user = [];
end

% Generate workspace variables defined in mt_setup.m
dirRoot = mt_setup(user);

% Prompt to collect information about experiment
mt_dialogues(dirRoot);

try
    sca;                % Clear all features related to PTB
    mt_window(dirRoot);
catch ME
    fprintf(['Opening a fullscreen window using Psychtoolbox was unsuccessful.\n', ...
        'Check variable dirPTB in mt_setup and check configuration of graphics card/driver.\n'])
    error(ME.message)
end
end