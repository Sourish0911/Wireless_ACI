%% PLCP Header
    % Creation of the header of a PLCP package.
    %% *Syntax*
    % SIGNAL = Create_SIGNAL()
    %% *Description*
    % The function Create_SIGNAL() returns the header of a PLCP packet 
    % according to the IEEE 802.11-2012 standard, which is formed by an OFDM symbol.
    % This function does not accept input parameters, the output is 
    % obtained based on other functions and mathematical expressions defined in the standard.
    %
    %%
    % 
    % <<Signal_field.PNG>>
    % 
    % *Input arguments*
    %
    % * None
    %
    % *Output arguments*
    %
    % * SIGNAL
    %
    % Header field in PPDU PLCP time.

    %% *Examples*
    % The function Create_SIGNAL() is called.
function SIGNAL = Create_SIGNAL()
%%
    % For the creation of the SIGNAL field, a coding rate of R = 1/2
    % and a BPSK modulation scheme (M = 2) are used. The SIGNAL field
    % has 24 bits, of which the last 6 correspond to a tail of 0s.
    
    M = 2;                            
    r = 1/2;                         
    m=log2(M);   
    
    bits_header = round(rand(1,18));       % The header has 18 bits
    tail = zeros(1,6);                      % Tail of 6 0s
    bits_header = [bits_header tail];     % The field SIGNAL has 24 bits
%% 
    % To obtain the number of bits per subcarrier, the number of bits 
    % coded per symbol and the number of data bits per symbol is made 
    % according to the IEEE 802.11 standard.
    NBPSC = m;                        % Number of bits per subcarrier    
    NCBPS = NBPSC * 48;               % Number of coded bits per symbol   
    NDBPS = NCBPS * r;                % Number of data bits per symbol     
%%    
    % To map the header of an OFDM symbol, the following steps are followed:
%%
    % *Codification*
    %
    % The coding is done with a coding rate r = 1/2.
    %%
   Coded_header = Encode_String(bits_header, r); 
%%
    % *Interleaving*
    %
    % The interleaving process is done with BPSK.
    Interleaver_header = Interleaver_string(Coded_header, NCBPS);
%%
    % *Modulation*
    %
    % The modulation process is carried out with the BPSK modulation scheme.
    Modulated_header = modulation_string(Interleaver_header, 2); 
%%
    % *OFDM symbol construction*
    %
    % The construction of the OFDM symbol is done with 48 data subcarriers.
    SIGNAL = Assemble_OFDM_symbol(Modulated_header, 1); 
end
%%
    % *See also*
    %
    % <Encode_String.html Encode_String> 
    %
    % <Interleaver_string.html Interleaver_string>
    %
    % <modulation_string.html modulation_string>
    %
    % <Assemble_OFDM_symbol.html Assemble_OFDM_symbol>
    %
    % <txOFDM.html OFDM package transmission>