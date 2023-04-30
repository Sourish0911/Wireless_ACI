%% Polarity generator
    %  Generation of the polarity factor for a OFDM symbol.
    %% *Syntax*
    %  polarity = generate_pilot_polarity()
    %% *Description*
    % The function generate_pilot_polarity() returns a polarity factor vector according 
    % to the IEEE 802.11-2012 standard. There are 127 polarity values that 
    % are given by the standard. For symbols beyond the 127th, operation 
    % n mod 127 is performed to determine the index of the polarity values.
    %% *Examples*
    %
    % The función generate_pilot_polarity() is called.
function polarity = generate_pilot_polarity()
%%
    % The values are asigned to the index according 
    % to the IEEE 802.11 standard
    polarity = [1,1,1,1,-1,-1,-1,1, -1,-1,-1,-1, 1,1,-1,1, ...
    -1,-1,1,1, -1,1,1,-1, 1,1,1,1, 1,1,-1,1,1,1,-1,1, 1,-1,-1,1, ...
    1,1,-1,1, -1,-1,-1,1, -1,1,-1,-1, 1,-1,-1,1, 1,1,1,1, ...
    -1,-1,1,1,-1,-1,1,-1, 1,-1,1,1, -1,-1,-1,1, 1,-1,-1,-1, ... 
    -1,1,-1,-1, 1,-1,1,1, 1,1,-1,1, -1,1,-1,1,-1,-1,-1,-1, ...
    -1,1,-1,1, 1,-1,1,-1, 1,1,1,-1, -1,1,-1,-1, -1,1,1,1, -1,-1,-1,-1, -1,-1,-1];
end
%%
    % *See also*
    %
    % <modulation_OFDM.html modulation_OFDM>