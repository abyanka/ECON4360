% -------------------------------------------------------------------------
%
% ECON 4360 Spring 2014
% Solutions: Homework 01, Q1
%
% -------------------------------------------------------------------------

clear; clc;

cstar = 2;
cons = linspace(0,2,1000)';
quadut = -0.5*(cstar - cons).^2;
margut = cstar - cons;

hold on
plot(cons,quadut);
plot(cons,margut,'--r');
title('Quadratic Utility')
legend('Utility','Marginal Utility')
xlabel('C')
hold off
