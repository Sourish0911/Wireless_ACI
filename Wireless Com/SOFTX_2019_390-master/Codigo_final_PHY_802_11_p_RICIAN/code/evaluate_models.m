%% Evaluation of theoretical models
    % Evaluate the 9 different theoretical models for obtaining PER.
    %% *Syntax*
    % PER = evaluate_models(SNR, M, r, l, num)
    %% *Description*
    % The evaluate_models(SNR, M, r, l, num) function chooses the desired 
    % theoretical model based on the variable *num*. It runs the theoretical 
    % model for each SNR of the entered SNR range and save the 
    % results in a PER vector.
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
    % * num
    %
    % Identifier of theoretical model to use.
    %
    % *Output arguments*
    %
    % * PER
    %
    % Calculated PER value.
    %
    %% *Examples*
    % The evaluate_models(SNR, M, r, l, num) function is called.
function PER = evaluate_models(SNR, M, r, l, num)
%% 
% The theoretical model to be used is selected based on num.
    N = length(SNR);
    PER = zeros(1,N);
    funcStr = strcat('model_', num2str(num));
    modelFunc = str2func(funcStr);
%% 
% Evaluate the PER for each SNR value.
    for i=1:N
        PER(i) = modelFunc(SNR(i), M, r, l);
        if(PER(i) < 0)
            PER(i) = 1;
        end
    end
    
end
%%
% *See also*
% 
% <model_1.html Predictive theoretical model of PER #1> 
% 
% <model_2.html Predictive theoretical model of PER #2> 
% 
% <model_3.html Predictive theoretical model of PER #3> 
% 
% <model_4.html Predictive theoretical model of PER #4> 
% 
% <model_5.html Predictive theoretical model of PER #5> 
% 
% <model_6.html Predictive theoretical model of PER #6> 
% 
% <model_7.html Predictive theoretical model of PER #7> 
% 
% <model_8.html Predictive theoretical model of PER #8> 
% 
% <model_9.html Predictive theoretical model of PER #9>  