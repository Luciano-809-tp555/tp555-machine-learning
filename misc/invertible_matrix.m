clear all;close all;clc

% A = [1 2 3; 4 5 6; 2*0.1 4*0.87 6].';
% 
% rank(A)
% 
% inv(A)
% 
% [v u] = eig(A)


% A = [1 2 3; 4 5 6; 2 4 6].';
% 
% rank(A)
% 
% pinv(A)
% 
% [v u] = eig(A)


% 
% A = [1 2; 3 4; 5 6].';
% 
% det(A'*A)
% 
% rank(A'*A)
% 
% inv(A'*A)
% 
% [v u] = eig(A'*A)





% %A = randn(2,3);
% A = [2 0 0; 0 1 0; 0 0 0];
% 
% det(A'*A)
% 
% rank(A'*A)
% 
% %pinv(A'*A)
% 
% [v u] = eig(A'*A)


%A = [1 2 3; 4 5 6];

A = [1 2 3; 7 13 6; 17 8 9];

rank(A.'*A)

det(A.'*A)

inv(A.'*A)

