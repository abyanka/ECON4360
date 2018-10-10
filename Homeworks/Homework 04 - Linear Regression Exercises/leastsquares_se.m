function [se, sigma] = leastsquares_se(e,x,n,k)

% Calculates the estimator for sigma_squared
sigma = (1/(n-k))*(e'*e);

% Calulates variance covariance matrix of parameter estimates 
vcv = sigma*inv(x'*x);

% Calculates standard errors of parameter estimates
se = sqrt(diag(vcv));

end



