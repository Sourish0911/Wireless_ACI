%% 16-QAM modulation 
    % Performs the modulation based on the 16-QAM scheme.
    %% *Syntax*
    % modulated = modulate_16QAM(data)
    %% *Description*
    % The function modulated = modulate_16QAM(data) returns a set of modulated 
    % bits based on the 16-QAM scheme. It assigns to each four input bits,
    % a complex symbol according to the 16-QAM constellation diagram
    % mentioned in the 802.11-2012 standard.
    %%
    % 
    % <<Di_cons_16QAM.PNG>>
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
    % Frequency modulated 16QAM symbols. 
    %% *Examples*
    % The function modulate_16QAM(data) is called.
function modulated = modulate_16QAM(data)
%%
    % M is defined as the number of phases used for this modulation 
    % and m as the number of bits assigned to each symbol.
    M = 16;
    m = 4;
    modulated = zeros(1,length(data)/m);
%%
    % Each bit combination is assigned according to what is specified 
    % in the standard constellation diagram. The variable re is used for
    % the real part of the number and im is used for the imaginary part 
    % of the number.
    %
    % It must be taken into account that the first bit (i) determines 
    % the horizontal hemisphere, the second bit (i + 1) determines the 
    % horizontal distance to the origin. The third bit (i + 2) determines 
    % the vertical hemisphere and the fourth bit (i + 3) determines the 
    % vertical distance to the origin.
    for i = 1:m:length(data)
        re = 0;
        im = 0*i;
        
        if data(i) == 1                
            re = +1;
        else
            re = -1;
        end
        
        if data(i+1) == 1              
            re = re*1;
        else
            re = re*3;
        end
        
        if data(i+2) == 1              
            im = +1i;
        else
            im = -1i;
        end
        
        if data(i+3) == 1              
            im = im*1;
        else
            im = im*3;
        end
        
        modulated( (i+m-1)/m ) = re + im;
    end   
end

%%  
    % *See also*
    %
    % <demodulate_16QAM.html 16QAM demodulation>
    %
    % <modulation_string.html String modulation>