%% PER Extension
    % Extends the domain of the PER values obtained in the IEEE 802.11p system simulation.
    %% *Syntax*
    % PER_Extension(channel)   
    %% *Description*
    % The PER_Extension(channel) function extends the domain (in SNR) of simulated
    % PER values, a fixed number of samples to the left and to the right. 
    % In addition, it evaluates the theoretical models of the PER on the
    % corresponding SNR range for each case. Finally save the data in .mat files.
    %
    % This extension is done to be able to graphically represent the PER 
    % of each configuration together with the results of the theorical models.
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
    % The PER_Extension(channel) function is called.
function PER_Extension(channel) 
%% *SNR extension for simulated SNR results*
% The data obtained from the IEEE 802.11p system simulation is loaded.
% Variables are defined to save the resulting data, these variables
% take a long format.

load(strcat('rician_',num2str(channel),'_PER_SIM_FINO.mat'))             
format long
numEle = 400;
PERTW = zeros(8,SNum+2*numEle);
SNRVW = zeros(8,2);
%%
% The iterations are made for the 8 possible configurations that the IEEE 
% 802.11p standard allows.
for p = 1:8
%%
% so and sf are auxiliary variables to obtain the SNR. SNum is the number 
% of elements between so and sf.
    so = SNRV(p,1);
    sf = SNRV(p,2);
    SNR = linspace(so, sf, SNum); 
    ds = SNR(2) - SNR(1);
    PER = PERT(p,:);
%%
% numEle equidistant elements are added to the left and right of SNR. SNRE
% represents the SNR with extended range.
    SNRE = so - numEle*ds : ds : sf + numEle*ds;
%%
% Because the PER functions take values between 0 and 1 in a narrow range 
% of SNR, to the left of this range the function takes values of 1 and to 
% the right takes values of 0, making possible a trivial extension of 
% the domain to both sides.

    if(length(SNRE)<length(SNRVW))
        last = SNRE(end) + ds;
        SNRE = [SNRE last];
    end    
    PERW = zeros(1,length(SNRE));  
    PERW(1:numEle) = 1;
    PERW(numEle + 1:numEle + SNum) = PER;
    PERW(numEle + SNum + 1:numEle + SNum + numEle) = 0;
%% 
% The values are saved in different variables that will be used in 
% the graphs of the results.
    PERTW(p,:) = PERW;
    SNRVW(p,1) = SNRE(1);
    SNRVW(p,2) = SNRE(end);
end
%% 
% The new number of elements in the SNR range is saved and the data is 
% store in a .mat file.
SNum = SNum + 2*numEle;
save(strcat('rician_',num2str(channel),'_PER_ALL_SIM_EXTENDED.mat'))

%% *PER theoretical values with extended SNR range*
% The theoretical values of PER are obtained with the ranges of SNR 
% extended previously calculated.
%% 
% Extended simulated SNR PER values are loaded.
load(strcat('rician_',num2str(channel),'_PER_ALL_SIM_EXTENDED.mat'))
%%
% The PERTH variable is used as an array to save all theoretical PER
% of all configurations and all respective PER equations.
l = numBit;
PERTH = zeros(8*9,SNum);
%%
% The iterations are made for the 8 possible configurations that the IEEE 
% 802.11p standard allows and are evaluated for the 9 theoretical models
% of PER. The modulation scheme, the coding rate and the SNR values are obtained
% from the previously imported data.
for p=1:8  
    M = PARAMETERS(p,1);
    r = PARAMETERS(p,2);
    SNR = linspace(SNRVW(p,1),SNRVW(p,2), SNum);
    for j=1:9        
        PER = evaluate_models(SNR, M, r, l, j);
        PERTH(((p-1)*9)+j,:)=PER; 
    end
end
%% 
% The values are saved in different variables depending on the configuration.
PERTH1 = PERTH(1:9,:);
PERTH2 = PERTH(10:18,:);
PERTH3 = PERTH(19:27,:);
PERTH4 = PERTH(28:36,:);
PERTH5 = PERTH(37:45,:);
PERTH6 = PERTH(46:54,:);
PERTH7 = PERTH(55:63,:);
PERTH8 = PERTH(64:72,:);
%%
% The data is store in a .mat file.
save(strcat('rician_',num2str(channel),'_PER_ALL_THEO_EXTENDED.mat'))
%%
% *See also*
%
% <evaluate_models.html Evaluation of theoretical models> 
%
% <phy_lay.html Physical layer graph>
%
% <the_mod.html Theorical PER models graph>
%
% <phy_vs_the.html Theorical PER models vs Physical layer graph> 