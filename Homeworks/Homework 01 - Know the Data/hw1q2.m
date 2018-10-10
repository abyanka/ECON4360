% -------------------------------------------------------------------------
%
% ECON 4360 Spring 2014
% Solutions: Homework 01, Q2
%
% -------------------------------------------------------------------------

clear; clc;

diary hw1q2.txt
diary on

% Loads Data-File into Memory
load data.txt

% Creates/Parses Variables from Data Matrix
Stocks = data(:,2);
DP = data(:,3);
Dg = data(:,4);
Tbill = data(:,5);

% Part (a)
% -------------------------------------------------------------------------
% Displays Means and Std Dev's
fprintf('\n');
fprintf('\n Mean Stock Return  = %5.2f, with Standard Deviation = %5.2f',mean(Stocks)*100,std(Stocks)*100);
fprintf('\n Mean Bond Return   = %5.2f, with Standard Deviation = %5.2f',mean(Tbill)*100,std(Tbill)*100);
fprintf('\n Mean Excess Return = %5.2f, with Standard Deviation = %5.2f',mean(Stocks-Tbill)*100,std(Stocks-Tbill)*100);
fprintf('\n');

% Parts (d) and (e)
% -------------------------------------------------------------------------
% Plots Data
figure(1)
hold on
plot(1926:2012,Stocks.*100);
plot(1926:2012,Tbill.*100,'--r');
legend('Stocks','Bonds')
xlabel('Year')
ylabel('Returns')
hold off

figure(2)
hold on
plot(1926:2012,DP.*100);
xlabel('Year')
ylabel('Percent')
title('Dividend Price Ratio')
hold off

% Part (g)
% -------------------------------------------------------------------------
% Regressions: Stocks
mystats = regstats(Stocks(2:end),Stocks(1:end-1),'linear',{'beta','tstat','rsquare'});
fprintf('\n Stocks:  b = %5.2f, t(b) = %5.2f, R2 = %5.2f',mystats.beta(2), mystats.tstat.t(2),mystats.rsquare);
% Regressions: Bonds
mystats = regstats(Tbill(2:end),Tbill(1:end-1),'linear',{'beta','tstat','rsquare'});
fprintf('\n Bonds:   b = %5.2f, t(b) = %5.2f, R2 = %5.2f',mystats.beta(2), mystats.tstat.t(2),mystats.rsquare);
% Regressions: Excess
mystats = regstats(Stocks(2:end)-Tbill(2:end),Stocks(1:end-1)-Tbill(1:end-1),'linear',{'beta','tstat','rsquare'});
fprintf('\n Excess:  b = %5.2f, t(b) = %5.2f, R2 = %5.2f',mystats.beta(2), mystats.tstat.t(2),mystats.rsquare);
fprintf('\n');

% Parts (i) and (k)
% -------------------------------------------------------------------------
% Forecasting Regression
mystats = regstats(Stocks(2:end)-Tbill(2:end),DP(1:end-1),'linear',{'beta','tstat','rsquare'});
fprintf('\n Excess:  b = %5.2f, t(b) = %5.2f, R2 = %5.2f',mystats.beta(2), mystats.tstat.t(2),mystats.rsquare);
fprintf('\n E(R) = %5.2f and sigma(E(R)) = %5.2f',mean(Stocks(2:end)-Tbill(2:end))*100,std(mystats.beta(1)+mystats.beta(2).*DP(1:end-1))*100);
fprintf('\n');
fprintf('\n');

diary off
