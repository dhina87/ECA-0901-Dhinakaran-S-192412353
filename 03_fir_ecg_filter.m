%% Apply causal FIR and align group delay for analysis
clc; clear; close all;
load('../data/ecg_basic.csv');
t = ecg_basic(:,1); clean = ecg_basic(:,2); noisy = ecg_basic(:,3);
Fs = 360; N = 80; gd = N/2;
h = fir1(N,[0.5 45]/(Fs/2),hamming(N+1));
y = filter(h,1,noisy);
yAligned = circshift(y,-gd); yAligned(end-gd+1:end)=0;
figure; plot(t,noisy); hold on; plot(t,yAligned); xlim([0 5]); grid on;
legend('Noisy','FIR Hamming'); xlabel('Time (s)'); ylabel('Amplitude');
title('ECG Denoising with Hamming FIR');
