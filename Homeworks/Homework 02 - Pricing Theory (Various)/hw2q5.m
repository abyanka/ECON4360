% -------------------------------------------------------------------------
% Key: Homework 2, Number 5
% -------------------------------------------------------------------------

clear; clc; 

% -------------------------------------------------------------------------

% Payoff Matrix
C = [0 2 7 12; 0 0 1 6; 11 6 1 0; 10 5 0 0];
% Price Vector
P = [5.00; 1.50; 4.00; 3.27];

% -------------------------------------------------------------------------

% State Prices
phi = inv(C)*P;

% -------------------------------------------------------------------------

% Implied Price of Barrel of Oil
% - Payoff vector for the Barrel
    x = [70 75 80 85];
% - Implied Price of the Barrel
    p_barrel = x*phi;

% ------------------------------------------------------------------------

% A Replicating Portfolio for the Barrel of Oil
% - The payoff vector we want to replicate
% - Here, this is just the payoffs of the barrel of oil
    Z = x;
% - Replicating Portfolio
n = Z*inv(C);