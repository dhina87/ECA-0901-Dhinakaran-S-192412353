%% Analytical real-time budget for Cortex-M7-class target
clc; clear;
Fs=360; taps=81; M=2; CPU=216e6;
fullRateMACs=taps*Fs;
polyMACs=taps*(Fs/M);
cyclesPerSampleLowerBound=taps; % 1 MAC = 1 idealized DSP instruction-equivalent
util_full=fullRateMACs/CPU*100;
util_poly=polyMACs/CPU*100;
fprintf('Full-rate FIR MAC/s = %.0f\n',fullRateMACs);
fprintf('Polyphase decimator MAC/s = %.0f\n',polyMACs);
fprintf('Idealized lower-bound cycles/sample = %d\n',cyclesPerSampleLowerBound);
fprintf('Idealized arithmetic utilization at 216 MHz: %.4f %%\n',util_full);
fprintf('Polyphase arithmetic utilization at 216 MHz: %.4f %%\n',util_poly);
