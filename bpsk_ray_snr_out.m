close all;
clear all;
clc;
%% BPSK over Rayleigh fading wireless channel 
SNRdB=1:1:35;
SNR=10.^(SNRdB/10);
num=10^6;
threshold=10.^(10/10);
x=(2*floor(2*rand(1,num)))-1; %change 0~1 to -1~1
outage=zeros(1,length(SNRdB));
%% tx rx
for k=1:length(SNR)
    w = randn(1,num) + 1i*randn(1,num);% w~CN(0,1)
    y=raylrnd(1/sqrt(2),1,num).*((sqrt(SNR(k))*x))+w; %y=hx+w
    outage(k)=1-(exp(-threshold./SNR(k)));
end
%% --theory--
theoryOut = 1-(exp(-threshold./SNR));
%% -----plot
semilogy(SNRdB,outage,'ro-','linewidth',3.0);
hold on
semilogy(SNRdB,theoryOut,'b-','LineWidth',1.5);
title('BPSK over Rayleigh channel Simulation(SNR v.s. BER)');
xlabel('SNR in dB');
ylabel('Outage probability');
legend('Simulation','Theory');
axis tight
grid