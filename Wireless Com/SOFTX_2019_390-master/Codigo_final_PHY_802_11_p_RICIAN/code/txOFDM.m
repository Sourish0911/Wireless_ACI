%% ODFM package transmision
    % Creation of the OFDM baseband transmission string.
    %% *Syntax*
    % [package, PSDU] = txOFDM(numBit, M, r) 
    %
    %% *Description*
    % The function txOFDM(numBit, M, r) implements the transmission of a package.
    % It calls functions for the creation of the preamble, header and payload of
    % the package and concatenates the packet elements in time and
    % returns two output arguments. The structure of the package is shown
    % below.
    %
    %%
    % 
    % <<paqu_PLCP.PNG>>
    %
    % *Input arguments*
    %
    % * numBit
    %
    % Number of bits per package.
    %
    % * M
    %
    % Modulation scheme to be used.
    %
    % * r
    %
    % Coding rate.
    %
    % *Output arguments*
    %
    % * package
    %
    % Physical layer frame in time.
    %
    % * PSDU
    %
    % Payload in bits.    
    %% *Examples*
    % The function txOFDM(numBit, M, r) is called.
function [package, PSDU] = txOFDM(numBit, M, r) 
%%
    % Check that the number of bits per package is correct.
    if(numBit < 8 || numBit > 4095*8)        
    	errordlg('Number of bits per package invalid (8 - 32760)','Error')
    end
%% 
    % Each part of the package is created independently.
    SYNC = Create_SYNC();             % Preamble in time
    SIGNAL = Create_SIGNAL();         % Header in time
    PSDU = round(rand(1,numBit));   % PSDU in bits
    DATA = Create_DATA(PSDU, M, r);   % PSDU in time
    package = [SYNC SIGNAL DATA];   % Package in time
end
%% 
    % *See also*
    %
    % <Create_SYNC.html Create_SYNC()>
    %
    % <Create_SIGNAL.html Create_SIGNAL()>
    %
    % <Create_DATA.html Create_DATA()>
    %
    % <simulation_802_11_p.html IEEE 802.11 comunication system>