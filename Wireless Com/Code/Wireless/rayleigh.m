% Fading Model
function rayleigh_h = rayleigh(n,P)
x = randn(1, n) + 1i * randn(1, n);
x = x / norm(x);
rayleigh_h = sqrt(P/2) * x;
end