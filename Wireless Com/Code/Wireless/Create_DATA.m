%% PLCP DATA
    % Creation of the DATA field of a PLCP package.
    %% *Syntax*
    % DATA = Create_DATA(PSDU, M, r)
    %% *Description*
    % The function Create_DATA(PSDU, M, r) returns the DATA field of a PLCP
    % packet.
    % It generates the SERVICE (16 bits) and Tail (6 bits) fields. Also 
    % generates the padding bits and concatenate all of them with
    % the payload of the packet according to the IEEE 802.11-2012 standard.
   %%
    % 
    % <<Data_field.PNG>>
    %
    % *Input arguments*
    %
    % * PSDU
    %
    % Data bits vector of a single package.
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
    % * DATA
    %
    % DATA field in  time domain of the PLCP PDU.

    %% *Examples*
    % The function Create_DATA(PSDU, M, r) is called.
function DATA = Create_DATA(PSDU, M, r)
%%
    % Creation of the field DATA of a single package.
    % The number of coded bits per subcarrier, the number of coded 
    % bits per symbol and the number of data bits per symbol is obtained 
    % according to the IEEE 802.11 standard.       
    
    m = log2(M); 
    NBPSC = m;                              
    NCBPS = NBPSC * 48;                   	
    NDBPS = NCBPS * r;                      
    
%% 
    % The service field is composed of 16 bits and the tail field of 6
    % bits. The vectors are generated with the number of symbols to be
    % used and the padded bits are calculated.
    SERVICE = zeros(1,16);                 
    TAIL = zeros(1,6);                      
    NSYM =  ceil((length(PSDU)+length(SERVICE)+length(TAIL))/NDBPS);     %Number of symbols to generate
    NBITS = NSYM * NDBPS;                                                %Total number of bits (after padding)
    NPAD = NBITS - ( length(PSDU) + length(SERVICE) + length(TAIL) );    %Number of padding bits necessary
    PAD = zeros(1,NPAD);
 %%
    % DATA field construcction according to the IEEE 802.11-2012 standard. 
    ODATA = [SERVICE PSDU TAIL PAD];                       
 %%    
    % To map a symbol, the following steps are followed:
%%
    % *Scrambling*
    %
    % The scrambling is done with the PDU and an Initial state  = [1 0 1 1 1 0 1] 
    % according to the IEEE 802.11 standard.   
    SDATA = scrambleString(ODATA, [1 0 1 1 1 0 1]);              
%%
    % The TAIL bits are set to 0 after the scramble because they
    % do not participate in the scrambling process according to the IEEE
    % 802.11 standard.
	SDATA( length(SERVICE) + length(PSDU) + 1 : length(SERVICE) + length(PSDU) + length(TAIL)) = 0;       
%%
    % *Coding*
    %
    % The coding is done with a coding rate r.
    CDATA = Encode_String(SDATA, r);                 
%%
    % *Interleaving*
    %
    % The interleaving process is based on the number of coded bits per
    % symbol.
    IDATA = Interleaver_string(CDATA, NCBPS);           
%%
    % *Modulation*
    %
    % The modulation process is carried out with the M modulation scheme.    
    MDATA = modulation_string(IDATA, M);                       
%%
    % *OFDM Modulation*
    %
    % The construction of OFDM symbols arrays for all data symbols.
	DATA = modulation_OFDM(MDATA);             
end

%%
    % *See also*
    %
    % <scrambleString.html scrambleString> 
    %
    % <Encode_String.html Encode String>
    %
    % <Interleaver_string.html Interleaver string>
    %
    % <modulation_string.html modulation_string>
    %
    % <modulation_OFDM.html modulation_OFDM>
    %
    % <txOFDM.html OFDM package transmission>