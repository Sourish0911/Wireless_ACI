%% Theoretical model of BER #3
    % Obtains the BER value in function of the SNR and modulation scheme.
    %% *Syntax*
    % BER = model_BER3(SNR, M, r)
    %% *Description*
    % The model_BER3(SNR, M, r) function performs the calculation of the
    % BER according to a value of SNR, the modulation scheme and the 
    % coding rate. The berawgn (.) function of MATLAB is used to
    % calculate the BER. The equations for the different modulation 
    % schemes are shown below.
    %
    % For BPSK modulation.
    %%
    % 
    % <<BPSK_03.PNG>>
    %
    % For QPSK modulation.
    %%
    % 
    % <<QPSK_03.PNG>>
    %
    % For 16-QAM modulation.
    %%
    % 
    % <<16QAM_03.PNG>>
    %
    % For 64-QAM modulation.
    %%
    % 
    % <<64QAM_03.PNG>>
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
    % The model_BER3(SNR, M, r)  function is called.
function BER = model_BER3(SNR, M, r)
%%
    % The values are defined based on the modulation scheme. The parameter
    % Eb / No is the ratio of bit energy to spectral noise density
    % and relates it to the SNR with the formula below.
    %%
    % 
    % <<Eb_no_MBER_03.PNG>>
    % 
    
    m = log2(M);
    v = 6*m*r;
    EbNo = SNR * (10 / v);
%% 
    % The values are chosen depending on the modulation
    % scheme. 
    switch M
        case 2
            modo = 'psk';
            opc = 'nondiff';
        case 4
            modo = 'psk';
            opc = 'nondiff';
        case 16
            modo = 'qam';
            opc = '';
        case 64
            modo = 'qam';
            opc = '';
    end
  %%
    % The BER is calculated with the corresponding formula.      
    BER = berawgn(EbNo,modo,M,opc);
    
end
%%
    % *See also*
    %
    % <model_6.html Predictive theoretical model of PER #6> 
    %
    % <model_9.html Predictive theoretical model of PER #9> 