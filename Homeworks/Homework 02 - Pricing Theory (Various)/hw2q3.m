% -------------------------------------------------------------------------
% Key: Homework 2, Number 3
% -------------------------------------------------------------------------

clear; clc; 

% Data --------------------------------------------------------------------

% Data is Real Personal Consumption Expenditures, PCECCA 1929-2011 (A)
load pcecca_data.txt;
% Keeps the second column, which is the consumption data
c = pcecca_data(:,2);

% Givens ------------------------------------------------------------------

% Time Preference
beta = 0.99;
% Risk Aversion
gamma = 3.5;

% -------------------------------------------------------------------------

% To compute m, we need c(t+1)/c(t)
c_tomorrow = c(2:length(c));
c_today = c(1:length(c)-1);

% SDF
m = beta.*(c_tomorrow./c_today).^(-gamma);

% Risk-Free Rate - Gives Y-int of MV Frontier
rf = 1./(mean(m));

% Slope of MV Frontier
slope = std(m)./mean(m);

fprintf('\n Y-Intercept for MV Frontier = %6.4f', rf);
fprintf('\n Slope of MV Frontier = %6.4f \n', slope);

% ------------------------------------------------------------------------
