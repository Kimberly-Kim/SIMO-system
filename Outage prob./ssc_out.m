Eb = 1;% signal to transmit Eb = 1
fprintf("run ssc_out\n");
x=(2*floor(2*rand(1,num)))-1;
h=1:L;
as=1:L;
P=1:L;
n=1:L;
y=1:num;
for SNRdB = 0:1:20 %dB
    SNR = 10^(SNRdB/10); 
    pout_ssc=0;
    nvar = 1/(SNR); %calculation of N0, remember Eb = 1
    errorsc = 0; %set error counter to 0
        for trial = 1:num % monte carlo trials.. count the errors
            for l=1:L
                n(l)= sqrt(nvar/2)*randn; %noise for the first
                h(l) = sqrt(0.5)*abs(randn + 1j*randn); %rayleigh amplitude 1
                P(l) = chi2rnd(4);
                as(l) = (abs(h(l))).^2;
            end
            %%
            if max(as) < threshold
               [C,new]=max(as);
               peff_ssc= as(new)*SNR ;
               Index=new;                  
            else
               peff_ssc= as(Index)*SNR ;                  
            end
            %%
            if peff_ssc < threshold 
               pout_ssc=pout_ssc+1;
            end
        end
        out_ssc(SNRdB+1)=pout_ssc/num;
        out_ssc_th(SNRdB+1)=(1-(exp(-threshold./SNR))).^(L);
end
% plot simulations
%{
figure;
SNRdB=0:1:20; %changed from 10
semilogy(SNRdB,out_ssc,'p--',SNRdB,out_ssc_th,'k'); % plot EG BER vs EbNo 
xlabel('EbNo(dB)') %Label for x-axis
ylabel('Bit error rate') %Label for y-axis
%}