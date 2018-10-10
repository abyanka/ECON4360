% -------------------------------------------------------------------------
% Key: Homework 3, Number 1
% -------------------------------------------------------------------------

clear; clc;

%  Part a -----------------------------------------------------------------

% Data: Columns are Year, Consumption Growth, RMR-RF, SMB, HML, RF
load data.mat;

% Consumption Growth Rate
Cg = data(:,2);   
T = length(Cg);

% We'll Use RMR-RF, SMB, and HML for our Return Data
% - Note that these data points are excess returns
R1 = data(:,3);   
R2 = data(:,4);
R3 = data(:,5);

fprintf('\n Means: ');
fprintf('\n        - Consumption Growth: %6.4f ',mean(Cg));
fprintf('\n        - RMRF:               %6.4f ',mean(R1));
fprintf('\n        - SMB:                %6.4f ',mean(R2));
fprintf('\n        - HML:                %6.4f ',mean(R3));
fprintf('\n');

corr([Cg R1 R2 R3])

% Part b ------------------------------------------------------------------

beta = 1.0;

for gamma = 0:100
    m = beta.*(Cg.^(-gamma));
    value(gamma+1) = (R1'*m)/T;
end
plot(value,'b')
hold on

for gamma = 0:100
    m = beta.*(Cg.^(-gamma));
    value(gamma+1) = (R2'*m)/T;
end
plot(value,'r')

for gamma = 0:100
    m = beta.*(Cg.^(-gamma));
    value(gamma+1) = (R3'*m)/T;
end
plot(value,'g')
legend ('RMRF','SMB','HML')
hold off
