%% BPSK Modulation
    % Performs the modulation based on the BPSK scheme.
    %% *Syntax*
    % modulated = modulate_BPSK(data)
    %
    %% *Description*
    % The function modulate_BPSK(data) returns a set of modulated bits 
    % based on the BPSK scheme. Depending on each input bit, 
    % a complex symbol is selected according to the BPSK constellation diagram
    % mentioned in the 802.11-2012 standard.
    %%
    % 
    % <<Di_cons_BPSK.PNG>>
    % 
    % *Input Arguments*
    %
    % * data
    %
    % Input vector, specified as an unmodulated bit vector.
    %
    % *Output Arguments*
    %
    % * modulated 
    %
    % Frequency modulated BPSK symbols. 
    %
    %% *Example*
    % The function modulate_BPSK(data) is called.
function modulated = modulate_BPSK(data)
%% 
    % Modulation is performed based on a Matlab PSK Modulator object.
    bitsModu = comm.PSKModulator(2,'BitInput', true, 'PhaseOffset', 0);
    modulated = step(bitsModu,data');
    modulated = modulated';   
end
%%
    % *See also*
    %
    % <https://la.mathworks.com/help/comm/ref/comm.pskmodulator-system-object.html comm.PSKModulator> 
    %
    % <https://la.mathworks.com/help/matlab/ref/step.html step>
    %
    % <modulation_string.html String modulation>
    %
    % <demodulate_BPSK.html BPSK demodulation>