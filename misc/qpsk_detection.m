clear all;close all;clc;

% symbol error rate for QPSK(4-QAM) modulation

N = 10^6; % number of symbols
Es_N0_dB = [-3:20]; % multiple Es/N0 values
ipHat = zeros(1,N);

for ii = 1:length(Es_N0_dB)
    
    ip = complex( (2*(rand(1,N)>0.5)-1), (2*(rand(1,N)>0.5)-1) );
    
    s = (1/sqrt(2))*ip; % normalization of energy to 1
    
    % white guassian noise, 0dB variance
    n = 1/sqrt(2)*complex(randn(1,N), randn(1,N));
    
    y = s + sqrt(10^(-Es_N0_dB(ii)/10))*n; % additive white gaussian noise
    
    % demodulation
    y_re = real(y); % real
    y_im = imag(y); % imaginary
    ipHat(find(y_re < 0 & y_im < 0)) = -1 + -1*j;
    ipHat(find(y_re >= 0 & y_im > 0)) = 1 + 1*j;
    ipHat(find(y_re < 0 & y_im >= 0)) = -1 + 1*j;
    ipHat(find(y_re >= 0 & y_im < 0)) = 1 - 1*j;
    
    nErr(ii) = size(find([ip- ipHat]),2); % couting the number of errors
end

simSer_QPSK = nErr/N;
theorySer_QPSK = erfc( sqrt(  0.5*(10.^(Es_N0_dB/10))   ) ) - (1/4)*(erfc(sqrt(0.5*(10.^(Es_N0_dB/10))))).^2;

figure1 = figure('rend','painters','pos',[10 10 800 700]);
semilogy(Es_N0_dB, theorySer_QPSK, 'b.-');
hold on
semilogy(Es_N0_dB, simSer_QPSK, 'mx-');
axis([-3 15 10^-5 1])
grid on
legend('theory-QPSK', 'simulation-QPSK');
xlabel('Es/No, dB')
ylabel('Symbol Error Rate')
title('Symbol error probability curve for QPSK(4-QAM)')
