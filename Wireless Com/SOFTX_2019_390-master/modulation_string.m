%% Modulation
    % Data string modulation.
    %% *Syntax*
    % MData = modulation_string(data, M)
    %% *Description*
    % The function MData = modulation_string(data, M) returns a set of
    % modulated bits based on the selected modulation scheme.
    % The assignment of the symbols for each group of m bits is done 
    % according to the respective constellation diagrams.
    % The modulated signal is multiplied by a factor of the
    % modulation scheme due to normalization issues.
    % 
    % *Input Arguments*
    %
    % * data
    %
    % Input vector, specified as an unmodulated bit vector.
    %   
    % * M
    %
    % Modulation scheme to be used.
    %
    % *Output Arguments*
    %
    % * MData
    %
    % Modulated bits vector. 
    %
    %% *Example*
    % The function modulation_string(data, M) is called.
function MData = modulation_string(data, M)
%%
    % Depending on the modulation scheme, the modulation is done.
    % The modulated bits are multiplied by the respective normalization factor.
    switch M
        case 2
            MData = 1 * modulate_BPSK(data);
        case 4
            MData = ( 1 / sqrt(2) ) * modulate_QPSK(data);
        case 16
            MData = ( 1 / sqrt(10) ) * modulate_16QAM(data);
        case 64
            MData = ( 1 / sqrt(42) ) * modulate_64QAM(data);
        otherwise
            errordlg('NUMBER OF INCORRECT LEVELS - MODULATION')
    end
	
end
%%
    % *See also*
    %
    % <modulate_BPSK.html modulate_BPSK> 
    %
    % <modulate_QPSK.html modulate_QPSK>
    %
    % <modulate_16QAM.html modulate_16QAM>
    %
    % <modulate_64QAM.html modulate_64QAM>
    %
    % <Create_SIGNAL.html Create_SIGNAL> 
    %
    % <Create_DATA.html PLCP DATA> 