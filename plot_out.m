clear all;
L=6;
num=10^6;
threshold=10^(10/10);
egc_out;
sc_out;
mrc_out;
ssc_out;
SNRdB=0:1:20; %changed from 10
SNR = 10.^(SNRdB./10);
%%
figure;
semilogy(SNRdB,out_egc,'r--o',SNRdB,out_mrc,'b--o',SNRdB,out_sc,'c--o',SNRdB,out_ssc,'p--',SNRdB,out_mrc_th,'b',SNRdB,out_sc_th,'c'); % plot EG BER vs EbNo 
legend('sim_egc','sim_mrc','sim_sc','sim_ssc','theory_mrc','theory_sc');
xlabel('SNR(dB)') %Label for x-axis
ylabel('outage') %Label for y-axis'sim_sc'
title('SIMO system with L=6 receive antennas');
axis tight;