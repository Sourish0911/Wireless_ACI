%% Theoretical model of BER #1
    % Obtains the BER value in function of the SNR and modulation scheme.
    %% *Syntax*
    % BER = model_BER1(SNR, M, r)
    %% *Description*
    % The model_BER1(SNR, M, r) function performs the calculation of the
    % BER according to a value of SNR, the modulation scheme and the 
    % coding rate. The BER value is given by the generic equation:
    %%
    % 
    % <<MBER_01.PNG>>
    % 
    % Where $\gamma$ is the SNR and $c_{m}$ and $k_{m}$ are constants that depend on the
    % modulation scheme. The values of $c_{m}$ and $k_{m}$ are defined by 
    % the IEEE 802.11 standard and specified below.
    %%
    % 
    % <<tab_02.PNG>>
    %
    % For the different modulation schemes, the BER formulas that are used 
    % in the model_BER1() are the following.
    %%
    % 
    % <<MBER_01.1.PNG>>
    %  
    % Q(') is the function Q defined by equation:
    %%
    % 
    % <<Q.PNG>>
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
    % *Output arguments*
    %
    % * BER
    %
    % Calculated BER value.
    %
    %% *Examples*
    % The model_BER1(SNR, M, r)  function is called.
function BER = model_BER1(SNR, M, r)
    m = log2(M);
    v = 6*m*r;
    c = [   1       2;
            1       2;
            3/4     4/5;
            7/12    2/7;
        ];
 %% 
    % The values of the constants are chosen depending on the modulation
    % scheme.   
    switch M
        case 2
            f=1;
        case 4
            f=2;
        case 16
            f=3;
        case 64
            f=4;
    end
 %%
    % Assignment of $c_{m}$ and $k_{m}$ constants. 
    cm = c(f,1);
    km = c(f,2) * (10 / v);
  %%
    % The BER is calculated with the corresponding formula.    
    BER = cm*qfunc(sqrt(km*SNR));
end
%%
    % *See also*
    %
    % <model_4.html Predictive theoretical model of PER #4> 
    %
    % <model_7.html Predictive theoretical model of PER #7> 