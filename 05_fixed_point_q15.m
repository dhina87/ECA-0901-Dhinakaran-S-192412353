%% Q15 fixed-point FIR: rounding vs truncation
clc; clear; close all;
load('../data/ecg_basic.csv');
Fs=360; N=80; h=fir1(N,[0.5 45]/(Fs/2),hamming(N+1));
x=ecg_basic(:,3); clean=ecg_basic(:,2);
scale = max(1,max(abs(x))/0.8);      % 20%% headroom
xq = int16(max(-32768,min(32767,round((x/scale)*32768))));
hq = int16(max(-32768,min(32767,round(h*32768))));

yR = zeros(size(xq),'int16'); yT = zeros(size(xq),'int16');
for n=1:length(xq)
    k0=max(1,n-length(hq)+1);
    xv=double(xq(k0:n)); hv=double(hq(1:length(xv)));
    acc=sum(fliplr(xv).*hv); % Q30 accumulator
    yr=floor((acc+16384)/32768);
    yt=floor(acc/32768);       % truncation toward -infinity in this simple reference
    yR(n)=int16(max(-32768,min(32767,yr)));
    yT(n)=int16(max(-32768,min(32767,yt)));
end
yRound=double(yR)/32768*scale;
yTrunc=double(yT)/32768*scale;
gd=N/2; yRound=circshift(yRound,-gd); yTrunc=circshift(yTrunc,-gd);
figure; plot(ecg_basic(:,1),clean); hold on; plot(ecg_basic(:,1),yRound);
xlim([0 3]); grid on; legend('Clean','Q15 Rounded'); title('Q15 FIR Output');
errR=yRound-clean; errT=yTrunc-clean;
idx=ecg_basic(:,1)>1;
SNR_R=10*log10(mean(clean(idx).^2)/mean(errR(idx).^2));
SNR_T=10*log10(mean(clean(idx).^2)/mean(errT(idx).^2));
fprintf('Headroom = %.2f dB\n',-20*log10(0.8));
fprintf('Q15 Rounded SNR = %.2f dB\n',SNR_R);
fprintf('Q15 Truncated SNR = %.2f dB\n',SNR_T);
