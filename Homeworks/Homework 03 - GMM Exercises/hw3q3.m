% -------------------------------------------------------------------------
% Key: Homework 3, Number 3
% -------------------------------------------------------------------------

clear; clc;

%  Part a -----------------------------------------------------------------
% -------------------------------------------------------------------------

% Data: Columns are Consumption Growth, SMB, HML, RMR-RF, RF
load qdata.mat;

% Consumption Growth Rate
Cg = qdata(:,1);   
SMB = qdata(:,2);   
HML = qdata(:,3);
RM = qdata(:,4);
RF = qdata(:,5);
T = length(Cg);

fprintf('\n Correlations - Part A: ');
fprintf('\n');

corr([Cg SMB HML RM RF])

% Part b ------------------------------------------------------------------
% -------------------------------------------------------------------------

leadCg = Cg(2:end);
% Don't Forget to Drop one Observation!
SMB = SMB(1:end-1);
HML = HML(1:end-1);
RM = RM(1:end-1);
RF = RF(1:end-1);

fprintf('\n Correlations - Part B: ');
fprintf('\n');

corr([leadCg SMB HML RM RF])

% Part c ------------------------------------------------------------------
% -------------------------------------------------------------------------

% Note: Just modify and re-use the code you've already developed! ...

% Consumption Growth Rate
Cg = leadCg;

% We'll Use RMR-RF and RF for our Return Data
% - Note that these data points are excess returns
R1 = RM;
R2 = RF;

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

fprintf('\n Part C: ');
fprintf('\n');
fprintf('\n GMM Estimate for beta is    %8.4f, ',beta);
fprintf('\n     with Standard Error     %8.4f.',sqrt(V(1,1)/T));
fprintf('\n');
fprintf('\n GMM Estimate for gamma is  %8.4f, ',gamma);
fprintf('\n     with Standard Error     %8.4f.',sqrt(V(2,2)/T));
fprintf('\n');

% Part d ------------------------------------------------------------------
% -------------------------------------------------------------------------

% Again: Just modify and re-use the code you've already developed! ...
% Consumption Growth Rate
% Consumption Growth Rate
Cg = leadCg;

% We'll Use RMR-RF and RF for our Return Data
% - Note that these data points are excess returns
R1 = RM;
R2 = RF;
R3 = SMB;
R4 = HML;

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

it = 1;

% Iterate Twice
while (it <= 2)

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

end

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

fprintf('\n Part D: ');
fprintf('\n');
fprintf('\n GMM Estimate for beta is    %8.4f, ',beta);
fprintf('\n     with Standard Error     %8.4f.',sqrt(V(1,1)/T));
fprintf('\n');
fprintf('\n GMM Estimate for gamma is  %8.4f, ',gamma);
fprintf('\n     with Standard Error     %8.4f.',sqrt(V(2,2)/T));
fprintf('\n');

% Part g ------------------------------------------------------------------
% -------------------------------------------------------------------------

% Significance Level
alpha = 0.05;
% J Statistics
jstat = (T)*smoments_b(b,Cg,R1,R2,R3,R4,T,Q);
% Number of Over-Identifying Restrictions
r = 2;
% Compare with chi-square Percentiles
if ((jstat < chi2inv(1 - 0.5*alpha,r)) && (jstat > 1 - chi2inv(0.5*alpha,r)))  % compare with chi-square percentiles
    fprintf('\n Hypothesis that overidentifying restrictions = 0 could not be rejected at %5.2f percent significant level.',(alpha*100));
else
    fprintf('\n Hypothesis that overidentifying restrictions = 0 is rejected at %5.2f percent significant level.',(alpha*100));
end
fprintf('\n Calculated J statistic is %8.2f.',jstat);
fprintf('\n');



