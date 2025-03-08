% Parameters
fs = 10000;       % Switching frequency (Hz)
fref = 50;        % Reference frequency (Hz)
T = 1/fs;         % Sampling period
t = 0:T:1;        % Time vector

% Generate three-phase sine wave reference signals
A = 1;            % Amplitude of the sine wave
theta = 2*pi*fref*t;
Vref_a = A * sin(theta);
Vref_b = A * sin(theta - 2*pi/3);
Vref_c = A * sin(theta + 2*pi/3);

% Clarke transformation to alpha-beta plane
V_alpha = Vref_a;
V_beta = (Vref_b - Vref_c) / sqrt(3);

% SVM calculations
% SVM sectors and calculations are more complex, simplified example follows

% Sector determination (example for sector 1)
T1 = V_alpha; % Time for vector 1
T2 = V_beta;  % Time for vector 2
T0 = T - (T1 + T2); % Zero vector time

% Generate SVM signals (example switching logic for sector 1)
SVM_a = (t < T1) + (t >= (T1 + T2) & t < (2*T1 + T2));
SVM_b = (t >= T1 & t < (T1 + T2));
SVM_c = (t >= (T1 + T2) & t < (2*T1 + T2));

% Plot the results
figure;
subplot(3,1,1);
plot(t, V_alpha, t, V_beta);
title('Alpha-Beta reference signals');
legend('V_{\alpha}', 'V_{\beta}');

subplot(3,1,2);
plot(t, SVM_a, t, SVM_b, t, SVM_c);
title('SVM Signals');
legend('SVM_a', 'SVM_b', 'SVM_c');

subplot(3,1,3);
plot(t, SVM_a - 0.5, t, SVM_b - 1, t, SVM_c - 1.5);
title('SVM Signals (shifted for clarity)');
legend('SVM_a', 'SVM_b', 'SVM_c');
