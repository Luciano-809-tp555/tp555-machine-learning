clear all;close all;clc

x = -10:1/100:10;

f = 2.*(x.^2);

df = 4.*x;

plot(x,f)
hold on
plot(x,df)
plot(x,zeros(1,length(x)))
grid on
