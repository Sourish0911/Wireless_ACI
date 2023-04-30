% Path loss Model
% fc in MHz
function PL = path_loss(d,fc)
h_tx = 1;
h_rx = 1;
lambda = (3*10^8)/(fc*10^6);
% Calculate the path loss
PL = 20*log10(4*pi*d/lambda) + 20*log10(h_tx) + 20*log10(h_rx);
end