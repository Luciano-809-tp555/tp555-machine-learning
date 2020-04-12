clear all;close all;clc

M = 2;

N = 100;
x = randi(M, N, 1) - 1;
y = qammod(x, M);

y_noisy_bpsk = y + (0.5)*(1/sqrt(2))*complex(randn(N, 1),randn(N,1));

figure1 = figure('rend','painters','pos',[10 10 800 700]);
C = categorical(x,[0 1],{'0','1'});
h = histogram(C,'BarWidth',0.5, 'Normalization','pdf');
title('Função massa de probabilidade dos bits')
xlabel('Bits', 'FontSize', 14)
ylabel('Probabilidade', 'FontSize', 14)
%h=histogram(x, 'Normalization','pdf');


figure2 = figure('rend','painters','pos',[10 10 800 700]);
plot(real(y_noisy_bpsk),imag(y_noisy_bpsk), 'x', 'LineWidth', 1)
hold on
plot(real(qammod((0:M-1)', M)),imag(qammod((0:M-1)', M)), 'ro', 'LineWidth', 2);
title('Saída do canal AWGN')
xlabel('InPhase', 'FontSize', 14)
ylabel('Quadrature', 'FontSize', 14)
hold off
grid on
ld=legend('Símbolo transmitido', 'Símbolo recebido');
ld.FontSize=12;
xlim([-2 2])
ylim([-1 1])