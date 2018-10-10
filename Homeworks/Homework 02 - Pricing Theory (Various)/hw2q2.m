% -------------------------------------------------------------------------
% Key: Homework 2, Number 2
% -------------------------------------------------------------------------

clear; clc; 

% Givens ------------------------------------------------------------------

% Time Preference
beta = 0.99;
% Risk Aversion
gamma = 3;
% Endowment
e = 25;
% Current Stock Price
p = 15;
% Probability of State
pi = [0.1 0.1 0.3 0.4 0.1]';
% Payoff, given State
x = [32 22 10 23 48]';

% -------------------------------------------------------------------------

% The Answer is 0.821.
% You can get to it using fzero - but fmincon is really better here, since
% you can constrain the range of n
n = fmincon(@(n)mu(n,gamma,p,e,pi,x,beta),0.821,[],[],[],[],0,2);
utility = u(n,gamma,p,e,pi,x,beta);
fprintf ('\n Utility at %5.3f is %10.8f',n,utility);
fprintf ('\n');

% Many of you got 0.7212...  (But this is wrong...)
n = fmincon(@(n)mu(n,gamma,p,e,pi,x,beta),0.7212,[],[],[],[],0,2);
utility = u(n,gamma,p,e,pi,x,beta);
fprintf ('\n Utility at %5.3f is %10.8f',n,utility);
fprintf ('\n');

% ... Here, you can see why:
n = linspace(0.6,0.9,10000);
for i = 1:length(n)
    utilities(i) = u(n(i),gamma,p,e,pi,x,beta);
end
plot(n,utilities)

% ------------------------------------------------------------------------

