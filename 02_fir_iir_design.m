%% FIR/IIR design and frequency response comparison
clc; clear; close all;
Fs = 360;
% Primary FIR designs
N = 80;
hHam = fir1(N,[0.5 45]/(Fs/2),hamming(N+1));
hKai = fir1(N,[0.5 45]/(Fs/2),kaiser(N+1,8.6));
% IIR benchmark
[bIIR,aIIR] = butter(4,[0.5 45]/(Fs/2),'bandpass');
[HH,F] = freqz(hHam,1,4096,Fs);
[HK,~] = freqz(hKai,1,4096,Fs);
[HI,~] = freqz(bIIR,aIIR,4096,Fs);
figure; plot(F,20*log10(abs(HH)+eps)); hold on;
plot(F,20*log10(abs(HK)+eps)); plot(F,20*log10(abs(HI)+eps));
xlim([0 100]); ylim([-100 5]); grid on;
legend('FIR Hamming','FIR Kaiser','IIR Butterworth');
xlabel('Frequency (Hz)'); ylabel('Magnitude (dB)');
title('Noise-Suppression Filter Comparison');
