clear all;close all;clc

M = 100000;

x1 = 10*randn(M, 1);

x2 = 10*randn(M, 1);

y = 2.0*x1 + 2.0*x2 + 10*randn(M, 1);

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

figure;
surf(A1, A2, J)
xlabel('a1')
ylabel('a2')
zlabel('Je')
title('Superfície de Erro')

%% Closed-form solution.

X = [x1 x2];

a_opt = pinv(X.'*X)*X.'*y;

yhat = a_opt(1)*x1 + a_opt(2)*x2;

Joptimum = (1/M)*sum((y - yhat).^2);

%% Gradient-descent solution.
alpha = 0.003;

% Initialize 'a' at a random location within the parameter's space.
a(:,1) = [-20;-20];

yhat = a(1,1)*x1 + a(2,1)*x2;

Jgd(1) = (1/M)*sum((y - yhat).^2);

error = 1;
iter = 1;
while(error > 0.00001 && iter <= 10000)
    
    h = a(1,iter)*x1 + a(2,iter)*x2;
    
    update = -(2./M).*(y - h).'*[x1 x2];
    
    a(:,iter+1) = a(:,iter) - alpha.*update.';
    
    yhat = a(1,iter+1)*x1 + a(2,iter+1)*x2;

    Jgd(iter+1) = (1/M).*sum((y - yhat).^2);
    
    error = abs(Jgd(iter)-Jgd(iter+1));
    
    iter = iter + 1;
    
end


figure;
contour(A1, A2, J, 'ShowText','on')
xlabel('a1')
ylabel('a2')
zlabel('Je')
title('Contorno da Superfície de Erro')
hold on
scatter3(a_opt(1), a_opt(2), Joptimum, 'r*')
scatter3(a(1,:), a(2,:), Jgd, 'kx');
hold off;

figure;
semilogy(0:1:iter-1, Jgd)
xlabel('Iteração')
ylabel('Je')
xlim([0 iter-1])
grid on