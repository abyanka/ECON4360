% -------------------------------------------------------------------------
% Key: Homework 3, Number 2b
% -------------------------------------------------------------------------

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% - Finds parameters in the consumption-based asset
%   pricing model with CRRA utility (no time discounting)
% - Utility Function: u(c)=(1/(1-gamma))*c^(1-gamma)
% - Uses HAC
% - Case 2: 2 parameters, 4 equations             
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear; clc;

% Loads data --------------------------------------------------------------

% Data: Columns are Year, Consumption Growth, RMR-RF, SMB, HML, RF
load data.mat;

% Consumption Growth Rate
Cg = data(:,2);   

% We'll Use RMR-RF, Rf, SML, and HML for our Return Data
% - Note that these data points are excess returns
R1 = data(:,3);   
R2 = data(:,6);
R3 = data(:,4);
R4 = data(:,5);

% How Many Time Periods of Data Do We Have?
T = length(Cg);

% GMM Solves for the Parameters -------------------------------------------

% We Make an Initial Guess, Some Starting Value, and Weighting Matrix
% - b = [beta gamma]';
b0 = [0.99 2.0]';
b = [1 1]';
Q = eye(4);

% Options
options = optimset('MaxIter',10000,'MaxFunEvals',10000,'TolFun',1e-8,'TolX',1e-8);
it = 0;

% Iterate Until Convergence
while ((abs(b-b0) > 0.01))

    % Now We Use GMM to Solve for the Moment Conditions
    b = fminsearch(@(b)smoments_b(b,Cg,R1,R2,R3,R4,T,Q),b0);
    beta = b(1);
    gamma = b(2);
    
    % Update Weighting Matrix
    % -----------------------
    % Now, We Want to Calculate Standard Errors     
    % First, We Compute Residuals
    % ---------------------------
    % Calculates Stochastic Discount Factor
    m = beta.*(Cg.^(-gamma));
    % Calculates Residuals for Each Moment Equation
    u1 = (R1.*m);
    u2 = (R2.*m) - 1;
    u3 = (R3.*m);
    u4 = (R4.*m);  
    u = [u1 u2 u3 u4];
    % Second, We Find the Variance-Covariance Matrix for the Residual 
    % Sample  Means (Newey-West)
    % ---------------------------------------------------------------------
    % Initialization
    S = zeros(4,4);
    % q Specifies the Maximum Number of Lags to Use
    q = 5;    
    % This is Just the Variance-Covariance Matrix
    S = S + autocov(0,u,T);    
    % This Following is the Adjustment for Autocorrelation and
    % Heteroskedasticy
    for v = 1:q
       Gv = autocov(v,u,T); % Call function 'autoc' that computes k-th order covariance matrix
       S = S + (1-(v/(q+1)))*(Gv+Gv');
       clear Gv
    end    
 
    % Update Coefficients
    b0 = b;
    Q = inv(S);
    b = fminsearch(@(b)smoments_b(b,Cg,R1,R2,R3,R4,T,Q),b0);
    
    it = it + 1;
    if (it > 10000), break, end
end

% Displays Iterations
fprintf('\n Iterations = %2.0f',it);
fprintf('\n');

% We Find the Gradiant Matrix

% We Find the Gradiant Matrix
% Initialization for d
d = zeros(4,2);
% d(g1)/d(beta)
d(1,1) = (1/T)*(R1'*m)/beta;
% d(g2)/d(beta)
d(2,1) = (1/T)*(R2'*m)/beta;
% d(g3)/d(beta)
d(3,1) = (1/T)*(R3'*m)/beta;
% d(g4)/d(beta)
d(4,1) = (1/T)*(R4'*m)/beta;
% d(g1)/d(gamma)
d(1,2) = -(1/T)*(R1'*(m.*log(Cg)));
% d(g2)/d(gamma)
d(2,2) = -(1/T)*(R2'*(m.*log(Cg)));
% d(g3)/d(gamma)
d(3,2) = -(1/T)*(R3'*(m.*log(Cg)));
% d(g4)/d(gamma)
d(4,2) = -(1/T)*(R4'*(m.*log(Cg)));

% We Find the Variance-Covariance Matrix for the Estimates
V = inv(d'*inv(S)*d);

% Displays Results --------------------------------------------------------

fprintf('\n GMM Estimate for beta is    %8.4f, ',beta);
fprintf('\n     with Standard Error     %8.4f.',sqrt(V(1,1)/T));
fprintf('\n');
fprintf('\n GMM Estimate for gamma is  %8.4f, ',gamma);
fprintf('\n     with Standard Error     %8.4f.',sqrt(V(2,2)/T));
fprintf('\n');

