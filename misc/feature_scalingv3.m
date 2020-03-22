clear all;close all;clc

fontSize = 14;

% Initial parameters.
a_int = [-20;-20];

M = 100000;

% Training set.
x1 = rand(M, 1);

x2 = 10*rand(M, 1) + 10;

y = x1 + x2;

% Prediction set.
Mp = M;
x1p = rand(Mp, 1);

x2p = 10*rand(Mp, 1) + 10;

yp = x1p + x2p;

% Parameter space.
a1 = -20:1/1:24;

a2 = -20:1/1:24;

[A1,A2] = meshgrid(a1,a2);


non_scalled = 1;
standardization = 1;
target_standardization = 0;
minmaxscaling = 1;
target_minmaxscaling = 0;

if(non_scalled==1)
    
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
    title('Superficie de Erro', 'FontSize', fontSize)
    
    %% Closed-form solution.
    
    X = [x1 x2];
    
    a_opt = pinv(X.'*X)*X.'*y;
    
    yhat = a_opt(1)*x1 + a_opt(2)*x2;
    
    Joptimum = (1/M)*sum((y - yhat).^2);
    
    %% Gradient-descent solution.
    alpha = 0.002;
    
    % Initialize 'a' at a random location within the parameter's space.
    a(:,1) = a_int;
    
    yhat = a(1,1)*x1 + a(2,1)*x2;
    
    Jgd(1) = (1/M)*sum((y - yhat).^2);
    
    error = 1;
    iter = 1;
    while(error > 0.001 && iter <= 10000)
        
        h = a(1,iter)*x1 + a(2,iter)*x2;
        
        update = -(2./M).*(y - h).'*X;
        
        a(:,iter+1) = a(:,iter) - alpha.*update.';
        
        yhat = a(1,iter+1)*x1 + a(2,iter+1)*x2;
        
        Jgd(iter+1) = (1/M).*sum((y - yhat).^2);
        
        error = abs(Jgd(iter)-Jgd(iter+1));
        
        iter = iter + 1;
        
    end
    
    fprintf(1, 'Training error: %1.4e\n', Jgd(iter));
    yhatp = a(1,iter)*x1p + a(2,iter)*x2p;
    Jgdp = (1/Mp).*sum((yp - yhatp).^2);
    fprintf(1, 'Prediction error: %1.4e\n', Jgdp);
    
    figure2 = figure('rend','painters','pos',[10 10 800 700]);
    subplot(2,1,1);
    contour(A1, A2, J, 'ShowText','on')
    xlabel('a_1', 'FontSize', fontSize)
    ylabel('a_2', 'FontSize', fontSize)
    zlabel('J_e', 'FontSize', fontSize)
    title('Contorno da Superficie de Erro', 'FontSize', fontSize)
    hold on
    %scatter3(a_opt(1), a_opt(2), Joptimum, 'r*', 'MarkerSize', 10)
    %scatter3(a(1,:), a(2,:), Jgd, 'kx', 'MarkerSize', 10);
    plot(a_opt(1), a_opt(2), 'r*', 'MarkerSize', 10, 'LineWidth',1);
    plot(a(1,:), a(2,:), 'kx', 'MarkerSize', 10, 'LineWidth',1);
    hold off;
    
    %figure3 = figure('rend','painters','pos',[10 10 800 700]);
    subplot(2,1,2);
    semilogy(0:1:iter-1, Jgd, 'LineWidth',1)
    xlabel('Iteracao', 'FontSize', fontSize)
    ylabel('J_e', 'FontSize', fontSize)
    title('Iteracoes vs. Erro', 'FontSize', fontSize)
    strlgd = sprintf('$\\alpha = %1.0e$', alpha);
    lgd = legend({strlgd}, 'Interpreter', 'latex');
    lgd.FontSize = 14;
    xlim([0 iter-1])
    grid on
    
end










if(standardization==1)
    clear a Jgd
    
    x1_mean = mean(x1);
    x1_std = std(x1);
    x1 = (x1 - x1_mean) ./ (x1_std);
    
    x2_mean = mean(x2);
    x2_std = std(x2);
    x2 = (x2 - x2_mean) ./ (x2_std);
    
    if(target_standardization==1)
        y_mean = mean(y);
        y_std = std(y);
        y = (y - y_mean) ./ (y_std);
    end
    
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
    title('Superficie de Erro', 'FontSize', fontSize)
    
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
        
        update = -(2./M).*(y - h).'*X;
        
        a(:,iter+1) = a(:,iter) - alpha.*update.';
        
        yhat = a(1,iter+1)*x1 + a(2,iter+1)*x2;
        
        Jgd(iter+1) = (1/M).*sum((y - yhat).^2);
        
        error = abs(Jgd(iter)-Jgd(iter+1));
        
        iter = iter + 1;
        
    end
    
    fprintf(1, 'Training error: %1.4e\n', Jgd(iter));
    
    x1p = (x1p - x1_mean) ./ x1_std;
    x2p = (x2p - x2_mean) ./ x2_std;
    if(target_standardization==1)
        yp = (yp - y_mean) ./ (y_std);
    end
    
    yhatp = a(1,iter)*x1p + a(2,iter)*x2p;
    Jgdp = (1/Mp).*sum((yp - yhatp).^2);
    fprintf(1, 'Prediction error: %1.4e\n', Jgdp);
    
    figure2 = figure('rend','painters','pos',[10 10 800 700]);
    subplot(2,1,1);
    contour(A1, A2, J, 'ShowText','on')
    xlabel('a_1', 'FontSize', fontSize)
    ylabel('a_2', 'FontSize', fontSize)
    zlabel('J_e', 'FontSize', fontSize)
    title('Contorno da Superficie de Erro', 'FontSize', fontSize)
    hold on
    %scatter3(a_opt(1), a_opt(2), Joptimum, 'r*', 'MarkerSize', 10)
    %scatter3(a(1,:), a(2,:), Jgd, 'kx', 'MarkerSize', 10);
    plot(a_opt(1), a_opt(2), 'r*', 'MarkerSize', 10, 'LineWidth',1);
    plot(a(1,:), a(2,:), 'kx', 'MarkerSize', 10, 'LineWidth',1);
    hold off;
    
    %figure3 = figure('rend','painters','pos',[10 10 800 700]);
    subplot(2,1,2);
    semilogy(0:1:iter-1, Jgd, 'LineWidth',1)
    xlabel('Iteracao', 'FontSize', fontSize)
    ylabel('J_e', 'FontSize', fontSize)
    title('Iteracoes vs. Erro', 'FontSize', fontSize)
    strlgd = sprintf('$\\alpha = %1.0e$', alpha);
    lgd = legend({strlgd}, 'Interpreter', 'latex');
    lgd.FontSize = 14;
    xlim([0 iter-1])
    grid on
    
end

















if(minmaxscaling==1)
    clear a Jgd
    
    x1_min = min(x1);
    x1_max = max(x1);
    x1 = (x1 - x1_min) ./ (x1_max - x1_min);
    
    x2_min = min(x2);
    x2_max = max(x2);
    x2 = (x2 - x2_min) ./ (x2_max - x2_min);
    
    if(target_minmaxscaling==1)
        y_min = min(y);
        y_max = max(y);
        y = (y - y_min) ./ (y_max - y_min);
    end
    
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
    title('Superficie de Erro', 'FontSize', fontSize)
    
    %% Closed-form solution.
    
    X = [x1 x2];
    
    a_opt = pinv(X.'*X)*X.'*y;
    
    yhat = a_opt(1)*x1 + a_opt(2)*x2;
    
    Joptimum = (1/M)*sum((y - yhat).^2);
    
    %% Gradient-descent solution.
    alpha = 0.8;
    % Initialize 'a' at a random location within the parameter's space.
    a(:,1) = a_int;
    
    yhat = a(1,1)*x1 + a(2,1)*x2;
    
    Jgd(1) = (1/M)*sum((y - yhat).^2);
    
    error = 1;
    iter = 1;
    while(error > 0.001 && iter <= 10000)
        
        h = a(1,iter)*x1 + a(2,iter)*x2;
        
        update = -(2./M).*(y - h).'*X;
        
        a(:,iter+1) = a(:,iter) - alpha.*update.';
        
        yhat = a(1,iter+1)*x1 + a(2,iter+1)*x2;
        
        Jgd(iter+1) = (1/M).*sum((y - yhat).^2);
        
        error = abs(Jgd(iter)-Jgd(iter+1));
        
        iter = iter + 1;
        
    end
    
    fprintf(1, 'Training error: %1.4e\n', Jgd(iter));
    x1p = (x1p - x1_min) ./ (x1_max - x1_min);
    x2p = (x2p - x2_min) ./ (x2_max - x2_min);
    if(target_minmaxscaling==1)
        yp = (yp - y_min) ./ (y_max - y_min);
    end
    yhatp = a(1,iter)*x1p + a(2,iter)*x2p;
    Jgdp = (1/Mp).*sum((yp - yhatp).^2);
    fprintf(1, 'Prediction error: %1.4e\n', Jgdp);
    
    figure2 = figure('rend','painters','pos',[10 10 800 700]);
    subplot(2,1,1);
    contour(A1, A2, J, 'ShowText','on')
    xlabel('a_1', 'FontSize', fontSize)
    ylabel('a_2', 'FontSize', fontSize)
    zlabel('J_e', 'FontSize', fontSize)
    title('Contorno da Superficie de Erro', 'FontSize', fontSize)
    hold on
    %scatter3(a_opt(1), a_opt(2), Joptimum, 'r*', 'MarkerSize', 10)
    %scatter3(a(1,:), a(2,:), Jgd, 'kx', 'MarkerSize', 10);
    plot(a_opt(1), a_opt(2), 'r*', 'MarkerSize', 10, 'LineWidth',1);
    plot(a(1,:), a(2,:), 'kx', 'MarkerSize', 10, 'LineWidth',1);
    hold off;
    
    %figure3 = figure('rend','painters','pos',[10 10 800 700]);
    subplot(2,1,2);
    semilogy(0:1:iter-1, Jgd, 'LineWidth',1)
    xlabel('Iteracao', 'FontSize', fontSize)
    ylabel('J_e', 'FontSize', fontSize)
    title('Iteracoes vs. Erro', 'FontSize', fontSize)
    strlgd = sprintf('$\\alpha = %1.0e$', alpha);
    lgd = legend({strlgd}, 'Interpreter', 'latex');
    lgd.FontSize = 14;
    xlim([0 iter-1])
    grid on
    
end