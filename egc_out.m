fprintf("run egc_out\n");
egc_num=0;
h=1:L;
a=1:L;
n=1:L;
y=1:L;
x=(2*floor(2*rand(1,num)))-1;
for SNRdB = 0:1:20 %dB
    SNR = 10^(SNRdB/10); 
    pout_egc=0;
    nvar = 1/(SNR); %calculation of N0, Eb = 1
    erroregc = 0; %set error counter to 0
        for trial = 1:num % monte carlo trials.. count the errors
            for l=1:L
                n(l) = sqrt(nvar/2)*randn; %noise for the first
                h(l) = sqrt(0.5)*abs(randn + 1j*randn); %rayleigh amplitude 1
                %% Equal Gain combining
                y(l)= h(l)+n(l); % Signal 1 
            end
            peff_egc = (SNR/L)*((sum(abs(h)))^2);
            if peff_egc<threshold
                pout_egc=pout_egc+1;
                
            end
            egc_num=egc_num+1;
        end
        out_egc(SNRdB+1)=pout_egc/num;
end
% plot simulations
%{
figure;
SNRdB=0:1:20; %changed from 10
semilogy(SNRdB,out_egc,'r--o'); % plot EG BER vs EbNo 
xlabel('EbNo(dB)') %Label for x-axis
ylabel('Bit error rate') %Label for y-axis
%}