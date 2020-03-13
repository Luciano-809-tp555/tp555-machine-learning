clear all;close all;clc;

M = 1000;

fo = 1;
t = 0:1/50:1/2;

y = cos(2*pi*fo*t + 0.2);

y_noisy = y + 0.5*randn(1, length(t));

figure1 = figure('rend','painters','pos',[10 10 800 700]);
fontSize = 14;
plot(t, y, 'LineWidth', 1.5)
hold on
plot(t, y_noisy, 'o', 'LineWidth', 2)
xlabel('x', 'FontSize', fontSize)
ylabel('y', 'FontSize', fontSize)
lgd = legend('Dado original','Dado ruidoso');
lgd.FontSize = 12;
grid on
hold off


m = 100;
X = 6 * rand(1, m) - 3;
y = 0.5 * X.^2 + X + 2;
y_noisy = y + randn(1, m);


figure1 = figure('rend','painters','pos',[10 10 800 700]);
fontSize = 14;
plot(X, y, 'x', 'LineWidth', 2)
hold on
plot(X, y_noisy, 'o', 'LineWidth', 2)
xlabel('x', 'FontSize', fontSize)
ylabel('y', 'FontSize', fontSize)
lgd = legend('Dado original','Dado ruidoso');
lgd.FontSize = 12;
grid on
hold off



