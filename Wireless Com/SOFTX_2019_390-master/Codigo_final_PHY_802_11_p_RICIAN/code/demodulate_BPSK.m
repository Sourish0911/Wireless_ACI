%% BPSK Demodulation
    % Performs the demodulation based on the BPSK scheme.
    %% *Syntax*
    % IDATA = demodulate_BPSK(MDATA)
    %
    %% *Description*
    % The demodulate_BPSK(MDATA) function returns a set of demodulated bits 
    % based on the BPSK scheme. 
    %%
    % 
    % <<Di_cons_BPSK.PNG>>
    % 
    % *Input Arguments*
    %
    % * MDATA
    %
    % Frequency modulated BPSK symbols.
    %
    % *Output Arguments*
    %
    % * IDATA
    %
    % Demodulated bits. 
    %
    %% *Example*
    % The function demodulate_BPSK(MDATA) is called.
function IDATA = demodulate_BPSK(MDATA)
%%

    bitsDemodu = comm.PSKDemodulator(2,'BitOutput', true, 'PhaseOffset', 0);
    IDATA = step(bitsDemodu, MDATA');
    IDATA = IDATA';

end
%%
    % *See also*
    %
    % <https://la.mathworks.com/help/comm/ref/comm.pskdemodulator-system-object.html comm.PSKDemodulator> 
    %
    % <https://la.mathworks.com/help/matlab/ref/step.html step>
    %
    % <demodularString.html String demodulation>
    %
    % <modulate_BPSK.html BPSK modulation>