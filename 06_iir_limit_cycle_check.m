%% Quantized IIR zero-input limit-cycle check
clc; clear; close all;
Fs=360;
[b,a]=butter(2,45/(Fs/2));
BQ=int16(max(-32768,min(32767,round(b*32768))))/32768;
AQ=int16(max(-32768,min(32767,round(a*32768))))/32768;
y=zeros(250,1); y(1)=0.01; y(2)=-0.008;
for n=3:250
    y(n)=round((-AQ(2)*y(n-1)-AQ(3)*y(n-2))*32768)/32768;
end
plot(y,'LineWidth',1); grid on; xlabel('Sample'); ylabel('Amplitude');
title('Zero-input response after coefficient quantization');
tailPeak=max(abs(y(end-49:end)));
fprintf('Tail peak = %.6g\n',tailPeak);
