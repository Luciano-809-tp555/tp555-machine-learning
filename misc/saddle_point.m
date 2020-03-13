clear all;close all;clc;

fontSize = 12;

x = -10:1/1:10;
y = -10:1/1:10;

[X,Y] = meshgrid(x,y);

for iter0=1:1:length(x)
    
    for iter1=1:1:length(y)
        
        Z(iter0,iter1) = X(iter0,iter1).^2 - Y(iter0,iter1).^2;
        
    end
    
end



figure1 = figure('rend','painters','pos',[10 10 800 700]);
surf(X, Y, Z)
xlabel('a_0', 'FontSize', fontSize)
ylabel('a_1', 'FontSize', fontSize)
zlabel('J_e', 'FontSize', fontSize)
title('Superfície de Erro', 'FontSize', fontSize)