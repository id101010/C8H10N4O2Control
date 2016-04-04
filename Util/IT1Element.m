% Definitions
Ks = 1;
Ki = 1;
T1 = [1 10 100 1000];
Xe0 = 0.5;

%Xa = zeros(length(sumSensor.data));
Xa = zeros(1000,1);

% Plot Xa
subplot(1,2,1)

for j = 1:length(T1)
    % Plot IT1 element
    for i = 1:length(Xa)
        Xa(i) =  Ks * Ki * (i - T1(j) * (1 - exp(-i/T1(j)))) * Xe0;
    end
    
    hold on
    plot(Xa)
    
end

% Plot pwm data and sumSensor
subplot(1,2,2)
plot(pwm.data, 'g')
hold on
plot(sumSensor.data, 'b')
hold on