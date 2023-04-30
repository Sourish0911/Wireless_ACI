%% IEEE 802.11 communication system
    % Implementation of the IEEE 802.11 communication system.
    
%% Description
    % The script allows you to enter the transmission parameters, 
    % simulate the transmission, sending and receiving of data packets 
    % according to the established values and configurations.
    % It also calculates the performance parameters, number of errors, 
    % BER and PER, for each specified configuration.
    % Finally, it save the results in .mat files for later analysis.
    %
    % The execution scheme of the IEEE 802.11 communication system is
    % detailed below.
    %%
    % 
    % <<esq.PNG>>
    % 
    
clc, clear all, close all
%% Parameters definition
    % Parameters are set for transmission, including number of packages
    % to analyze, number of bytes per package and bandwidth.
numPaq = 10000;
numByte = 500;
BW = 10e6;                       
numBit = numByte * 8;              

%%
    % The values of modulation scheme(M), coding rate (r) and 
    % speed (v) are defined.
    %
%                   M    r      v
PARAMETERS = [  2   1/2     3;
                2   3/4     4.5;
                4   1/2     6;
                4   3/4     9;
                16  1/2     12;
                16  3/4     18;
                64  2/3     24;
                64  3/4     27];
%% 
    % The SNR values to be used are defined. 
SNRVawgn = [ -1 5
        2 8
        2 7
        4 10
        7 14
        10 17
        14 21
        16 24];
SNRVric = [ 0 20
        2 35
        2 21
        4 35
        7 27
        10 37
        14 45
        16 45];
 
SNum = 50;
%%
    % Matrices are created to store the number of errors, the BER and
    % the PER for each configuration that will be used.
    
ERROREST  = zeros(8,SNum);  % Matrix to store the number of errors for each SNR for each configuration.
BERT      = zeros(8,SNum);  % Matrix to store the BER for each SNR for each configuration.
PERT      = zeros(8,SNum);  % Matrix to store PER for each SNR for each configuration.
tic

%%
    % We set up a variable chanChoice to choose whether we want a pure AWGN
    % channel (chanChoice = 'awgn') or a rician channel (chanChoice = 'rician')
chanChoice = 'rician';
if strcmp(chanChoice,'rician')
    SNRV = SNRVric;
else
    SNRV = SNRVawgn;
end
%%
    % We select the channel tipe

chanType = 2;
%   Channels available
%   1:  Rural Line-of-Sight
%   2:  Urban Line-of-Sight
%   3:  Highway Line-of-Sight
%   4:  Highway Non-Line-of-Sight

%%
    % The function to create the channel is called
[ RicianChannel,symOffset,sampIdx ] = ricianWChannel( chanType );



%%
    % Analysis for each speed with the corresponding combination of M and r.

for p = 6:6        
%for p = 1:length(PARAMETERS)        
    M = PARAMETERS(p,1);
    r = PARAMETERS(p,2);
    v = PARAMETERS(p,3);
    SNR = linspace(SNRV(p,1),SNRV(p,2),SNum);
    
    m = log2(M);
%%
    % The values of the errors, BER and PER for each SNR for the configuration p 
    % are stored in the respective array.
    ERRORESM = [];   
    BERM = [];       
    PERM = [];       

%%
    % The system is tested with each SNR value.
    for i = 1:length(SNR)
%%
    % The number of erroneous bits and erroneous packets for the SNR 
    % are stored in the variables bitErr and paqErr respectively.
        fprintf('\n\nSNR = %i\n', i);
        paqErr = 0;            
        bitErr = 0;           

%%
    % The system is implemented to send package by package.
        for j = 1:numPaq            
            errores = 0;
             if (mod(j,100) == 0 )
                 fprintf('\nSNR = %.2f (i=%i)\t\tPACKET: %i\t\t v: %i', SNR(i), i, j, v);
             end
%%  Transmission block
            [DatosTX, stringBitsTx]= txOFDM(numBit, M, r);    
%% Data sending
        % We send the data over the chosen channel
            if strcmp(chanChoice,'rician')
                % If it's a rician channel, first, we reset the channel so 
                % it doesn't carry its state from the previous frame
                reset(RicianChannel);
                % We compute the output in time of the channel
                [DatosChan, ~] = step(RicianChannel,DatosTX(:));
                % We compute the channel response (transfer function)
                % manually
                H = fft(DatosChan) ./ fft(transpose(DatosTX));
            else
                % If it's an awgn channel, it doesn't experience fading
                DatosChan = DatosTX;
            end
                % We then send it through an awgn channel
            DatosRX=awgn(reshape(DatosChan,1,[]), SNR(i) ,'measured');

%% Reception block
            if strcmp(chanChoice,'rician')
                % If it went through a rician channel we first perform an
                % ideal equalization with the channel response
                DatosRec = transpose(equRicChan(DatosRX,H));
            else
                DatosRec = DatosRX;
            end
            stringBitsRx = rxOFDM(DatosRec, numBit, M, r);

                
%% Error analysis
    % The number of errors is measured according to the bits sent by each packet.
    % Also, if there is at least one error it means that the package is
    % incorrect. 
            errores = sum( abs( stringBitsRx -  stringBitsTx) );   
            if errores > 0 
                paqErr = paqErr + 1;                                            
            end
            bitErr = bitErr + errores;                                                   
        end
%%
    % The BER and PER values for each SNR are obtained and stored in the
    % corresponding matrices.
        BER = bitErr / (numPaq*numBit);
        PER = paqErr / numPaq;
        
        ERRORESM = [ERRORESM bitErr];
        BERM = [BERM BER];
        PERM = [PERM PER];
    end
%%    
    % The values of number of errors, BER and PER for each configuration are
    % storaged in the corresponding matrices. 
    ERROREST(p,:) = ERRORESM;              
    BERT(p,:) = BERM;
    PERT(p,:) = PERM;
%%    
    % Backup files are saved.
    fileName = strcat(chanChoice,'_' , num2str(chanType));
    fileName = strcat(fileName, '_caso_');
    fileName = strcat(fileName, num2str(p));
    fileName = strcat(fileName, 'N.mat');
    
    save(fileName, 'ERRORESM', 'BERM', 'PERM', 'SNR', 'M', 'r', 'numBit', 'numPaq', 'BW', 'chanType', 'chanChoice')
   
end
toc
%% Data Storage
    % All the obtained values are saved in a .mat file  for further analysis
save(strcat(chanChoice,'_' , num2str(chanType),'_PER_SIM_FINO.mat'), 'ERROREST', 'BERT', 'PERT', 'SNRV', 'numBit', 'numPaq', 'BW', 'PARAMETERS', 'SNum', 'chanType', 'chanChoice')


%% 
    % *See also*
    %
    % <equRicChan.html equRicChan>
    %
    % <ricianWChannel.html ricianWChannel>
    %
    % <txOFDM.html txOFDM>
    % 
    % <rxOFDM.html rxOFDM>
    %
    % <https://www.mathworks.com/help/comm/ref/awgn.html awgn> 