function F = smoments_b(b,Cg,R1,R2,R3,R4,T,Q)

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
    MC(3) = ((1/T)*(R3'*m));
    MC(4) = ((1/T)*(R4'*m));
        
    F = MC*Q*MC';

end

