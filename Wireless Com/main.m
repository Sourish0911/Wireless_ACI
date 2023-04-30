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
%% Path loss Model

%% Fading Model

%% Mobility Model for Vehicles
v1_start_x = 1000;
v1_start_y = 4;
v2_start_x = 1000;
v2_start_y = 0;
v0_start_x = 500;
v0_start_y = 4;
v3_start_x = 1005;
v3_start_y = 0;



%% Functions
function d = dist(x1,y1,x2,y2)
    d = sqrt((x1-x2)^2+(y1-y2)^2);
end

function rayleigh_h = rayleigh(n,P)
x = randn(1, n) + 1i * randn(1, n);
x = x / norm(x);
rayleigh_h = sqrt(P/2) * x;
end


