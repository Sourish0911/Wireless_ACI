%% 64-QAM demodulation
    % Performs the demodulation based on the 64-QAM scheme.
    %% *Sintaxis*
    % IDATA = demodulate_64QAM(MDATA)
    %% *Description*
    % The demodulate_64QAM(MDATA) function returns a set of modulated 
    % bits based on the 64-QAM scheme.
    %%
    % 
    % <<Di_cons_64QAM.PNG>>
    % 
    % *Input Arguments*
    %
    % * MDATA
    %
    % Frequency modulated 64-QAM symbols.
    %
    % *Output Arguments*
    %
    % * IDATA
    %
    % Demodulated bits.   
    %% *Examples*
    % The function demodulate_64QAM(MDATA) is called.
function IDATA = demodulate_64QAM(MDATA)
%% 
    % Each bit combination is assigned according to what is specified 
    % in the standard constellation diagram. The horizontal hemisphere 
    % corresponds to the real part and the vertical hemisphere corresponds
    % to the imaginary part. Each hemisphere is divided in right or left, 
    % internal or external and horizontal or vertical depending on
    % the index of the IDATA.
    IDATA = zeros(1,length(MDATA)*6);    
    for i=1:length(MDATA)
        j = (i-1)*6 + 1;                % IDATA index
        if real(MDATA(i)) > 0           % Right horizontal hemisphere
            IDATA(j) = 1;
        else                            % Left horizontal hemisphere
            IDATA(j) = 0;
        end
        
        if abs(real(MDATA(i))) < 4      % Internal horizontal hemisphere
            IDATA(j+1) = 1;
        else                            % External horizontal hemisphere
            IDATA(j+1) = 0;
        end
        
        if abs( abs(real(MDATA(i))) - 4 ) < 2       % Lateral horizontal center
            IDATA(j+2) = 1;
        else                                        % Lateral horizontal end
            IDATA(j+2) = 0;
        end 
        
        if imag(MDATA(i)) > 0           % Right vertical hemisphere
            IDATA(j+3) = 1;
        else                            % Left vertical hemisphere
            IDATA(j+3) = 0;
        end
        
        if abs(imag(MDATA(i))) < 4      % Internal vertical hemisphere
            IDATA(j+4) = 1;
        else                            % External vertical hemisphere
            IDATA(j+4) = 0;
        end
        
        if abs( abs(imag(MDATA(i))) - 4 ) < 2       % Lateral vertical center
            IDATA(j+5) = 1;
        else                                        % Lateral vertical end
            IDATA(j+5) = 0;
        end  
    end

end
%%
    % *See also*
    %
    % <modulate_64QAM.html 64QAM modulation>
    %
    % <demodulate_string.html String demodulation>