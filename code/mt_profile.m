function [dirRoot, dirPTB] = mt_profile(user)
% ** function mt_profile(user)
% Loads user-specific root directory and Psychtoolbox installation folder
%
% USAGE:
%       [dirRoot, dirPTB]   = mt_profile(user);
%
% >>> INPUT VARIABLES >>>
% NAME              TYPE        DESCRIPTION
% user              char       	user name
%
% <<< OUTPUT VARIABLES <<<
% NAME              TYPE        DESCRIPTION
% dirRoot           char        path to root working directory
% dirPTB            char        path to Psychtoolbox installation folder
%
% 
% AUTHOR:   Marco Rüth, contact@marcorueth.com
%           Jens Klinzing, jens.klinzing@uni-tuebingen.de

% Triggers for the different users are defined in mt_dialogues !

switch upper(user)
    case {'SL3', 'SL4'}
        dirRoot 			= 'D:\Reactivated Connectivity\Resting State';
        dirPTB              = 'C:\Users\Doktorand\Toolbox\Psychtoolbox';
    case {'JENS'}
       dirRoot              = 'C:\Users\david\Documents\GitHub\restingstate';
       dirPTB               = 'C:\Users\david\Documents\MATLAB\Psychtoolbox'; 
        
    otherwise
        error('Invalid User Name. Define workspace in mt_profile.m')
end
addpath(genpath(dirRoot))
addpath(dirPTB)
end