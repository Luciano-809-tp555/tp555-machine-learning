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




%% ------------------------------------------------------------------------
%% Batch Gradient Descent
%% ------------------------------------------------------------------------

%% Gradient-descent solution.
alpha = 0.3;

% Initialize 'a' at a random location within the parameter's space.
a = zeros(3, 10000);
a(:,1) = a_int;

yhat = a(1,1) + a(2,1)*x + a(3,1)*x.^2;

Jgd = zeros(1, 10000);
Jgd(1) = (1/M)*sum((y - yhat).^2);

error = 1;
iter = 1;
while(error > 0.001 && iter <= 10000)
    
    h = a() + a(1,iter)*x + a(2,iter)*x.^2;
    
    update = -(2./M).*(y - h).'*[x1 x2];
    
    a(:,iter+1) = a(:,iter) - alpha.*update.';
    
    yhat = a(1,iter+1)*x1 + a(2,iter+1)*x2;
    
    Jgd(iter+1) = (1/M).*sum((y - yhat).^2);
    
    error = abs(Jgd(iter)-Jgd(iter+1));
    
    iter = iter + 1;
    
end

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
plot(a(1,:), a(2,:), 'kx', 'MarkerSize', 10, 'LineWidth',1);
hold off;


a_scaled = a;

