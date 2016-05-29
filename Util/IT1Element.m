% % Definitions
% Ks = 1;
% Ki = 1;
% T1 = [1 10 100 1000];
% Xe0 = 0.5;
% 
% %Xa = zeros(length(sumSensor.data));
% Xa = zeros(1000,1);
% 
% % Plot Xa
% subplot(1,2,1)
% 
% for j = 1:length(T1)
%     % Plot IT1 element
%     for i = 1:length(Xa)
%         Xa(i) =  Ks * Ki * (i - T1(j) * (1 - exp(-i/T1(j)))) * Xe0;
%     end
%     
%     hold on
%     plot(Xa)
%     
% end

% Plot pwm data and sumSensor
% subplot(1,2,2)
close all
t = [0:300];
Xa = zeros(300,1);

Xa_tm1 = 50.31;
tm_1 = 138.1;
xe_0 = 0.6;
T1 = 20;
Tstart = 31.6;
YStart = 32;

KiKs = (Xa_tm1/(xe_0*(tm_1-(T1))));

for i = 1:length(t)
     Xa(i) = KiKs * (i - (T1) * (1 - exp(-i/(T1)))) * xe_0;
end

plot(pwm.time,pwm.data, 'g')
hold on
plot(sumBuf.time,sumBuf.data-YStart, 'b')
hold on
plot(t+Tstart,Xa, 'r')


figure
s = tf('s');
Gs = KiKs /((1+s*T1) *(s)); %*exp(-s*20);
bodeplot(Gs);

%Wir haben keine reine PI Strecke sondern noch eine Strecke mit Totzeit.
%TODO: Totzeit hinzuf�gen und Model & Bode neu berechen
% P oder PI-Regler sollten aber reichen.

%% ITt

close all
t = [0:300];
Xa = zeros(300,1);

Tt = 35;
xe_0 = 0.6;
Xa_tm1 = 100;
tm_1 = 260;



Tstart = 31.6;
YStart = 32;

Ki= Xa_tm1 / (xe_0*(tm_1-Tt));

for i = 1:length(t)
     Xa(i) =Ki* (i>Tt) * xe_0 * (i-Tt); 
end

plot(pwm.time,pwm.data, 'g')
hold on
plot(sumBuf.time,sumBuf.data-YStart, 'b')
hold on
p = plot(t+Tstart,Xa, 'r');
set(p,'LineWidth',3);
legend({'Sprung','Sprungantwort','ITt-Element'})



Kp=1; %50DB
figure
s = tf('s');
Gs = Kp*Ki*exp(-s*Tt) / s;
bodeplot(Gs);
xlim([0.001 2])

figure
margin(Gs);

%% ITt + IT1

close all
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

% noch nicht ok:
%xu = ( KiKs * ((T1-Tt) - T1 * (1 - exp(-(T1-Tt)/T1))) * xe_0) / (xe_0 *KiKs)

Kp=0.015; 
figure
s = tf('s');
Gs =  Kp* KiKs *exp(-s*Tt) /((1+s*T1) *(s));
bodeplot(Gs);
xlim([0.01 2])

figure
margin(Gs);

%Notes: 
%indentifkation ist ok so.
% kp = 0.03 => amplitudendurchtritt auf 0.02rad/s setzen und damit
% bandbreite begrenzen. Geht auch mit kp=0.01 => langsamer
% 0.01 => 100s steigzeit?





