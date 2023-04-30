%%  Data field processing
    % Process the samples corresponding to the field DATA of the package.
    %% *Syntax*
    % PSDU = process_DATA(DATA, M, r, numBit)
    %% *Description*
    % The process_DATA(DATA, M, r, numBit) function returns a payload of 
    % bits performing the reverse process done in transmission, including 
    % demodulation, deinterleaving, decoding and scrambling according 
    % to the IEEE 802.11-2012 standard.
    %
    % *Input arguments*
    %
    % * DATA
    %
    % OFDM symbols of the DATA field in time.
    %
    % * M
    %
    % Modulation scheme to be used.
    %
    % * r
    %
    % Coding rate.
    %
    % * numBit
    %
    % Number of bits per package.
    %
    % *Output arguments*
    %
    % * PSDU
    %
    % Payload in bits.    
    %% *Examples*
    % The function process_DATA(DATA, M, r, numBit) is called.
function PSDU = process_DATA(DATA, M, r, numBit)
%%
    % The number of coded bits per subcarrier, the number of coded 
    % bits per symbol and the number of data bits per symbol is obtained 
    % according to the IEEE 802.11 standard.       
    m = log2(M); 
    NBPSC = m;                              
    NCBPS = NBPSC * 48;                   	
    NDBPS = NCBPS * r;     
%%
    % To obtain the data bits of the DATA field, the following steps are followed:
%% 
    % *OFDM Demodulation*
    %
    % The modulated data of the OFDM symbols is extracted.
    MDATA = demodulation_OFDM(DATA);
%% 
    % *String Demodulation*
    %
    % The demodulation process is carried out with the M modulation scheme.  
    IDATA = demodulate_string(MDATA, M);     
%% 
    % *Deinterleaving*
    %
    % The deinterleaving process is based on the number of coded bits per
    % symbol.    
    CDATA = deinterleaver_string(IDATA, NCBPS); 
%% 
    % *Decodification*
    %
    % The decodification is done with a coding rate r and a M modulation scheme.
    SDATA = decode_string(CDATA, r, M);     
%% 
    % *Scrambling*
    %
    % The scrambling is done with the PDU and an Initial state  = [1 0 1 1 1 0 1] 
    % according to the IEEE 802.11 standard.   
    ODATA = scrambleString(SDATA, [1 0 1 1 1 0 1]);
%%  
    % The fields SERVICE tail and padding are removed.
    PSDU = ODATA(16 + 1: 16 + numBit);             
    
end
%% 
    % *See also*
    %
    % <demodulation_OFDM.html OFDM demodulation>
    %
    % <demodulate_string.html String demodulation>
    %
    % <deinterleaver_string.html String deinterleaving>
    %
    % <decode_string.html String decodification>
    %
    % <scrambleString.html scrambleString> 
    %
    % <extract_DATA.html Data field extraction> 
    %
    % <rxOFDM.html ODFM package reception> 