h=1:L;
a=1:L;
n=1:L;
y=1:L;
x=(2*floor(2*rand(1,num)))-1;
fprintf("run egc_ber\n");
for SNRdB = 1:1:20 %dB
    SNR = 10^(SNRdB/10); 
    nvar = 1/(SNR); %calculation of N0, Eb = 1
    erroregc = 0; %set error counter to 0
        for trial = 1:num % monte carlo trials.. count the errors
            for l=1:L
                n(l) = sqrt(nvar/2)*randn; %noise for the first
                h(l) = sqrt(0.5)*abs(randn + 1j*randn); %rayleigh amplitude 1
                %% Equal Gain combining
                y(l)= h(l)+n(l); % Signal 1
                y_equal = sum(y)/L; 
                if y_equal < 0 
                    erroregc = erroregc + 1;
                end
            end
    BERegc(SNRdB+1) = erroregc/(num);
        end
end