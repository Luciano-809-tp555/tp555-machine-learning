clear all;close all;clc

M = 2;

x = randi(M, 100, 1) - 1;
y = qammod(x, M);

y_noisy_bpsk = y + (0.5)*(1/sqrt(2))*complex(randn(100, 1),randn(100,1));

figure = figure('rend','painters','pos',[10 10 800 700]);
subplot(2,2,1)
plot(real(y_noisy_bpsk),imag(y_noisy_bpsk), 'x')
hold on
plot(real(qammod((0:M-1)', M)),imag(qammod((0:M-1)', M)), 'ro', 'LineWidth', 2);
title('BPSK')
xlabel('InPhase')
ylabel('Quadrature')
hold off
grid on
xlim([-2 2])
ylim([-1 1])


M = 4;

x = randi(M, 2*100, 1) - 1;
y = qammod(x, M);

y_noisy_qpsk = y + (0.5)*(1/sqrt(2))*complex(randn(2*100, 1),randn(2*100,1));
subplot(2,2,2)
plot(real(y_noisy_qpsk),imag(y_noisy_qpsk), 'x')
hold on
plot(real(qammod((0:M-1)', M)),imag(qammod((0:M-1)', M)), 'ro', 'LineWidth', 2);
title('QPSK')
xlabel('InPhase')
ylabel('Quadrature')
hold off
grid on
xlim([-2 2])
ylim([-2 2])



M = 16;

x = randi(M, 4*100, 1) - 1;
y = qammod(x, M);

y_noisy_qpsk = y + (0.5)*(1/sqrt(2))*complex(randn(4*100, 1),randn(4*100,1));
subplot(2,2,3)
plot(real(y_noisy_qpsk),imag(y_noisy_qpsk), 'x')
hold on
plot(real(qammod((0:M-1)', M)),imag(qammod((0:M-1)', M)), 'ro', 'LineWidth', 2);
title('16QAM')
xlabel('InPhase')
ylabel('Quadrature')
hold off
grid on
xlim([-4 4])
ylim([-4 4])

M = 64;

x = randi(M, 8*100, 1) - 1;
y = qammod(x, M);

y_noisy_qpsk = y + (0.5)*(1/sqrt(2))*complex(randn(8*100, 1),randn(8*100,1));
subplot(2,2,4)
plot(real(y_noisy_qpsk),imag(y_noisy_qpsk), 'x')
hold on
plot(real(qammod((0:M-1)', M)),imag(qammod((0:M-1)', M)), 'ro', 'LineWidth', 2);
title('64QAM')
xlabel('InPhase')
ylabel('Quadrature')
hold off
grid on
xlim([-10 10])
ylim([-10 10])