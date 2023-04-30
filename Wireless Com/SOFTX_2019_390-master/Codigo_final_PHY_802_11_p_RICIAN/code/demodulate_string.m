%% Demodulation
    % Data string demodulation.
    %% *Syntax*
    % IDATA  = demodulate_string(MDATA, M)
    %% *Description*
    %
    % The function  demodulate_string(MDATA, M) returns a set of
    % demodulated bits based on the selected modulation scheme.
    % The assignment of the symbols for each group of m bits is done 
    % according to the respective constellation diagrams.
    % The modulated signal is multiplied by a factor of the
    % modulation scheme due to normalization issues.
    % 
    % *Input Arguments*
    %
    % * MDATA
    %
    % Input vector, complex symbols in frecuency. 
    %   
    % * M
    %
    % Modulation scheme to be used.
    %
    % *Output Arguments*
    %
    % * IDATA
    %
    % Demodulated bits vector. 
    %
    %% *Example*
    % The function  demodulate_string(MDATA, M) is called.
function IDATA  =  demodulate_string(MDATA, M)
%%
   % Depending on the modulation scheme, the demodulation is done.
   % The complex symbols are multiplied by the respective normalization factor.
    switch M
        case 2
            IDATA = demodulate_BPSK(MDATA);
        case 4
            IDATA = demodulate_QPSK(sqrt(2)*MDATA);
        case 16
            IDATA = demodulate_16QAM(sqrt(10)*MDATA);
        case 64
            IDATA = demodulate_64QAM(sqrt(42)*MDATA);
        otherwise
            errordlg('NUMBER OF LEVELS INCORRECT- MODULATION')
    end

end
%%
    % *See also*
    %
    % <demodulate_BPSK.html demodulate_BPSK>
    %
    % <demodulate_QPSK.html demodulate_QPSK>
    %
    % <demodulate_16QAM.html demodulate_16QAM>
    %
    % <demodulate_64QAM.html demodulate_64QAM>
    %
    % <modulation_string.html String modulation>
    %
    % <process_DATA.html Data field processing> 