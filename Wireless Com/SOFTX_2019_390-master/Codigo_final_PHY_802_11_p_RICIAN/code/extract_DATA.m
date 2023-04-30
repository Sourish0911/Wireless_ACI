%% Data field extraction
    % Extracts the samples corresponding to the DATA field of the package.
    %% *Syntax*
    % DATAT = extract_DATA(package)
    %% *Description*
    % The extract_DATA(package) function returns OFDM symbols of the DATA
    % field that was extracted from the package according to the
    % IEEE 802.11 standard.
    %
    % *Input arguments*
    %
    % * package
    %
    % Physical layer frame in time.
    %
    % *Output arguments*
    %
    % * DATAT
    %
    % OFDM symbols corresponding to the DATA field in time.   
    
    %% *Examples*
    % The function extraerDATA(package) is called.
function DATAT = extract_DATA(package)
%%
    % It extracts everything that comes after preambles and header.
    %
    % Corresponding length to the short preamble field of the PLCP package (2 OFDM symbol).
    nshort = 2*80;
%%
    % Corresponding length to the long preamble field of the PLCP package (2 OFDM symbol).
    nlong = 2*80;
%%
    % Corresponding length to the SIGNAL field of the PLCP package(1 OFDM symbol).
    nsignal = 80;
%%
    % The DATA field is extracted.
    DATAT = package( nshort + nlong + nsignal + 1 : length(package) ); 
end 
%% 
    % *See also*
    %
    % <process_DATA.html process_DATA> 
    %
    % <rxOFDM.html OFDM package reception> 