clear all;close all;clc;

rng(14021981)

fontSize = 14;

a_int = [-20;-20];

M = 100000;

x1 = randn(M, 1);

x2 = randn(M, 1);

y = x1 + x2 + randn(M,1);

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

figure1 = figure('rend','painters','pos',[10 10 800 700]);
surf(A1, A2, J)
xlabel('a_1', 'FontSize', fontSize)
ylabel('a_2', 'FontSize', fontSize)
zlabel('J_e', 'FontSize', fontSize)
title('Superfície de Erro', 'FontSize', fontSize)

%% Closed-form solution.

X = [x1 x2];

a_opt = pinv(X.'*X)*X.'*y;

yhat = a_opt(1)*x1 + a_opt(2)*x2;

Joptimum = (1/M)*sum((y - yhat).^2);





%% ------------------------------------------------------------------------
%% Stocastic Gradient Descent (SGD)
%% ------------------------------------------------------------------------

%% Stocastic Gradient Descent (SGD) solution.
alpha = 0.1;

% Initialize 'a' at a random location within the parameter's space.
a = zeros(2, 10000);
a(:,1) = a_int;

random_example = randi(M);

yhat = a(1,1)*x1(random_example) + a(2,1)*x2(random_example);

Jsgd = zeros(1, 10000);
Jsgd(1) = sum((y(random_example) - yhat).^2);

error = 1;
iter = 1;
while(error > 0.001 && iter <= 10000)
    
    random_example = randi(M);
    
    h = a(1,iter)*x1(random_example) + a(2,iter)*x2(random_example);
    
    update = -2.*(y(random_example) - h).'*[x1(random_example) x2(random_example)];
    
    a(:,iter+1) = a(:,iter) - alpha.*update.';
    
    yhat = a(1,iter+1)*x1(random_example) + a(2,iter+1)*x2(random_example);
    
    Jsgd(iter+1) = sum((y(random_example) - yhat).^2);
    
    error = abs(Jsgd(iter)-Jsgd(iter+1));
    
    iter = iter + 1;
    
end

figure2 = figure('rend','painters','pos',[10 10 800 700]);
subplot(2,1,1)
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

%figure3 = figure('rend','painters','pos',[10 10 800 700]);
subplot(2,1,2)
semilogy(0:1:iter-1, Jsgd(1:iter), 'LineWidth',1)
xlabel('Iteração', 'FontSize', fontSize)
ylabel('J_e', 'FontSize', fontSize)
title('Iterações vs. Erro', 'FontSize', fontSize)
lgd = legend('\alpha = 0.1', 'Interpreter', 'latex');
lgd.FontSize = 14;
xlim([0 iter-1])
grid on

a_scaled = a;




%% ------------------------------------------------------------------------
%% Batch Gradient Descent
%% ------------------------------------------------------------------------

%% Gradient-descent solution.
alpha = 0.3;

% Initialize 'a' at a random location within the parameter's space.
a = zeros(2, 10000);
a(:,1) = a_int;

yhat = a(1,1)*x1 + a(2,1)*x2;

Jgd = zeros(1, 10000);
Jgd(1) = (1/M)*sum((y - yhat).^2);

error = 1;
iter = 1;
while(error > 0.001 && iter <= 10000)
    
    h = a(1,iter)*x1 + a(2,iter)*x2;
    
    update = -(2./M).*(y - h).'*[x1 x2];
    
    a(:,iter+1) = a(:,iter) - alpha.*update.';
    
    yhat = a(1,iter+1)*x1 + a(2,iter+1)*x2;
    
    Jgd(iter+1) = (1/M).*sum((y - yhat).^2);
    
    error = abs(Jgd(iter)-Jgd(iter+1));
    
    iter = iter + 1;
    
end

figure2 = figure('rend','painters','pos',[10 10 800 700]);
subplot(2,1,1)
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

%figure3 = figure('rend','painters','pos',[10 10 800 700]);
subplot(2,1,2)
semilogy(0:1:iter-1, Jgd(1:iter), 'LineWidth',1)
xlabel('Iteração', 'FontSize', fontSize)
ylabel('J_e', 'FontSize', fontSize)
title('Iterações vs. Erro', 'FontSize', fontSize)
lgd = legend('\alpha = 0.5', 'Interpreter', 'latex');
lgd.FontSize = 14;
xlim([0 iter-1])
grid on

a_scaled = a;



%% ------------------------------------------------------------------------
%% Mini-Batch Gradient Descent
%% ------------------------------------------------------------------------

MB = 100;

%% Gradient-descent solution.
alpha = 0.3;

% Initialize 'a' at a random location within the parameter's space.
a = zeros(2, 10000);
a(:,1) = a_int;

random_examples = randi(M, 1, MB);

yhat = a(1,1)*x1(random_examples) + a(2,1)*x2(random_examples);

Jmbgd = zeros(1, 10000);
Jmbgd(1) = (1/MB)*sum((y(random_examples) - yhat).^2);

error = 1;
iter = 1;
while(error > 0.001 && iter <= 10000)
    
    random_examples = randi(M, 1, MB);
    
    h = a(1,iter)*x1(random_examples) + a(2,iter)*x2(random_examples);
    
    update = -(2./MB).*(y(random_examples) - h).'*[x1(random_examples) x2(random_examples)];
    
    a(:,iter+1) = a(:,iter) - alpha.*update.';
    
    yhat = a(1,iter+1)*x1(random_examples) + a(2,iter+1)*x2(random_examples);
    
    Jmbgd(iter+1) = (1/MB).*sum((y(random_examples) - yhat).^2);
    
    error = abs(Jmbgd(iter)-Jmbgd(iter+1));
    
    iter = iter + 1;
    
end

figure2 = figure('rend','painters','pos',[10 10 800 700]);
subplot(2,1,1)
contour(A1, A2, J, 'ShowText','on')
xlabel('a_1', 'FontSize', fontSize)
ylabel('a_2', 'FontSize', fontSize)
zlabel('J_e', 'FontSize', fontSize)
title('Contorno da Superfície de Erro', 'FontSize', fontSize)
hold on
%scatter3(a_opt(1), a_opt(2), Joptimum, 'r*', 'MarkerSize', 10)
%scatter3(a(1,:), a(2,:), Jgd, 'kx', 'MarkerSize', 10);
plot(a_opt(1), a_opt(2), 'r*', 'MarkerSize', 10, 'LineWidth',1);
plot(a(1,1:iter), a(2,1:iter), 'kx', 'MarkerSize', 10, 'LineWidth',1);
hold off;

%figure3 = figure('rend','painters','pos',[10 10 800 700]);
subplot(2,1,2)
semilogy(0:1:iter-1, Jmbgd(1:iter), 'LineWidth',1)
xlabel('Iteração', 'FontSize', fontSize)
ylabel('J_e', 'FontSize', fontSize)
title('Iterações vs. Erro', 'FontSize', fontSize)
lgd = legend('\alpha = 0.5', 'Interpreter', 'latex');
lgd.FontSize = 14;
xlim([0 iter-1])
grid on

a_scaled = a;


















% %% ------------------------------------------------------------------------
% %% Stocastic Gradient Descent (SGD) with learning schedule
% %% ------------------------------------------------------------------------
% 
% %% Stocastic Gradient Descent (SGD) solution.
% 
% % Learning schedule hyperparameters
% t0 = 5;
% t1 = 50;
% 
% % Initialize 'a' at a random location within the parameter's space.
% a = zeros(2, M*10000);
% a(:,1) = a_int;
% 
% random_example = randi(M);
% 
% yhat = a(1,1)*x1(random_example) + a(2,1)*x2(random_example);
% 
% Jsgd = zeros(1, M*10000);
% Jsgd(1) = sum((y(random_example) - yhat).^2);
% 
% error = 1;
% iter = 1;
% while(error > 0.001 && iter <= 100)
%     
%     i = 1;
%     while(error > 0.001)
%         
%         j = (iter - 1).*M + i;
%         
%         random_example = randi(M);
%         
%         alpha = 0.1; %t0 / ( j + t1);
%         
%         h = a(1,j)*x1(random_example) + a(2,j)*x2(random_example);
%         
%         update = -2.*(y(random_example) - h).'*[x1(random_example) x2(random_example)];
%         
%         a(:,j+1) = a(:,j) - alpha.*update.';
%         
%         yhat = a(1,j+1)*x1(random_example) + a(2,j+1)*x2(random_example);
%         
%         Jsgd(j+1) = sum((y(random_example) - yhat).^2);
%         
%         error = abs(Jsgd(j)-Jsgd(j+1));
%         
%         i = i + 1;
%         
%     end
%     
%     iter = iter + 1;
%     
% end
% 
% figure2 = figure('rend','painters','pos',[10 10 800 700]);
% subplot(2,1,1)
% contour(A1, A2, J, 'ShowText','on')
% xlabel('a_1', 'FontSize', fontSize)
% ylabel('a_2', 'FontSize', fontSize)
% zlabel('J_e', 'FontSize', fontSize)
% title('Contorno da Superfície de Erro', 'FontSize', fontSize)
% hold on
% %scatter3(a_opt(1), a_opt(2), Joptimum, 'r*', 'MarkerSize', 10)
% %scatter3(a(1,:), a(2,:), Jgd, 'kx', 'MarkerSize', 10);
% plot(a_opt(1), a_opt(2), 'r*', 'MarkerSize', 10, 'LineWidth',1);
% plot(a(1,:), a(2,:), 'kx', 'MarkerSize', 10, 'LineWidth',1);
% hold off;
% 
% %figure3 = figure('rend','painters','pos',[10 10 800 700]);
% subplot(2,1,2)
% semilogy(0:1:j-1, Jsgd(1:j), 'LineWidth',1)
% xlabel('Iteração', 'FontSize', fontSize)
% ylabel('J_e', 'FontSize', fontSize)
% title('Iterações vs. Erro', 'FontSize', fontSize)
% lgd = legend('\alpha = 0.1', 'Interpreter', 'latex');
% lgd.FontSize = 14;
% xlim([0 j-1])
% grid on
% 
% a_scaled = a;