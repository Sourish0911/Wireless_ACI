%% Physical layer graph
    % It obtains the figure of the PER vs SNR for the physical layer.
    %% *Syntax*
    % phy_lay(channel)
    %% *Description*
    % The phy_lay(channel) function obtains the data from a dataset that contains 
    % the values of the simulations and  the theoretical models.
    % The data is loaded and compared using a graph. 
    % It is shown in both normal and logarithmic scales.
    %
    % The way in which the physical layer IEEE 802.11 is constructed is
    % specified in the function: *simulation_802_11_p*, which can be found
    % at the end of this document.
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
    % The phy_lay(channel) function is called.
function phy_lay(channel)
%%
% The functions needed to graph the results are called. The first evaluates
% the theoretical models of the PER on the range of SNR that best suits
% a given configuration.While the second collects all the data in a single 
% file to facilitate the management of the values obtained.
PER_Extension(channel);
Data_Consolidation(channel);
%%
% Load the theoretical data.
load(strcat('rician_',num2str(channel),'_Consolidated_Data.mat'))

%% 
% Each variable contains a different configuration of modulation
% scheme and coding rate, respectively.
zconf1 = 'BPSK - r=1/2 ';
zconf2 = 'BPSK - r=3/4 ';
zconf3 = 'QPSK - r=1/2 ';
zconf4 = 'QPSK - r=3/4 ';
zconf5 = '16QAM - r=1/2';
zconf6 = '16QAM - r=3/4';
zconf7 = '64QAM - r=2/3';
zconf8 = '64QAM - r=3/4';
bs = ' ';
zconf = [zconf1 ; zconf2 ; zconf3 ; zconf4 ; zconf5 ; zconf6 ; zconf7 ; zconf8];
%%
    % Physical layer values for all configurations.
    % Each figure consists of two graphs, the first shows the graph in normal 
    % scale and the second shows the graph in semi-logarithmic scale.
figure
for i=1:8
    SNR = linspace(SNRV_FIN_EXT(i,1), SNRV_FIN_EXT(i,2), SNUM_FIN_EXT);
    subplot(1,2,1)
    plot(SNR,PER_SIM_FIN_EXT(i,:),'LineWidth',1);
    hold on
    subplot(1,2,2)
    semilogy(SNR,PER_SIM_FIN_EXT(i,:),'LineWidth',1);
    hold on
end
%%
    % Aggregation of labels, titles and limits of the normal scale graph.
subplot(1,2,1)
legend(zconf1, zconf2, zconf3, zconf4, zconf5, zconf6, zconf7, zconf8, 'Location','northeastoutside');
if channel==1
    title('Simulated PHY with Rural Line-of-Sight channel')
elseif channel==2
    title('Simulated PHY with Urban Line-of-Sight channel')
elseif channel==3
    title('Simulated PHY with Highway Line-of-Sight channel')
elseif channel==4
    title('Simulated PHY with Highway Non-line-of-Sight channel')
end

xlabel('SNR [dB]')
ylabel('PER')
grid on
grid minor
axis([-3 45 0 1])
%% 
    % Aggregation of labels, titles and limits of the semi-logarithmic scale graph.
subplot(1,2,2)
legend(zconf1, zconf2, zconf3, zconf4, zconf5, zconf6, zconf7, zconf8, 'Location','northeastoutside');
if channel==1
    title('Simulated PHY with Rural Line-of-Sight channel [log]')
elseif channel==2
    title('Simulated PHY with Urban Line-of-Sight channel [log]')
elseif channel==3
    title('Simulated PHY with Highway Line-of-Sight channel [log]')
elseif channel==4
    title('Simulated PHY with Highway Non-line-of-Sight channel [log]')
end
xlabel('SNR [dB]')
ylabel('PER')
grid on
grid minor
axis([-3 45 1e-2 1])
%%
% The result for each configuration is shown below.
%%
% 
% <<phy_fig.PNG>>
% 
%%
% *See also*
%
% <simulation_802_11_p.html IEEE 802.11 Physical layer> 
%
% <PER_Extension.html  PER_Extension> 
%
% <Data_Consolidation.html  Data_Consolidation> 