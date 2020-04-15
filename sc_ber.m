Eb = 1; % signal to transmit Eb = 1
x=(2*floor(2*rand(1,num)))-1;
h=1:L;
as=1:L;
P=1:L;
n=1:L;
y=1:num;
fprintf("run sc_ber\n");
for SNRdB = 0:1:20 %dB
    SNR = 10^(SNRdB/10); 
    nvar = 1/(SNR); %calculation of N0, remember Eb = 1
    errorsc = 0; %set error counter to 0
        for trial = 1:num % monte carlo trials.. count the errors
            for l=1:L
                n(l)= sqrt(nvar/2)*randn; %noise for the first
                h(l) = sqrt(0.5)*abs(randn + 1j*randn); %rayleigh amplitude 1
                %% Selection combining
                P(l) = chi2rnd(4);
                as (l)= P(l).*(abs(h(l))).^2;
             end
                [C,Index]=max(as);
                y_selection= Eb*(as(Index)*h(Index))+as(Index)*n(Index);
                if y_selection < 0 
                    errorsc = errorsc + 1;
                end
        end
    BERsc(SNRdB+1) = errorsc/(num);
end
% plot simulations

figure;
SNRdB=0:1:20; %changed from 10
SNR = 10.^(SNRdB./10);
theory_sc= (factorial(L)/2)*(1+SNR).^(-L);
semilogy(SNRdB,BERsc,'c-o',SNRdB,theory_sc,'c'); % plot EG BER vs EbNo 
xlabel('EbNo(dB)') %Label for x-axis
ylabel('Bit error rate') %Label for y-axis
