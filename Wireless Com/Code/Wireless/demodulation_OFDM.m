%% ODFM demodulation
    % Demodulation process for OFDM symbols.
    %% *Syntax*
    %  MDATA = demodulation_OFDM(DATA) 
    %% *Description*
    % The demodulation_OFDM(DATA) function gets a vector corresponding
    % to a number of OFDM symbols in time. The number of received OFDM 
    % symbols is calculated and the function for processing the OFDM 
    % symbol is called. Finally all symbols are extracted and 
    % concatenated in an array.
    %
    % *Input Arguments*
    % 
    % * DATA
    %
    % OFDM symbols in time.
    %
    % *Output arguments*
    %
    % * MDATA
    %
    % Complex symbols in frecuency domain. 
    %% *Examples*
    % The function  MDATA = demodulation_OFDM(DATA) is called.
function MDATA = demodulation_OFDM(DATA)
%%
    % The polarity of the pilots are generated for each symbol. The number
    % of samples in time are going to be 64: 48 data, 4 pilots,
    % 12 nulls + 1/4 per GI results in 80 total bits with GI.
    
    pilots_polarity = generate_pilot_polarity();                                              
    longTSym = 80;       
    longFSym = 48;        
    Nsym = length(DATA)/longTSym;
    MDATA = zeros(1,Nsym*48);
%%
    % For symbols beyond the 127th, operation  
    % n mod 127 is performed to determine the index of the polarity values.
    % The data is extracted from the OFDM symbols, one by one and
    % then is concatenated in a single array.    
    for i=1:Nsym
        pilot_index = mod( i ,127 ) +1;
        symbol = extract_OFDM_symbol(DATA((i-1)*longTSym+1:i*longTSym),pilots_polarity(pilot_index));   
        MDATA((i-1)*longFSym + 1 : i*longFSym) = symbol;              
    end
end
%% 
    % *See also*
    %
    % <generate_pilot_polarity.html generate_pilot_polarity>
    %
    % <extract_OFDM_symbol.html extract_OFDM_symbol>
    %
    % <process_DATA.html Data field processing> 