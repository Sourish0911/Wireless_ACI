function [PER_1k,BER_1k] = PaqER(fc,fc_adj,dist_des,dist_intf,N0_lin)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

%% Constants
Num = 100;
M = 2;
r = 1/2;
G_t = 1;              % Transmit antenna gain in dBi
G_r = 1;              % Receive antenna gain in dBi
Pt = 23;
Pt_adj_loss = -40;
h_tx = 1;
h_rx = 1;
num_paq = 1000;
BER_iter = zeros(num_paq,1);
PER_iter = zeros(num_paq,1);
lambda_fc = 3e8/fc;
lambda_fc_adj = 3e8/fc_adj;

%% Path Loss Model
Prx_dbm = Pt+G_t+G_r-20*log10(4*pi*dist_des/lambda_fc) + 20*log10(h_tx) + 20*log10(h_rx);
Pint_rx_dbm = Pt+G_t+G_r-20*log10(4*pi*dist_intf/lambda_fc_adj) + 20*log10(h_tx) + 20*log10(h_rx)-Pt_adj_loss;
Prx = 10^(Prx_dbm/10); % Power in mW
Pint = 10^(Pint_rx_dbm/10); % Power in mW

snr_lin = Prx/(Pint+N0_lin);
sd = 1/snr_lin;

for i = 1:num_paq
    errores = 0;
    bitErr = 0;
    paqErr = 0;
    %% Transmitter_fc Desired Link
    signal = Create_SIGNAL();
    sync = Create_SYNC();
    PSDU = round(rand(1,Num));
    DATA = Create_DATA(PSDU,M,r);
    
    package = [sync signal DATA];

    total_size = length(package);

    
    %% Channel
    h_rayleigh_fc = randn(1,1);
    channel_op_fc = h_rayleigh_fc.*package;
    % y = h*X+N+I

    

    %% Reciever
    nrx = sqrt(sd)*(randn(1,total_size)+1i*randn(1,total_size));
    rx_package = nrx+channel_op_fc;
    data = extract_DATA(rx_package);
    psdu_rx = process_DATA(data, M,r,Num);


    %% Error Calculation
            errores = sum( abs( psdu_rx -  PSDU) );   
            if errores > 0 
                paqErr = paqErr + 1;                                            
            end
            bitErr = bitErr + errores;                                                   
%% The BER and PER values for each SNR are obtained and stored in the
        BER_iter(i,1) = bitErr;
        PER_iter(i,1) = paqErr;
end
PER_1k = sum(PER_iter)/(num_paq);
BER_1k = sum(BER_iter)/(Num*num_paq);
end