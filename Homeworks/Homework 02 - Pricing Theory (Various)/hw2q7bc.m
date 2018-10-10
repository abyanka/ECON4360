% -------------------------------------------------------------------------
% Key: Homework 2, Number 7b-c
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

w_X = zeros(6);
w_Y = zeros(6);
w_Z = zeros(6);

% Variance-Covariance Matrix
SIGMA = [sigma_X^2 sigma_XY sigma_XZ; sigma_XY sigma_Y^2 sigma_YZ; sigma_XZ sigma_YZ sigma_Z^2];

for r = 1:6
    
% Initial Conditions
W_initial = [0 0 0]';

% Boundary Conditions
lower = [-inf -inf -inf];
upper = [inf inf inf];

% Matrices for Linear Inequality Constraints
A = [];
b = [];

% Matrices for Linear Equality Constraints
Aeq = [1 1 1; ER_X ER_Y ER_Z];
beq = [1; ((r+5))];

% Library Routine: Finds Minimum of Constrained Nonlinear Multivariable
% Function
options = optimset('Algorithm','sqp');
[W2 f] = fmincon(@(W)port_var(W,SIGMA),W_initial,A,b,Aeq,beq,lower,upper,[],options);

% Displays Solutions to Screen
disp('Solutions for Weights:');
disp(W2);

% Verifies Expected Portfolio Return
w_X(r) = W2(1);
w_Y(r) = W2(2);
w_Z(r) = W2(3);
ER_P(r) = w_X(r)*ER_X + w_Y(r)*ER_Y + w_Z(r)*ER_Z;

% Calculates Portfolio Variance
sigma_P(r) = W2'*SIGMA*W2;
    
end

clc;
% Displays Solutions to Screen
fprintf('\n w(X)    w(Y)    w(Z)    E(Rp) STD');
fprintf('\n ----------------------------------');
for r = 1:6
    fprintf('\n%7.4f %7.4f %7.4f %5.2f %5.2f', w_X(r), w_Y(r), w_Z(r), ER_P(r), sqrt(sigma_P(r)));
end
fprintf('\n');

% Plot
plot((sigma_P').^(1/2),ER_P');
hold on
    title('Expected Return v. Std Deviation');
    xlabel('Portfolio Sigma (%)');
    ylabel('Exp Portfolio Return (%)');
hold off


    
    
    