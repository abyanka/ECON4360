% -------------------------------------------------------------------------
% Key: Homework 2, Number 7a
% -------------------------------------------------------------------------

clc;
clear;

% Knowns
ER_X = 7;
ER_Y = 9;
ER_Z = 8;

sigma_X = 16;
sigma_Y = 9;
sigma_Z = 11;

rho_XY = -0.8;
rho_XZ = 0.15;
rho_YZ = 0.22;

sigma_XY = rho_XY.*sigma_X.*sigma_Y;
sigma_XZ = rho_XZ.*sigma_X.*sigma_Z;
sigma_YZ = rho_YZ.*sigma_Y.*sigma_Z;

% Variance-Covariance Matrix
SIGMA = [sigma_X^2 sigma_XY sigma_XZ; sigma_XY sigma_Y^2 sigma_YZ; sigma_XZ sigma_YZ sigma_Z^2];

% Initial Conditions
W_initial = [0 0 0]';

% Boundary Conditions
lower = [-inf -inf -inf];
upper = [inf inf inf];

% Matrices for Linear Inequality Constraints
A = [];
b = [];

% Matrices for Linear Equality Constraints
Aeq = [1 1 1];
beq = [1];

% Library Routine: Finds Minimum of Constrained Nonlinear Multivariable
% Function
options = optimset('Algorithm','sqp');
[W2 f] = fmincon(@(W)port_var(W,SIGMA),W_initial,A,b,Aeq,beq,lower,upper,[],options);

% Displays Solutions to Screen
disp('Solutions for Weights:');
disp(W2);

% Verifies Expected Portfolio Return
w_X = W2(1);
w_Y = W2(2);
w_Z = W2(3);
ER_P = w_X.*ER_X + w_Y.*ER_Y + w_Z*ER_Z;

% Calculates Portfolio Variance
sigma_P = W2'*SIGMA*W2;

% Displays Solutions to Screen
disp('Expected Return on the Portfolio = ');
disp(ER_P);
disp('Std Deviation of the Portfolio = ');
disp (sqrt(sigma_P));