%% Decimation/interpolation and polyphase implementation
clc; clear; close all;
load('../data/ecg_basic.csv');
Fs = 360; M = 2; N = 80;
h = fir1(N,40/(Fs/2),hamming(N+1));
% Direct-form reference
xAA = filter(h,1,ecg_basic(:,3));
yDirect = xAA(1:M:end);
% Polyphase implementation through efficient upfirdn
% upfirdn performs the filter/rate-conversion operation using a polyphase structure.
yPoly = upfirdn(ecg_basic(:,3),h,1,M);
% Interpolation by M
xDec = yDirect;
yInterp = upfirdn(xDec,h,M,1);
figure; subplot(2,1,1); plot(ecg_basic(:,1),ecg_basic(:,3)); xlim([0 3]);
title('Original noisy ECG'); xlabel('Time (s)'); grid on;
subplot(2,1,2); td=(0:length(yDirect)-1)/(Fs/M); plot(td,yDirect);
xlim([0 3]); title('Decimated ECG (M=2)'); xlabel('Time (s)'); grid on;
NmacDirect = N+1; NmacPoly = (N+1)/M;
fprintf('FIR taps = %d\n',N+1);
fprintf('Approx. direct MAC/s = %.0f\n',(N+1)*Fs);
fprintf('Approx. polyphase MAC/s = %.0f\n',NmacPoly*Fs);
fprintf('Theoretical arithmetic reduction = %.1f %%\n',100*(1-1/M));
