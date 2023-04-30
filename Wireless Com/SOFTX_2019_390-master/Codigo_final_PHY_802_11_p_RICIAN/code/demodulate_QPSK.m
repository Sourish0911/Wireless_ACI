%% QPSK demodulation
    % Performs the demodulation based on the QPSK scheme.
    %% *Syntax*
    % IDATA = demodulate_QPSK(MDATA)
    %% *Description*
    % The demodulate_QPSK(MDATA) function returns a set of demodulated bits
    % based on the QPSK scheme.
    %%
    % 
    % <<Di_cons_QPSK.PNG>>
    % 
    % *Input Arguments*
    %
    % * MDATA
    %
    % Frequency modulated QPSK symbols
    %
    % *Output Arguments*
    %
    % * IDATA
    %
    % Demodulated bits. 
    %
    %% *Example*
    % The function demodulate_QPSK(MDATA) is called.
function IDATA = demodulate_QPSK(MDATA)
%%
    % It is analyzed where it falls within the constellations map. The
    % horizontal hemisphere corresponds to the real part and the vertical 
    % hemisphere corresponds to the imaginary part. 
    IDATA = zeros(1,length(MDATA)*2);
    for i = 1:length(MDATA)                
        j = (i-1)*2 +1;
        if real(MDATA(i)) > 0                     % Positive horizontal hemisphere
            IDATA(j)   = 1;
        else                                        % Negative horizontal hemisphere
            IDATA(j)   = 0;
        end
        
        if imag(MDATA(i)) > 0                      %Positive vertical hemisphere
            IDATA(j+1) = 1;
        else                                        %Negative vertical hemisphere
            IDATA(j+1) = 0;
        end
        
    end

end
%%
    % *See also*
    %
    % <modulate_QPSK.html QPSK modulation>
    %
    % <demodulate_String.html String demodulation>