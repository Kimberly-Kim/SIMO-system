Eb = 1; % signal to transmit Eb = 1
extra=0;
threshold=10;
h=1:L;
a=1:L;
n=1:L;
x=(2*floor(2*rand(1,num)))-1;
fprintf("run mrc_out\n");
for SNRdB = 0:1:20 %dB
    SNR = 10^(SNRdB/10); 
    pout_mrc=0;
    nvar = 1/(SNR); %calculation of N0, remember Eb = 1
        for trial = 1:num % monte carlo trials.. count the errors
            for l=1:L
                n(l) = sqrt(nvar/2)*randn; %noise for the first
                h(l) = sqrt(0.5)*abs(randn + 1j*randn); %rayleigh amplitude 1
                a(l)= (abs(h(l))).^2;   
            end
%% Maximal Ratio combining
            peff_mrc=sum(a.*SNR);
            if peff_mrc < threshold
               pout_mrc=pout_mrc+1;
            end
        end
       out_mrc(SNRdB+1)=pout_mrc/num;
       syms k
       extra = symsum((1/factorial(k)).*((threshold./SNR))^(k),k,0,L-1);
       out_mrc_th(SNRdB+1)=1-(exp(-threshold./SNR)).*extra;
end

% plot simulations
%{
figure;
SNRdB=0:1:20; %changed from 10
semilogy(SNRdB,out_mrc_th,'b--',SNRdB,out_mrc,'b--o'); % plot EG BER vs EbNo 
xlabel('EbNo(dB)') %Label for x-axis
axis tight
ylabel('Bit error rate') %Label for y-axis
%}