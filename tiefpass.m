close all;


% g(s) = 1/(1+s/wc)
% g(z) = (wc + wc* z^-1) / ((2*fa + wc) + (wc-2*fa)*z^-1)

wc = 2*pi*10; % Grenzfreqzenz 10 hz
fa = 1000;
nfft = 500;


b = [wc]; 
a = [1 wc];
%freqs: hohe potenzen zuerst, dann absteigend
%skale in rad/s

freqs(b,a); 


figure;

b = [wc wc]
a = [(2*fa+wc) (wc-2*fa)]
% freqz: tiefen potenzen zurest, dann aufsteigend
% Simulink diskrete tf block: hohe potenzen zuerst
% skala in rad/s

[h w] = freqz(b,a,nfft,fa); 
loglog(w, abs(h));
grid on;

