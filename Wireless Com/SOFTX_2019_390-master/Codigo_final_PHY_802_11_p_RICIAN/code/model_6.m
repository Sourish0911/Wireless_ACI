%% Predictive theoretical model of PER #6
    % Model of upper bound for OFDM system, with model to obtain the BER #3.
    %% *Syntax*
    % PER = model_o6(SNR, M, r, l)
    %% *Description*
    % The model_6(SNR, M, r, l) function describes a model for calculating 
    % an upper bound of the PER in IEEE 802.11p systems.
    % More precise considerations are made with respect to the coding
    % rates, free distance and the number of paths at given distances of
    % the trellis diagram of the convolutional encoder with the 
    % corresponding puncture patterns.
    % An SNR value is also taken into account by OFDM symbol considering 
    % the contribution of the cyclic prefix.
    % The BER value for this model is calculated independently in a 
    % function called *modeloBER3()* and the PER is ultimately parameterized 
    % with respect to the SNR and the length of the packet (L). 
    %
    % The PER value is given by the equation:
    %%
    % 
    % <<MPER_04.PNG>>
    % 
    % The value *d* is the minimum distance of the convolutional code
    % that represents the minimum distance of a code word that moves
    % away from the path of all 0 in the Trellis diagram.
    % The value *a* represents the number of roads in the Trellis diagram of length d.
    % These values are constants obtained from the following table.
    %%
    % 
    % <<tab_03.PNG>>
    % 
    % *Input Arguments*
    %
    %
    % * SNR
    %
    % SNR value.
    %   
    % * M
    %
    % Modulation scheme.
    %
    % * r
    %
    % Coding rate.
    %
    % * l
    %
    % Packet length in bits.
    % 
    % *Output arguments*
    %
    % * PER
    %
    % Calculated PER value.
    %
    %% *Examples*
    % The model_6(SNR, M, r, l) function is called.
function PER = model_6(SNR, M, r, l)
%%
    % The BER value is obtained with modeloBER3() and depends on the SNR, 
    % the modulation scheme and the coding rate.
    SNR = 10^(SNR/10);
    be = model_BER3(SNR, M, r);
%%
    % Depending on the coding rate, the parameters are chosen.
    switch r
        case 1/2
            adv = [11, 0, 38, 0, 193, 0, 1331, 0, 7275, 0];
            dfree = 10;
        case 3/4
            adv = [8, 31, 160, 892, 4512, 23307, 121077, 625059, 3234886, 16753077];
            dfree = 5;
        case 2/3
            adv = [1, 16, 48, 158, 642, 2435, 9174, 34705, 131585, 499608];
            dfree = 6;
    end
%% 
    % Summation calculation for all dfree values
    sum = 0;
    i = 1;
    for d=dfree:(dfree+9)
        Pd = 0;
        if(mod(d,2) == 0)   % It is par
            for k = ((d/2) + 1):d
                b = nchoosek(d,k);
                sn = b*(be^k)*((1 - be)^(d-k));
                Pd = Pd + sn;
            end
            sn2 = (1/2)*nchoosek(d,d/2)*(be^(d/2))*((1-be)^(d/2));
            Pd = Pd + sn2;
        else                  % It is odd
            for k = ((d+1)/2):d
                b = nchoosek(d,k);
                sn = b*(be^k)*((1 - be)^(d-k));
                Pd = Pd + sn;
            end
        end
        sum = sum + adv(i)*Pd;
        i = i + 1;
    end
 %%
    % The PER is calculated with the corresponding formula.   
    PER = 1 - (1 - sum)^l;
    if(PER<0)
        PER = 1;
    end
end
%%
    % *See also*
    %
    % <model_BER3.html model_BER3> 
    % 
    % <evaluate_models.html Evaluation of theoretical models> 