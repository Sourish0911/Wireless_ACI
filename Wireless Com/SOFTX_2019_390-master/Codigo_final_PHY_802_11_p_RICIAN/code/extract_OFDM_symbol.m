%% OFDM symbol extraction
    % Obtains the complex data symbols in frequency of an OFDM symbol in time.
    %% *Syntax*
    %  dataF = extract_OFDM_symbol(OFDMSym, polPilot)
    %% *Description*
    % The extract_OFDM_symbol(OFDMSym, polPilot) function returns an array 
    % of symbols in the frequency domain. It extracts the samples that 
    % do not correspond to the cyclic prefix and redistributes according
    % to the IEEE 802.11 standard. Finally data is extracted from the 
    % subcarriers and the dc.
    %
    % *Input Arguments*
    % 
    % * OFDMSym
    %
    % OFDM symbols in time.
    %
    % * polPilot
    %
    % Polarity of the pilots to use.
    %
    % *Output arguments*
    %
    % * dataF
    %
    % 48 complex symbols in frequency. 
    %% *Examples*
    % The function extract_OFDM_symbol(OFDMSym, polPilot) is called.
function dataF = extract_OFDM_symbol(OFDMSym, polPilot)
%%  
    % The cyclic prefix corresponding to 20% of the symbol is extracted, 
    % that is, 1.6 us of the 8 us. Then the symbol is obtained in 
    % frequency through a FFT.
    symbolT = OFDMSym( 0.2*length(OFDMSym) + 1 : length(OFDMSym));  
    symbolFArr = fft(symbolT);
 %%
    % The indexes of the vector are ordered according to the  
    % established in the standard.
    symbolF = zeros(1,53);
    symbolF(1:26) = symbolFArr(39:64);
    symbolF(27) = 0;
    symbolF(28:53) = symbolFArr(2:27);

%%
    % Data is extracted from the subcarriers and the dc. 
    dataF = zeros(1,48);
    dataF(1:5) = symbolF(1:5);
    dataF(6:18) = symbolF(7:19);
    dataF(19:24) = symbolF(21:26);
    dataF(25:30) = symbolF(28:33);
    dataF(31:43) = symbolF(35:47);
    dataF(44:48) = symbolF(49:53);
    
end
%% 
    % *See also*
    %    
    % <Assemble_OFDM_symbol.html OFDM symbol assembly>
    %
    % <demodulation_OFDM.html OFDM demodulation>
