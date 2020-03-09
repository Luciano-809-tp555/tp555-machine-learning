clear all;close all;clc

N = 10000;

x1 = 2000.*rand(1, N);

x2 = 5.*rand(1, N);

y = 0.2.*x1 + 2.1.*x2;


a1 = -10:1/10:10;
a2 = -10:1/10:10;


 

y = a1.*x1 + a2.*x2;


e = (1./N).*sum( (y - yhat).^2  );