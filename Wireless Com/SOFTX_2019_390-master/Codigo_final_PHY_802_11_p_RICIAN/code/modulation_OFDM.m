%% OFDM Modulation
    % Modulation process and creation of OFDM symbol arrays.
    %% *Syntax*
    %  symbol = modulation_OFDM(data)
    %% *Description*
    % The modulation_OFDM(data) function returns a vector of
    % ODFM symbols based on data input vectors. The function obtains the 
    % polarity arrangement of the pilot subcarriers, calculates the number 
    % of OFDM symbols to be generated and separates the input array into 
    % groups of 48 symbols for the generation of each OFDM symbol according 
    % to the IEEE 802.11-2012 standard.
    %
    % *Input Arguments*
    % 
    % * data
    %
    % Vector of complex data symbols.
    %
    % *Output arguments*
    %
    % * symbols
    %
    % ODFM symbols in the time domain.
    %% *Examples*
    % The function simbolos = modulacionOFDM(datos) is called.
function symbols = modulation_OFDM(data)
 %%
    % The polarity of the pilots and vectors are generated 
    % for each symbol. Number of samples in time are going to be 64: 48 data,
    % 4 pilots, 12 nulls + 1/4 per GI results in 80 total.
    
    pilots_polarity = generate_pilot_polarity();            
    Nsym = length(data)/48;                                % Number of symbols to form
    longTSym = 80;                                       
    symbols = zeros(1,Nsym*longTSym);
%%
    % Each of the symbols is formed.
    for i=1:Nsym
%%
    % For symbols beyond the 127th, operation 
    % n mod 127 is performed to determine the index of the polarity values.
    pilot_index = mod( i ,127 ) +1; 
        %%
        % The symbols are formed one by one with the functions below.
        simbolo = Assemble_OFDM_symbol( data( (i-1)*48 + 1 : i*48 ), pilots_polarity(pilot_index) );   
        %%
        % The symbols are concatenated.
        symbols((i-1)*longTSym + 1 : i*longTSym) = simbolo;              
    end                                               
end
%%
    % *See also*
    %
    % <generate_pilot_polarity.html generate_pilot_polarity> 
    %
    % <Assemble_OFDM_symbol.html Assemble_OFDM_symbol>
    %
    % <Create_DATA.html PLCP DATA>  