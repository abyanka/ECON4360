% -------------------------------------------------------------------------
% Key: Homework 2, Number 1
% -------------------------------------------------------------------------

clear; clc; 

% Givens ------------------------------------------------------------------

% States of the World
state = linspace(11,30,20)';
% Current Consumption
c_today = 8;
% Time Preference
beta = 0.99;
% Risk Aversion
alpha = 0.2;

% -------------------------------------------------------------------------

% SDF (for all states, all assets)
m = beta*exp((state./2)*(-alpha))/exp(c_today*(-alpha));

% -------------------------------------------------------------------------

% Payoffs for A
x = 30 + state./2;

% Price of Asset A, p = E(mx)
p = m.*x;
p = mean(p);
fprintf ('\n Q1: Price of A is %3.2f', p);

% Expected Payoff of A
Exp_Payoff = mean(x);

% Expected Return
Exp_Return = Exp_Payoff/p;
fprintf ('\n Q1: Expected Return for A is %3.2f', Exp_Return);

% -------------------------------------------------------------------------

% Payoffs for B
x = 50 - state./2;

% Price of Asset B, p = E(mx)
p = m.*x;
p = mean(p);
fprintf ('\n Q1: Price of B is %3.2f', p);

% Expected Payoff of B
Exp_Payoff = mean(x);

% Expected Return
Exp_Return = Exp_Payoff/p;
fprintf ('\n Q1: Expected Return for B is %3.2f', Exp_Return);

% -------------------------------------------------------------------------

% Risk-Free Rate
Rf = 1/mean(m);
fprintf ('\n Q1: Risk-Free Rate is %3.2f', Rf);
fprintf ('\n');

% ------------------------------------------------------------------------