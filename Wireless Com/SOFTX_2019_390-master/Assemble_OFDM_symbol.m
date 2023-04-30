%% OFDM symbol assembly
    % Creation of an OFDM symbol.
%% *Syntax*
    % OFDMSym = Assemble_OFDM_symbol(dataF, polPilot)
%% *Description*
    % function OFDMSym = Assemble_OFDM_symbol(dataF, polPilot) returns an 
    % OFDM symbol in the time domain. The symbol and the subcarrier 
    % assignment is based on the IEEE 802.11 standard. 
    % 
    % <<Sub_OFDM.PNG>>
    % 
    % You can add a cyclic prefix to the symbol to avoid interference due
    % to the multipath. The cyclic prefix will be the last quarter of the 
    % symbol in time, in the discrete case of 64 samples, the last 16 
    % would be taken and copied before the first, obtaining an array of 80 samples.
    %%
    % 
    % <<Sim_OFDM.PNG>> 
    %
    % *Input arguments*
    %
    % * dataF
    %
    % Input data vector, composed of 48 complex symbols.
    %   
    % * polPilot
    %
    % Polarity of the pilots to use.
    %
    % *Output arguments*
    %
    % * ODFMSym
    %
    % 1 OFDM symbol. 
    %
%% *Examples*
    % The function Assemble_OFDM_symbol(dataF, polPilot) is called.
function OFDMSym = Assemble_OFDM_symbol(dataF, polPilot)
 %%   
    % An individual OFDM symbol is formed with data from 48 samples 
    % and the insertion of the pilot at the correct indices.
   
    symbolF = zeros(1,53);
    symbolF(1,1:5) = dataF(1:5);
    symbolF(1,6) = 1*polPilot;                   % pilot
    symbolF(1,7:19) = dataF(6:18);
    symbolF(1,20) = 1*polPilot;                  % pilot
    symbolF(1,21:26) = dataF(19:24);
    symbolF(1,27) = 0;                            % dc
    symbolF(1,28:33) = dataF(25:30);
    symbolF(1,34) = 1*polPilot;                  % pilot
    symbolF(1,35:47) = dataF(31:43);
    symbolF(1,48) = -1*polPilot;                 % pilot
    symbolF(1,49:53) = dataF(44:48);
 %% 
    % The indices of the symbol are ordered according to the IEEE 802.11 standard.
    symbolFArr = zeros(1,64);
    symbolFArr(1) = 0;
    symbolFArr(2:27) = symbolF(28:53);
    symbolFArr(28:38) = 0;
    symbolFArr(39:64) = symbolF(1:26);
%%
    % The symbols are passed in time by the IFFT.
    symbolT = ifft(symbolFArr);
%% 
    % The cyclic prefix is obtained by using the last quarter of the symbol in time.
    GI = symbolT( 3*length(symbolT)/4 + 1 : length(symbolT) );
%% 
    % The OFDM symbol is created by concatenating the cyclic prefix and the subcarriers.
    OFDMSym = [GI symbolT];
    
end
%%
    % *See also*
    %
    % <Create_SIGNAL.html Create_SIGNAL> 
    %
    % <extract_OFDM_symbol.html OFDM symbol extraction>