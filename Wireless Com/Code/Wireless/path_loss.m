% Path loss Model
% fc in MHz
function Prx = path_loss(d,fc)
h_tx = 1;
h_rx = 1;
Pt = 23;
Gt = 1;
Gr = 1;
lambda = (3*10^8)/(fc*10^6);
% Calculate the path loss
Prx_dbm = Pt+Gt+Gr-20*log10(4*pi*d/lambda) + 20*log10(h_tx) + 20*log10(h_rx);
Prx = 10^(Prx_dbm/10); % Power in mW
end