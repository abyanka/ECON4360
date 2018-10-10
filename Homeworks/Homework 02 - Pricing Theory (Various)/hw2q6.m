% -------------------------------------------------------------------------
% Key: Homework 2, Number 6
% -------------------------------------------------------------------------

clc;
clear;

% Knowns
ER_X = 0.12;
ER_Y = 0.08;
ER_Z = 0.08;

sigma_X = 0.16;
sigma_Y = 0.07;
sigma_Z = 0.05;

rho_XY = 0.40;
rho_XZ = 0.85;

sigma_XY = rho_XY.*sigma_X.*sigma_Y;
sigma_XZ = rho_XZ.*sigma_X.*sigma_Z;

% Weights
w_X = 0.50;
w_Y = 0.50;
w_Z = 0.50;

% Possible Risk-Return Combinations
ER_P_XY = w_X.*ER_X + w_Y.*ER_Y
sigma_P_XY = sqrt( (w_X.^2)*(sigma_X.^2) + (w_Y.^2)*(sigma_Y.^2) + 2.*w_X.*w_Y.*sigma_XY)

ER_P_XZ = w_X.*ER_X + w_Z.*ER_Z
sigma_P_XZ = sqrt( (w_X.^2)*(sigma_X.^2) + (w_Z.^2)*(sigma_Z.^2) + 2.*w_X.*w_Z.*sigma_XZ)
