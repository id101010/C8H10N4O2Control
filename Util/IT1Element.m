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

KiKs = (Xa_tm1/(xe_0*(tm_1-T1)));

for i = 1:length(t)
     Xa(i) = KiKs * (i - T1 * (1 - exp(-i/T1))) * xe_0;
end

plot(pwm.time,pwm.data, 'g')
hold on
plot(sumBuf.time,sumBuf.data-28, 'b')
hold on
plot(t+30,Xa, 'r')


figure
s = tf('s');
Gs = KiKs /((1+s*T1) *(s)); %*exp(-s*20);
wd = 1  / (4*T1)
bodeplot(Gs);

%Wir haben keine reine PI Strecke sondern noch eine Strecke mit Totzeit.
%TODO: Totzeit hinzuf�gen und Model & Bode neu berechen
% P oder PI-Regler sollten aber reichen.





