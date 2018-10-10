% -------------------------------------------------------------------------
% Key: Homework 3, Number 2a
% -------------------------------------------------------------------------

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% - Finds parameters in the consumption-based asset
%   pricing model with CRRA utility (no time discounting)
% - Utility Function: u(c)=(1/(1-gamma))*c^(1-gamma)
% - Assumes i.i.d. Moment Conditions
% - Case 1: 2 parameters, 2 equations             
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear; clc;

% Loads data --------------------------------------------------------------

% Data: Columns are Year, Consumption Growth, RMR-RF, SMB, HML, RF
load data.mat;

% Consumption Growth Rate
Cg = data(:,2);   

% We'll Use RMR-RF and RF for our Return Data
% - Note that these data points are excess returns
R1 = data(:,3);   
R2 = data(:,6);

% How Many Time Periods of Data Do We Have?
T = length(Cg);

% GMM Solves for the Parameters -------------------------------------------

% We Make an Initial Guess for our Parameters
% - b = [beta gamma]';
b0 = [0.99 2.0]';

% Now We Use GMM to Solve for the Moment Conditions
b = fsolve(@(b)smoments_a(b,Cg,R1,R2,T),b0);
beta = b(1);
gamma = b(2);

% Now, We Want to Calculate Standard Errors -------------------------------

% First, We Compute Residuals

    % Calculates Stochastic Discount Factor
    m = beta.*Cg.^(-gamma);

    % Calculates Residuals for Each Moment Equation
    u1 = (R1.*m);
    u2 = (R2.*m) - 1.0;

% Second, We Find the Variance-Covariance Matrix for the Residual Sample 
% Means

    % Initialization
    S = zeros(2,2);

    % Just using the Variance-Covariance (i.e., Big Gamma Hat (0)) for S here
    % - (here, 2x2, the variance-covariance matrix)
    z = [u1,u2];
    S = (1/T)*(z'*z);

% Third, We Find the Gradiant Matrix

    % Initialization for d
    d = zeros(2,2);
    % d(g1)/d(beta)
    d(1,1) = (1/T)*(R1'*m)/beta;
    % d(g2)/d(beta)
    d(2,1) = (1/T)*(R2'*m)/beta;
    % d(g1)/d(gamma)
    d(1,2) = -(1/T)*(R1'*(m.*log(Cg)));        
    % d(g2)/d(gamma)
    d(2,2) = -(1/T)*(R2'*(m.*log(Cg)));

% Fourth, We Find the Variance-Covariance Matrix for the Estimates

    V = inv(d'*inv(S)*d);

% Displays Results --------------------------------------------------------

fprintf('\n GMM Estimate for beta is    %8.4f, ',beta);
fprintf('\n     with Standard Error     %8.4f.',sqrt(V(1,1)/T));
fprintf('\n');
fprintf('\n GMM Estimate for gamma is  %8.4f, ',gamma);
fprintf('\n     with Standard Error     %8.4f.',sqrt(V(2,2)/T));
fprintf('\n');





