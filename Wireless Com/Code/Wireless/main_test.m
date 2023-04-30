
Num = 4096*16;
M = 2;
r = 1/2;

signal = Create_SIGNAL();
sync = Create_SYNC();
PSDU = round(rand(1,Num));
DATA = Create_DATA(PSDU,M,r);

package = [sync signal DATA];


h_rayleigh = randn(1,Num);

Pt = 23; %Transmit power in dBm

f_c = 5900e6;          % Carrier frequency in Hz
d = 1000;             % Distance between transmitter and receiver in meters
G_t = 1;              % Transmit antenna gain in dBi
G_r = 1;              % Receive antenna gain in dBi
L = 1;                % Path loss exponent
sigma = 1;            % Standard deviation of the shadow fading in dB

k = 1.38e-23; % Boltzmann's constant
T = 300; % receiver temperature in Kelvin
B = 10e6; % receiver bandwidth in Hertz
N = k*T*B; % Noise Power

PL = path_loss(d,f_c);
P_r = Pt + G_r + G_t - PL + randn*sigma;  


