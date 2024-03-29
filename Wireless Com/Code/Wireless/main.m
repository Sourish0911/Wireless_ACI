
%% Constants
Num = 4096*8;
M = 2;
r = 1/2;
f_c = 5900e6;          % Carrier frequency in Hz
d = 1000;             % Distance between transmitter and receiver in meters
G_t = 1;              % Transmit antenna gain in dBi
G_r = 1;              % Receive antenna gain in dBi
L = 1;                % Path loss exponent
sigma = 1;            % Standard deviation of the shadow fading in dB

N0_norm = -174;
bw = 10e6;
N0 = N0_norm+10*log(bw);%Noise power in dBm
N0_lin = 10^(N0/10);
Pt = 23; %Transmit power in dBm
bw = 10e6;

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

fc_list = [5860,5870,5880,5890,5900,5910,5920];
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
d1 = zeros(9,1);
%Distance between V2 and V3
d2 = zeros(9,1);

v0_xmobile = zeros(9,1);
v3_xmobile = zeros(9,1);

% Case 1
PER_0_1 = zeros(9,1);
BER_0_1 = zeros(9,1);
for i = 1:9
    v0_xmobile(i) = v0_start_x +50*i;
    d1(i) = dist(v0_xmobile(i),v0_start_y,v1_start_x,v1_start_y);
    
    v3_xmobile(i) = v3_start_x +50*i;
    d2(i) = dist(v3_xmobile(i),v3_start_y,v2_start_x,v2_start_y);
    
    [PER_0_1(i),BER_0_1(i)] = PaqER(fc_list(4),fc_list(3),d1(i),d2(i),N0_lin);
end


