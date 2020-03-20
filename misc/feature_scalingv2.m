clear all;close all;clc

fontSize = 14;

if(0)
    
    a_int = [-20;-20];
    
    M = 100000;
    
    x1 = 1*randn(M, 1);
    
    x2 = 1000*randn(M, 1) + 1000;
    
    y = x1 + x2;
    
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
    
    %% Gradient-descent solution.
    alpha = 0.0000002;
    
    % Initialize 'a' at a random location within the parameter's space.
    a(:,1) = a_int;
    
    yhat = a(1,1)*x1 + a(2,1)*x2;
    
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
    subplot(2,1,1);
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
    subplot(2,1,2);
    semilogy(0:1:iter-1, Jgd, 'LineWidth',1)
    xlabel('Iteração', 'FontSize', fontSize)
    ylabel('J_e', 'FontSize', fontSize)
    title('Iterações vs. Erro', 'FontSize', fontSize)
    lgd = legend('\alpha = 1e-7', 'Interpreter', 'latex');
    lgd.FontSize = 14;
    xlim([0 iter-1])
    grid on

end









if(1)
    
    a_int = [-20;-20];
    
    M = 100000;
    
    x1 = randn(M, 1);
    
    x2 = 1000*randn(M, 1) + 1000;
    
    y = x1 + x2;
    
    x2_mean = mean(x2);
    x2_std = std(x2);
    x2 = (x2 - x2_mean) ./ (x2_std);
    
    y_mean = mean(y);
    y_std = std(y);
    y = (y - y_mean) ./ (y_std);    
     
    a1 = -20:1/1:24;
    
    a2 = -20:1/1:24;
    
    [A1, A2] = meshgrid(a1,a2);
    
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
    
    %% Gradient-descent solution.
    alpha = 0.5;
    
    % Initialize 'a' at a random location within the parameter's space.
    a(:,1) = a_int;
    
    yhat = a(1,1)*x1 + a(2,1)*x2;
    
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
    subplot(2,1,1);
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
    subplot(2,1,2);
    semilogy(0:1:iter-1, Jgd, 'LineWidth',1)
    xlabel('Iteração', 'FontSize', fontSize)
    ylabel('J_e', 'FontSize', fontSize)
    title('Iterações vs. Erro', 'FontSize', fontSize)
    lgd = legend('\alpha = 1e-7', 'Interpreter', 'latex');
    lgd.FontSize = 14;
    xlim([0 iter-1])
    grid on

end

















if(0)
    
    a_int = [-20;-20];
    
    M = 100000;
    
    x1 = randn(M, 1);
    
    x2 = 1000*randn(M, 1) + 1000;
    
    y = x1 + x2;
    
    x2_mean = mean(x2);
    x2_std = std(x2);
    x2 = (x2 - x2_mean) ./ (x2_std);
     
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
    
    %% Gradient-descent solution.
    alpha = 0.4;
    
    % Initialize 'a' at a random location within the parameter's space.
    a(:,1) = a_int;
    
    yhat = a(1,1)*x1 + a(2,1)*x2;
    
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
    subplot(2,1,1);
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
    subplot(2,1,2);
    semilogy(0:1:iter-1, Jgd, 'LineWidth',1)
    xlabel('Iteração', 'FontSize', fontSize)
    ylabel('J_e', 'FontSize', fontSize)
    title('Iterações vs. Erro', 'FontSize', fontSize)
    lgd = legend('\alpha = 1e-7', 'Interpreter', 'latex');
    lgd.FontSize = 14;
    xlim([0 iter-1])
    grid on

end