clear all;close all;clc;

fontSize = 14;

a_int = [-20;-20];

M = 100000;

x1 = randn(M, 1); 

x2 = randn(M, 1);

y = x1 + x2 + randn(M, 1);

a1 = -20:1/1:24;

a2 = -20:1/1:24;

[A1,A2] = meshgrid(a1,a2);

J = zeros(length(A1),length(A2));
for iter1=1:1:length(a1)
    
    for iter2=1:1:length(a2)
        
        yhat = A1(iter1, iter2)*x1 + A2(iter1, iter2)*x2;
        
        J(iter1, iter2) = (1/length(y)).*sum((y - yhat).^2);
        
    end
    
end

%% Closed-form solution.

X = [x1 x2];

a_opt = pinv(X.'*X)*X.'*y;

yhat = a_opt(1)*x1 + a_opt(2)*x2;

Joptimum = (1/M)*sum((y - yhat).^2);

%% Plot Figures.
figure1 = figure('rend','painters','pos',[10 10 800 700]);
surf(A1, A2, J)
xlabel('a_1', 'FontSize', fontSize)
ylabel('a_2', 'FontSize', fontSize)
zlabel('J_e', 'FontSize', fontSize)
title('Superfície de Erro', 'FontSize', fontSize)

figure2 = figure('rend','painters','pos',[10 10 800 700]);
contour(A1, A2, J, 'ShowText','on')
xlabel('a_1', 'FontSize', fontSize)
ylabel('a_2', 'FontSize', fontSize)
zlabel('J_e', 'FontSize', fontSize)
title('Contorno da Superfície de Erro', 'FontSize', fontSize)
hold on
%scatter3(a_opt(1), a_opt(2), Joptimum, 'r*', 'MarkerSize', 10)
%scatter3(a(1,:), a(2,:), Jgd, 'kx', 'MarkerSize', 10);
plot(a_opt(1), a_opt(2), 'r*', 'MarkerSize', 10, 'LineWidth',1);
x = [0.5 0.5];
y = [0.38 0.48];
annotation('textarrow',x,y,'String','solução ótima', 'FontSize', fontSize)
%plot(a(1,:), a(2,:), 'kx', 'MarkerSize', 10, 'LineWidth',1);
hold off;

