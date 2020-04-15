clear all;
figure;
L=6;
threshold=10^(10/10);
num = 10^6; %number of simulation runs per EbN0 %50000
egc_ber;
sc_ber;
mrc_ber;
ssc_ber
SNRdB=0:1:20; %changed from 10
SNR = 10.^(SNRdB./10);
%%
theory_sc= (factorial(L)/2)*(1+SNR).^(-L);
theory_mrc=0.5.*((1+SNR).^(-L));
semilogy(SNRdB,BERegc,'r*-',SNRdB,BERmrc,'b--o',SNRdB,BERsc,'c-o',SNRdB,BER_ssc,'p--',SNRdB,theory_mrc,'b',SNRdB,theory_sc,'c'); % plot EG BER vs EbNo 
legend('EG','MR','SC','SSC','theory_mrc','theory_sc');
xlabel('SNR(dB)') %Label for x-axis
ylabel('Bit error rate') %Label for y-axis
title('SIMO system with L=6 receive antennas');
%axis tight;