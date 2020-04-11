clear all;close all;clc

M = 2;

x = randi(M, 100, 1) - 1;
y = qammod(x, M);

y_noisy_bpsk = y + (0.5)*(1/sqrt(2))*complex(randn(100, 1),randn(100,1));

figure = figure('rend','painters','pos',[10 10 800 700]);
plot(real(y_noisy_bpsk),imag(y_noisy_bpsk), 'x', 'LineWidth', 1)
hold on
plot(real(qammod((0:M-1)', M)),imag(qammod((0:M-1)', M)), 'ro', 'LineWidth', 2);
title('BPSK')
xlabel('InPhase', 'FontSize', 14)
ylabel('Quadrature', 'FontSize', 14)
hold off
grid on
ld=legend('Símbolo transmitido', 'Símbolo recebido');
ld.FontSize=12;
xlim([-2 2])
ylim([-1 1])