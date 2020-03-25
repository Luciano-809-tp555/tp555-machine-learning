clear all;close all;clc;

M = 100;

x = sort(randn(M,1) -3 + randn(M,1) + randn(M,1) +3);
y = x + x.^2 + x.^3;

y_noisy = y + 0.5*randn(M, 1);

figure1 = figure('rend','painters','pos',[10 10 800 700]);
fontSize = 14;
plot(x, y, 'LineWidth', 1.5)
hold on
plot(x, y_noisy, 'o', 'LineWidth', 2)
xlabel('x', 'FontSize', fontSize)
ylabel('y', 'FontSize', fontSize)
lgd = legend('Dado original','Dado ruidoso');
lgd.FontSize = 12;
xlim([-2 2])
grid on
hold off

