function f = u(n, gamma, p, e, pi, x, beta)
    % Utility Today
    u_today = (e-n*p)^(1-gamma)/(1-gamma);
    % Utility Tomorrow
    u_tomorrow = beta*pi'*((n*x).^(1-gamma))/(1-gamma);
    f = u_today + u_tomorrow;
end

