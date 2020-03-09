clear all;close all;clc

L = 1;
K = 1;

cellRadius = 100;
cellHole = 10;

sshadow = 8; % dB

fading_exponent = 3.8; % 2 - Free Space; 3.8 - Suburban Area

numIter = 1000;
for i=1:1:numIter

    [beta(i), distance(i)] = GenerateRandomBetav4(L,K,cellRadius,cellHole,sshadow,fading_exponent);

end

fontSize = 14;
fdee_figure = figure('rend','painters','pos',[10 10 800 700]);
plot(distance, 20.*log10(beta), 'o', 'LineWidth', 1)
grid on
xlabel('Distância [m]', 'FontSize', fontSize)
ylabel('Atenuação [dB]', 'FontSize', fontSize)
title('Perda por Caminho', 'FontSize', fontSize)
