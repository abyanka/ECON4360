function F = smoments_a(b,Cg,R1,R2,T)

    % Parses out Individual Parameters from Parameter Vector b
    beta = b(1);
    gamma = b(2);

    % Calculates Stochastic Discount Factor
    % - m is a Tx1 vector
    m = beta.*Cg.^(-gamma);

    % Calculates Moment Conditions
    % - Note that R1, R2, and m are Tx1 vectors
    % - So R'*m has dimensions [1xT] * [T*1] = [1]
    % - MC = 1/T * Sum(mR)
    % - The MC's are our moment conditions - We have 2 here; one for each
    % asset
    MC(1) = ((1/T)*(R1'*m));
    MC(2) = ((1/T)*(R2'*m)) - 1.0;
        
    F = MC;

end

