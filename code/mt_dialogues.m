function cancel = mt_dialogues(dirRoot)
% ** function mt_dialogues(dirRoot)
% This script creates dialogue windows to configure the experiment. The
% questions and defaults can be found and adjustet in "prompts.txt" and
% "defaults.txt", respectively. Note that each line corresponds to one
% dialogue.
%
% IMPORTANT: For this script to work you have to copy the function "newid.m"
% to folder displayed if you execute "which -all inputdlg" 
% Source: http://www.mathworks.com/matlabcentral/answers/uploaded_files/1727/newid.m
% 
% USAGE:
%     mt_dialogues;
%
% >>> INPUT VARIABLES >>>
% NAME              TYPE        DESCRIPTION
% dirRoot           char        path to root working directory
%
%
% AUTHOR:   Jens Klinzing, jens.klinzing@uni-tuebingen.de

%% Load parameters specified in mt_setup.m

load(fullfile(dirRoot,'setup','mt_params.mat'))   % load workspace information and properties


%% Read in questions/default answers shown in the dialogue windows

% Read in dialogue questions
fid                 = fopen(fullfile(dirRoot,'code','prompts.txt'));
prompts             = textscan(fid,'%s','Delimiter','\n');
prompts             = prompts{1};
fclose(fid);

% Read in dialogue default answers
fid                 = fopen(fullfile(dirRoot,'code','defaults.txt'));
defaults            = textscan(fid,'%s','Delimiter','\n');
defaults            = defaults{1};
defaults{1}         = ['(1 - ' num2str(maxSubjectNr) ')'];
fclose(fid);

% Pre-allocation of cell array for answer strings
[answers{1:length(prompts)}] = deal(cell(1));
for r = 1:size(answers,2)
    answers{1, r}{:} = '';
end
fixRun = '';

%% Show dialogue windows and save the answers
dlgBackground = figure('name', 'dlgBackground', 'units', 'normalized', 'outerposition', [0 0 1 1] , 'Color', [1 1 1], ...
    'NumberTitle','off', 'menubar', 'none', 'toolbar', 'none', 'Color', 'white');
options.WindowStyle='modal';

answered = false;
while ~answered
    for p = 1 : length(prompts)
        % allow only values as specified in cfg_cases (mt_setup.m)
        while (p == 1 && ~ismember(str2double(answers{p}), cfg_cases.subjects)) || ...
                (p == 2 && ~ismember(answers{2}(:), cfg_cases.nights))  || ...
                (p == 3 && ~ismember(answers{3}(:), cfg_cases.sesstype))

            answers{p} 	= upper(newid(prompts(p), '', [1 70], defaults(p), options));
            if isempty(answers{p})
                close('dlgBackground')
                error('Input cancelled')
            end
        end
    end
    
    % Let the user confirm the input
    
    choice = questdlg({'Start with these parameters? ', ...
        ['Subject: ' num2str(answers{1}{1})], ...
        ['Night: : ' num2str(answers{2}{1})], ...
        ['Session: ' answers{3}{1}]}, ...
        'Confirm your choice', ...
        'Start', 'Abort', 'Start');
    % Handle response
    switch choice
        case 'Start'
            answered = true;
        case 'Abort'
            answered = false;
            for r = 1:size(answers,2)
                answers{1, r}{:} = '';
            end
    end
end
close('dlgBackground')

% Store answers in struct fields
% Questions can be found in prompts.txt, defaults in defaults.txt
if ~exist('cfg_dlgs', 'var')
    cfg_dlgs.subject 	= char(answers{1});     % Subject ID
    cfg_dlgs.night      = char(answers{2});     % Night number
    cfg_dlgs.sesstype 	= char(answers{3});     % Session type
end

% save(fullfile(setupdir, 'mt_debug.mat'), 'cfg_dlgs') % uncomment for new debug mat-file

%% Evaluate the answers
switch cfg_dlgs.sesstype
    case cfg_cases.sesstype{1}
        cfg_dlgs.sessName = cfg_cases.sessNames{1};
        cfg_dlgs.sesstype = 1;
    case cfg_cases.sesstype{2} 
        cfg_dlgs.sessName = cfg_cases.sessNames{2};
        cfg_dlgs.sesstype = 2;
    case cfg_cases.sesstype{3}
        cfg_dlgs.sessName = cfg_cases.sessNames{3};
        cfg_dlgs.sesstype = 3;
    otherwise
        error('Invalid Session Type')
end

% Lab
switch upper(user)
    case 'SL3'
        cfg_dlgs.lab    = 2;
        triggerOdor     = triggerOdorOn{2}      + EEGtrigger;
        triggerPlacebo  = triggerPlaceboOn{2}   + EEGtrigger;
        sendTrigger = true; % turns on triggers
        % In this lab we use the new olfactometer
    case 'SL4'
        cfg_dlgs.lab    = 3;
        triggerOdor     = triggerOdorOn{3}      + EEGtrigger;
        triggerPlacebo  = triggerPlaceboOn{3}   + EEGtrigger;
        sendTrigger = true;
        % In this lab we use the new olfactometer
    otherwise
        error('Invalid Lab')
end


%% Save configuration in dirRoot
save(fullfile(setupdir, 'mt_params.mat'), '-append', 'cfg_dlgs', 'fixRun', 'sendTrigger')

end