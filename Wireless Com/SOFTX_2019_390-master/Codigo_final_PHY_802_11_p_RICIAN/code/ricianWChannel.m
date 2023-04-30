%% ricianWChannel
    % It generates a rician channel 
    %  
    %% *Syntax*
    % [channel,symOffset,sampIdx] = ricianWChannel(C)
    %% *Description*
    % The ricianWChannel(C) function generates a channel which is defined
    % by four parameters:
    %
    %       ray_pow:            relative power of the rays [dB]
    %
    %       ray_delay:          relative delay of each ray [s]
    %
    %       ray_doppler_shift:  doppler shift frequency for each ray [Hz]
    %
    %       ray_kfact:          0 for a pure Rayleigh channel, high for a pure
    %                           Rician channel
    %
    % *Input Arguments*
    %
    % * C
    %
    % variable that defines the type of channel. The allowed values are:
    %
    %   1:  Rural Line-of-Sight
    %
    %   2:  Urban Line-of-Sight
    %
    %   3:  Highway Line-of-Sight
    %
    %   4:  Highway Non-Line-of-Sight
    %
    %
    % *Output arguments*
    %
    % * channel
    %
    % object containing the defined channel
    %
    % * symOffset
    %
    % sampling offset
    %
    % * sampIdx
    %
    % vector with normalized delays of the rays
%% *Examples*
    % The ricianWChannel(C) is called.

function [ channel,symOffset,sampIdx ] = ricianWChannel( C )
%% 
    % The parameters of the four channels are selected according to C.
    switch C
        case 1
            ray_pow = [0 -14 -17];
            ray_delay = [0 100 200]*1e-9;
            ray_doppler_shift = [0 492 -295];
            ray_kfact = [1e12 0 0];
        case 2
            ray_pow = [0 -8 -10 -15];
            ray_delay = [0 100 200 300]*1e-9;
            ray_doppler_shift = [0 236 -157 492];
            ray_kfact = [1e12 0 0 0];
        case 3
            ray_pow = [0 -10 -15 -20];
            ray_delay = [0 100 200 500]*1e-9;
            ray_doppler_shift = [0 689 -492 886];
            ray_kfact = [1e12 0 0 0];
        case 4
            ray_pow = [0 -2 -5 -7];
            ray_delay = [0 200 400 700]*1e-9;
            ray_doppler_shift = [0 689 -492 886];
            ray_kfact = [0.1 0 0 0];
    end
    
%% 
    % We define the Doppler spectrum parameters.
    %
    fd = max(abs(ray_doppler_shift));    %maximum doppler shift
    % We set up a cell array for each doppler spectrum per ray
    ray_doppler_spectrum = cell(size(ray_doppler_shift));
    % We create the doppler spectrum per ray into the cell array
    ray_doppler_spectrum{1} = doppler('Asymmetric Jakes', [-.02 .02]);
    for j = 2:length(ray_doppler_shift)
        ray_doppler_spectrum{j} = doppler('Asymmetric Jakes', sort([0 ray_doppler_shift(j)/fd]));
    end
    
%% 
    % We define the sample rate based on the standard AB. We set-up the channel
    % with the established parameters. We make sure
    % to set 'PathGainsOutputPort' as true to obtain the channel response for equalization purposes.  

    samp_rate = 10*1e6;
        
    channel = comm.RicianChannel (...
        'KFactor',                  ray_kfact, ...
        'DirectPathDopplerShift', 	ray_doppler_shift, ...
        'DirectPathInitialPhase', 	zeros(size(ray_kfact)), ...
        'DopplerSpectrum',          ray_doppler_spectrum, ...
        'SampleRate',               samp_rate, ...
        'PathDelays',               ray_delay, ...
        'AveragePathGains',         ray_pow, ...
        'MaximumDopplerShift',      fd, ...
        'PathGainsOutputPort',      true ...
        );

%%    
    % We compute the indices corresponding to the normalizaed delays.
    % Finally, the sampling offset is obtained.
    sampIdx = round(ray_delay/(1/samp_rate)) + 1;
    symOffset = min(max(sampIdx),16);
end