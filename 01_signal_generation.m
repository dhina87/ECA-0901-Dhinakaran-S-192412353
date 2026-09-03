%% ECA0901 DSP Assignment - Synthetic ECG Generation
clc; clear; close all;
Fs = 360; T = 10; t = 0:1/Fs:T-1/Fs;
rng(42);
beatTimes = 0.8:1.0:9.8;
clean = zeros(size(t));
for bt = beatTimes
    clean = clean + 0.12*exp(-0.5*((t-(bt-0.20))/0.045).^2);
    clean = clean - 0.15*exp(-0.5*((t-(bt-0.035))/0.010).^2);
    clean = clean + 1.00*exp(-0.5*((t-bt)/0.012).^2);
    clean = clean - 0.22*exp(-0.5*((t-(bt+0.035))/0.012).^2);
    clean = clean + 0.30*exp(-0.5*((t-(bt+0.26))/0.090).^2);
end
baseline = 0.18*sin(2*pi*0.33*t);
mains = 0.08*sin(2*pi*50*t);
emg = 0.05*randn(size(t));
noisy = clean + baseline + mains + emg;
writematrix([t(:),clean(:),noisy(:)], '../data/ecg_basic.csv');
figure; plot(t,clean); hold on; plot(t,noisy); xlim([0 5]); grid on;
legend('Clean','Noisy'); xlabel('Time (s)'); ylabel('Amplitude');
title('Synthetic ECG Signal');
