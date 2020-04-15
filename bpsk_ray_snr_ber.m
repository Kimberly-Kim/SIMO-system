close all;
clear all;
clc;
%% BPSK over Rayleigh fading wireless channel 
SNRdB=1:1:35;
SNR=10.^(SNRdB/10);
num=10^6;
x=(2*floor(2*rand(1,num)))-1; %change 0~1 to -1~1
ber=zeros(1,length(SNRdB));
%% tx rx
for k=1:length(SNR)
    w = randn(1,num) + 1i*randn(1,num);% w~CN(0,1)
    y=raylrnd(1/sqrt(2),1,num).*((sqrt(SNR(k))*x))+w; %y=hx+w
    ber(k)=length(find((y.*x)<0));
end
ber=ber/num;
%% --theory--
theoryBer = 0.5.*(1-sqrt(SNR./(SNR+2)));
%% -----plot
semilogy(SNRdB,ber,'ro-','linewidth',3.0);
hold on
semilogy(SNRdB,theoryBer,'b-','LineWidth',1.5);
title('BPSK over Rayleigh channel Simulation(SNR v.s. BER)');
xlabel('SNR in dB');
ylabel('BER');
legend('Rayleigh-Simulation','Rayleigh-Theory');
axis tight
grid