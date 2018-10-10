%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  FUNCTION:    autocov.m
%
%  PURPOSE:     This File: Function File that Computes the qth Order
%               Covariance Matrix             
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Gv = autocov(q,u,T)

    % Computes the qth-th order covariance matrix

    % z is Tx2
    z = [u];
    % z_lag is just the z matrix lagged back q periods
    z_lag = lagmatrix(z,q);

    % Deletes first q data points according to definition of Gv
    z = z(q+1:end,:);
    z_lag = z_lag(q+1:end,:);

    Gv = (1/(T-q))*(z'*z_lag);

end
