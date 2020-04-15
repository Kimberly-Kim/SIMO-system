Eb = 1;% signal to transmit Eb = 1
fprintf("run sc_out\n");
x=(2*floor(2*rand(1,num)))-1;
h=1:L;
as=1:L;
P=1:L;
n=1:L;
y=1:num;
for SNRdB = 0:1:20 %dB
    SNR = 10^(SNRdB/10); 
    pout_sc=0;
    nvar = 1/(SNR); %calculation of N0, remember Eb = 1
    errorsc = 0; %set error counter to 0
        for trial = 1:num % monte carlo trials.. count the errors
            for l=1:L
                n(l)= sqrt(nvar/2)*randn; %noise for the first
                h(l) = sqrt(0.5)*abs(randn + 1j*randn); %rayleigh amplitude 1
                %Selection combining
                P(l) = chi2rnd(4);
                as(l) = (abs(h(l))).^2;
            end
            peff_sc= max(as)*SNR ;
            if peff_sc < threshold 
               pout_sc=pout_sc+1;
            end
        end
        out_sc(SNRdB+1)=pout_sc/num;
        out_sc_th(SNRdB+1)=(1-(exp(-threshold./SNR))).^(L);
end
% plot simulations
%{
figure;
SNRdB=0:1:20; %changed from 10
semilogy(SNRdB,out_sc,'c--o',SNRdB,out_sc_th,'c'); % plot EG BER vs EbNo 
xlabel('EbNo(dB)') %Label for x-axis
ylabel('Bit error rate') %Label for y-axis
%}