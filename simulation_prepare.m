close all
load('Data/sprungantwort2.mat');
t = [0:300];
Xa = zeros(300,1);

Tstart = 31.6;
YStart = 32;
Tt = 22.5;

Xa_tm1 = 103.8;
tm_1 = 298.5-Tt-Tstart;
xe_0 = 0.6;
T1 = 68.6-Tt-Tstart;


KiKs = (Xa_tm1/(xe_0*(tm_1-(T1))));

for i = 1:length(t)
     Xa(i) = (i>Tt+Tstart) * KiKs * ((i-Tt-Tstart) - T1 * (1 - exp(-(i-Tt-Tstart)/T1))) * xe_0;
end

plot(pwm.time,pwm.data, 'g')
hold on
plot(sumBuf.time,sumBuf.data-YStart, 'b')
hold on
p = plot(t,Xa, 'r');
set(p,'LineWidth',3);
legend({'Sprung','Sprungantwort','ITt + It1 -Element'})

Kp=0.015; 
s = tf('s');
Gs =  Kp* KiKs *exp(-s*Tt) /((1+s*T1) *(s));

figure
margin(Gs);