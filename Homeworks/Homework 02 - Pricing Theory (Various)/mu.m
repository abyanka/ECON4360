function f = mu(n, gamma, p, e, pi, x, beta)
    % Marginal Utility Today
    mu_today = (e-n*p)^(-gamma)*(-p);
    % Marginal Utility Tomorrow
    mu_tomorrow = beta*pi'*((n*x).^(-gamma).*x);
    f = (mu_today + mu_tomorrow).^2;
end