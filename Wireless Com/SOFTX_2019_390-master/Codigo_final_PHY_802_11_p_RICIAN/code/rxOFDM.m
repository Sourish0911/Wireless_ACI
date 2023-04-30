%% OFDM package reception
    % The reception of a package is implemented.
    %% *Syntax*
    % PSDU = rxOFDM(package, numBit, M, r) 
    %% *Description*
    % The rxOFDM(package, numBit, M, r) function implements the reception
    % of a package after it passed through an awgn channel. It calls a function to 
    % extract the DATA field from the packet and to another function 
    % to process that field.
    %
    % *Input arguments*
    %
    % * package
    %
    % Physical layer frame in time.
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
    % * PSDU
    %
    % Payload in bits.   
    
    %% *Examples*
    % The function rxOFDM(package, numBit, M, r) is called.
function PSDU = rxOFDM(package, numBit, M, r)
%% 
    % The DATA is extracted, package by package, and the information 
    % is processed in independent functions.
    DATA = extract_DATA(package);       
    PSDU = process_DATA(DATA, M, r, numBit);
end
%%
    % *See also*
    %
    % <txOFDM.html OFDM package transmission>
    %
    % <extract_DATA.html extract_DATA> 
    %
    % <process_DATA.html process_DATA> 
    %
    % <simulation_802_11_p.html IEEE 802.11 comunication system>