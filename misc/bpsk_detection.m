clear all;close all;clc

M = 2;

N = 100000;
x = randi(M, N, 1) - 1;
y = qammod(x, M);

SNR = -10:2:12;
SNR_LINEAR = 10.^(-SNR./10);

for snrIdx=1:1:length(SNR)
    
noise_var = SNR_LINEAR(snrIdx);

y_noisy_bpsk = y + sqrt(noise_var)*(1/sqrt(2))*complex(randn(N, 1),randn(N,1));

decoded_y = sign(real(y_noisy_bpsk));

error(snrIdx) = (sum(abs((decoded_y-y)./2)))./N;

error_theo(snrIdx) = 0.5*erfc(sqrt(10.^(SNR(snrIdx)./10)));

end

figure1 = figure('rend','painters','pos',[10 10 800 700]);
semilogy(SNR, error, 'LineWidth', 2);
hold on
semilogy(SNR, error_theo, 'LineWidth', 2);
grid on;
xlabel('SNR [dB]', 'FontSize', 20);
ylabel('BER', 'FontSize', 20);
set(gca,'FontSize',20);
ylim([0.95e-5, 0.5])