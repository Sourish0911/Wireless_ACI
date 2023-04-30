%% Data Consolidation
    % Collect and consolidate the data obtained in previous scripts in a single file.
    %% *Syntax*
    % Data_Consolidation(channel)
    %% *Description*
    % The Data_Consolidation(channel) function imports the data files generated
    % by previous data analysis scripts and renames them in a structured way
    % for easy manipulation. Saving all data in a single .mat file.
    %
    % *Input Arguments*
    %
    % * channel
    %
    % variable that selects the channel.
    %
    % *Output arguments*
    %
    % * None
    %
%% *Examples*
    % The Data_Consolidation(channel) function is called.
function Data_Consolidation(channel)    
%% 
% PER data resulting from the 802.11p system simulation is imported. It 
% contains the PER values for the 8 possible configurations with modulation 
% scheme and coding rate that are defined in the IEEE 802.11p standard.
% SNRV_FIN_EXT and SNUM_FIN_EXT variables are used to create the SNR vector
% what will be used for the graph of the theoretical models and the
% comparison graph between theoretical models and the simulation performed.
load(strcat('rician_',num2str(channel),'_PER_ALL_SIM_EXTENDED.mat'))
PER_SIM_FIN_EXT = PERTW;
SNRV_FIN_EXT = SNRVW;
SNUM_FIN_EXT = SNum;
clear PERTW SNRVW SNum 
%% 
% Data resulting from the theoretical models of PER are imported.
load(strcat('rician_',num2str(channel),'_PER_ALL_THEO_EXTENDED.mat'))
PER_THEO_FIN_EXT = PERTH;
PER_THEO_FIN_EXT_CONF1 = PERTH1;
PER_THEO_FIN_EXT_CONF2 = PERTH2;
PER_THEO_FIN_EXT_CONF3 = PERTH3;
PER_THEO_FIN_EXT_CONF4 = PERTH4;
PER_THEO_FIN_EXT_CONF5 = PERTH5;
PER_THEO_FIN_EXT_CONF6 = PERTH6;
PER_THEO_FIN_EXT_CONF7 = PERTH7;
PER_THEO_FIN_EXT_CONF8 = PERTH8;
%%
% All the data is store in a .mat file.
save(strcat('rician_',num2str(channel),'_Consolidated_Data.mat')) 
%%
% *See also*
%
% <phy_lay.html Physical layer graph>
%
% <the_mod.html Theorical PER models graph>
%
% <phy_vs_the.html Theorical PER models vs Physical layer graph> 