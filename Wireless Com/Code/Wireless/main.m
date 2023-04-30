
%% Constants
k = 1.38e-23; % Boltzmann's constant
T = 300; % receiver temperature in Kelvin
B = 10e6; % receiver bandwidth in Hertz
N = k*T*B; % Noise Power

%% Mask
% Freq in MHz
pos_freq = [4.5, 5, 5.5, 10, 15];
neg_freq = [-4.5, -5, -5.5, -10, -15];
neg_freq = flip(neg_freq);
mag_mask = [0, -26, -32, -40, -50];% in dBr
mag_append = flip(mag_mask);

freq_all = cat(2,neg_freq,pos_freq);
mag_all = cat(2,mag_append,mag_mask);

figure(1)
plot(freq_all,mag_all)
title('Base Mask for Wave Class C Tx')
xlabel('Frequency in MHz')
ylabel('Magnitude in dB')

len = length(freq_all);

freq_all_trans = zeros(len,1);
for i = 1:len
    freq_all_trans(i) = freq_all(i) + 5900; 
end

figure(2)
plot(freq_all_trans,mag_all)
title('Mask of Class C Wave Tx at 5.9 GHz')
xlabel('Frequency in MHz')
ylabel('Magnitude in dB')

fc_list = [5855,5865,5875,5885,5895,5905,5915];
rows = length(fc_list);
col = len;

mag_var_freq = zeros(rows,col);
for i = 1:rows
    for j = 1:col
        mag_var_freq(i,j) = fc_list(i) + freq_all(j);
    end
end

figure(3)
for i = 1:rows
plot(mag_var_freq(i,:),mag_all)
hold on
end

%% Mobility Model for Vehicles
v1_start_x = 1000;
v1_start_y = 4;
v2_start_x = 1000;
v2_start_y = 0;
v0_start_x = 500;
v0_start_y = 4;
v3_start_x = 1005;
v3_start_y = 0;
%Distance between V0 and V1
d1 = zeros(49,1);

%Distance between V2 and V3
d2 = zeros(49,1);

v0_xmobile = zeros(49,1);
v3_xmobile = zeros(49,1);
% PL_1 Path loss between V0 and V1
PL_1 = zeros(49,1);
% PL_2 Path loss between V2 and V3
PL_2 = zeros(49,1);
for i = 1:49
    v0_xmobile(i) = v0_start_x +10*i;
    d1(i) = dist(v0_xmobile(i),v0_start_y,v1_start_x,v1_start_y);
    PL_1 = path_loss(d1(i),fc_list(3));
    v3_xmobile(i) = v3_start_x +10*i;
    d2(i) = dist(v3_xmobile(i),v3_start_y,v2_start_x,v2_start_y);
    PL_2 = path_loss(d2(i),fc_list(4));
end

% SNR Calculation
SNRnum = length(PL_2);
ERROREST  = zeros(8,SNum);  % Matrix to store the number of errors for each SNR for each configuration.
BERT      = zeros(8,SNum);  % Matrix to store the BER for each SNR for each configuration.
PERT      = zeros(8,SNum);  % Matrix to store PER for each SNR for each configuration.
for i = 1:SNRnum

end

