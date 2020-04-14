clear all;close all;clc

M = 2;

N = 100;
x = randi(M, N, 1) - 1;
y = qammod(x, M);

y_noisy_bpsk = y + (0.5)*(1/sqrt(2))*complex(randn(N, 1),randn(N,1));

figure1 = figure('rend','painters','pos',[10 10 800 700]);
C = categorical(x,[0 1],{'0','1'});
h = histogram(C,'BarWidth',0.5, 'Normalization','pdf');
title('Função massa de probabilidade dos bits', 'FontSize', 20)
xlabel('Bits', 'FontSize', 20)
ylabel('Probabilidade', 'FontSize', 20)
set(gca,'FontSize',20);


figure2 = figure('rend','painters','pos',[10 10 800 700]);
plot(real(y_noisy_bpsk),imag(y_noisy_bpsk), 'x', 'LineWidth', 1)
hold on
plot(real(qammod((0:M-1)', M)),imag(qammod((0:M-1)', M)), 'ro', 'LineWidth', 2);
title('Saída do canal AWGN', 'FontSize', 20)
xlabel('InPhase', 'FontSize', 20)
ylabel('Quadrature', 'FontSize', 20)
hold off
grid on
ld=legend('Símbolo transmitido', 'Símbolo recebido');
ld.FontSize=20;
xlim([-2 2])
ylim([-1 1])
set(gca,'FontSize',20)
