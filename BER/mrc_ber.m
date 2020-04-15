Eb = 1; % signal to transmit Eb = 1
%number of simulation runs per EbN0 %50000
h=1:L;
a=1:L;
n=1:L;
x=(2*floor(2*rand(1,num)))-1;
fprintf("run mrc_ber\n");
for SNRdB = 0:1:20 %dB
    SNR = 10^(SNRdB/10); 
    nvar = 1/(SNR); %calculation of N0, remember Eb = 1
    errormrc = 0; %set error counter to 0
        for trial = 1:num % monte carlo trials.. count the errors
            for l=1:L
                n(l) = sqrt(nvar/2)*randn; %noise for the first
                h(l) = sqrt(0.5)*abs(randn + 1j*randn); %rayleigh amplitude 1
                %% Maximal Ratio combining
                a(l)= (abs(h(l))).^2;
                y_maximal = sum(a.*h)+sum(a.*n);
                if y_maximal < 0 
                    errormrc = errormrc + 1;
                end
            end
        end
    BERmrc(SNRdB+1) = errormrc/(num);
    %{
    syms u
    w=((factorial(2*u))./((4^u)*(factorial(u))*(factorial(u))));
    extra=symsum(((nvar./(1+nvar)).^u).*w,u,0,L-1);
    theory_mrc(SNRdB+1) = 0.5-0.5.*(1./(1+nvar)).*extra;
    %}
end
% plot simulations
%{
figure
SNRdB=0:1:20; %changed from 10
SNR = 10.^(SNRdB/10);
semilogy(SNRdB,BERmrc,'b--o'); % plot EG BER vs EbNo 
xlabel('EbNo(dB)') %Label for x-axis
axis tight
ylabel('Bit error rate') %Label for y-axis
%}