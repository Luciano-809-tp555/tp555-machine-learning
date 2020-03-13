clear all;close all;clc

fontSize = 14;

M = 100000;

x1 = 10*randn(M, 1);

y = 2.0*x1 + 10*randn(M, 1);

%% Generate the Error Function.
a1 = -6:1/10:6;

[A1] = meshgrid(a1);

J = zeros(1, length(A1));
for iter1=1:1:length(a1)
    
    yhat = A1(iter1)*x1;
    
    J(1, iter1) = (1/M).*sum((y - yhat).^2);
    
end

%% Closed-form solution.

X = [ones(M, 1) x1];

a_opt = pinv(X.'*X)*X.'*y;

yhat = a_opt(1) + a_opt(2)*x1;

Joptimum = (1/M)*sum((y - yhat).^2);

%% Gradient-descent solution.
alpha = 0.005;

% Initialize 'a' at a random location within the parameter's space.
a(:,1) = -20;

yhat = a(1,1) + a(2,1)*x1;

Jgd(1) = (1/M)*sum((y - yhat).^2);

error = 1;
iter = 1;
while(error > 0.0001 && iter <= 10000)
    
    fprintf(1, 'Iter: %d - Je_otimo: %1.2e - Je: %1.2e\n', iter, Joptimum, Jgd(iter));
    
    h = a(1,iter) + a(2,iter)*x1;
    
    update = -(2./M).*(y - h).'*X;
    
    a(:,iter+1) = a(:,iter) - alpha.*update.';
    
    yhat = a(1,iter+1) + a(2,iter+1)*x1;
    
    Jgd(iter+1) = (1/M).*sum((y - yhat).^2);
    
    error = abs(Jgd(iter)-Jgd(iter+1));
    
    iter = iter + 1;
    
end

iterList = [1 2 100 300 iter];
for iterT=1:1:length(iterList)
    figure1 = figure('rend','painters','pos',[10 10 800 700]);
    plot(x1, y, '.')
    hold on
    yhat = a(1,iterList(iterT)) + a(2,iterList(iterT))*x1;
    plot(x1, yhat)
    grid on
end

figure2 = figure('rend','painters','pos',[10 10 800 700]);
contour(A0, A1, J, 'ShowText','on')
xlabel('a_0', 'FontSize', fontSize)
ylabel('a_1', 'FontSize', fontSize)
zlabel('J_e', 'FontSize', fontSize)
title('Contorno da Superfície de Erro', 'FontSize', fontSize)
hold on
scatter3(a_opt(1), a_opt(2), Joptimum, 'r*')
scatter3(a(1,:), a(2,:), Jgd, 'kx');
%plot(a_opt(1), a_opt(2), 'r*', 'MarkerSize', 10, 'LineWidth',1);
%plot(a(1,:), a(2,:), 'kx', 'MarkerSize', 10, 'LineWidth',1);
hold off;

figure3 = figure('rend','painters','pos',[10 10 800 700]);
semilogy(0:1:iter-1, Jgd, 'LineWidth',1)
xlabel('Iteração', 'FontSize', fontSize)
ylabel('J_e', 'FontSize', fontSize)
title('Iterações vs. Erro', 'FontSize', fontSize)
lgd = legend('\alpha = 0.001', 'Interpreter', 'latex');
lgd.FontSize = 14;
xlim([0 iter-1])
grid on