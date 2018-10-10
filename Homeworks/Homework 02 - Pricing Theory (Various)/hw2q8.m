% -------------------------------------------------------------------------
% Key: Homework 2, Number 8
% -------------------------------------------------------------------------

clc;
clear;

% Knowns
ER_X = 0.07;
ER_Y = 0.09;

sigma_X = 0.16;
sigma_Y = 0.09;

rho_XY = -0.8;

sigma_XY = rho_XY.*sigma_X.*sigma_Y;

% Vector of Possible Weights
w_X = linspace(0,1,100);
w_Y = linspace(1,0,100);

% Vectors of Possible Risk-Return Combinations
ER_P = w_X.*ER_X + w_Y.*ER_Y;
sigma_P = sqrt( (w_X.^2)*(sigma_X.^2) + (w_Y.^2)*(sigma_Y.^2) + 2.*w_X.*w_Y.*sigma_XY);

% Graph of Possible Risk-Return Combinations
plot(sigma_P.*100,ER_P.*100);
hold on
    title('Expected Return v. Std Deviation');
    xlabel('Portfolio Sigma (%)');
    ylabel('Exp Portfolio Return (%)');

% -------------------------------------------------------------------------

% -------------------------------------------------------------------------

% Risk-Free
ER_f = 0.04;
sigma_f = 0.0;

% Which Portfolio of X and Y?
slopes = (ER_P - ER_f)./sigma_P;
[value, my_index] = max(slopes);

% c Portfolio
w_XX = w_X(my_index);
w_YY = w_Y(my_index);

% Expected Return and STD of the Tangency Portfolio
ER_c = w_XX.*ER_X + w_YY.*ER_Y
sigma_c = sqrt( (w_XX.^2)*(sigma_X.^2) + (w_YY.^2)*(sigma_Y.^2) + 2.*w_XX.*w_YY.*sigma_XY)

% Vector of Possible Weights
w_c = linspace(0,3,100);
w_f = linspace(1,-2,100);

% Vectors of Possible Risk-Return Combinations
ER_PP = w_c.*ER_c + w_f.*ER_f;
sigma_PP = sqrt( (w_c.^2)*(sigma_c.^2));

% Graph of Possible Risk-Return Combinations
plot(sigma_PP.*100,ER_PP.*100,'g');
hold off

% Display Optimal Weights
disp ('Optimal weights for Tangency Portfolio = ');
disp(w_XX);
disp(w_YY);