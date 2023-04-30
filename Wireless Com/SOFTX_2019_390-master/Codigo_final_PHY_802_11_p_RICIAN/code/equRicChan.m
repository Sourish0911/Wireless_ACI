%% equRicChan
    % Performs an ideal equalization given the ideal frequency response of
    % the channel.
    %  
    %% *Syntax*
    % eqData = equRicChan(X, H)
    %% *Description*
    % The equRicChan(X, H) function equalizes the received signal with the
    % ideal frequency response of the channel
    %
    % *Input Arguments*
    %
    % * X
    %
    % received frame in time domain
    %
    % * H
    %
    % ideal channel frequency response
    %
    % *Output arguments*
    %
    % * eqData
    %
    % equalized signal in time domain
%% *Examples*
    % The function equRicChan(X, H) is called.

function eqData = equRicChan(X, H)
%%
    % We first unroll our vectors so that there is no issue with the
    % dimensions.
    X = X(:);
    H = H(:);
%%
    % We perform a simple division between the frame in frequency and 
    % the channel response in frequency. Then, we transform it into time
    % domain.
    
    eqData = ifft(fft(X)./H);
end