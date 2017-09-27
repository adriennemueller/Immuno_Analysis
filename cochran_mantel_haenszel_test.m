% Assumes a matrix 2 by 2 by k matrix with k = number of experiments. e.g.

% k = 1      Co-Parv+    Parv+ Only
% Benny D1R    77          139
%       D2R   150           40


% k = 2      Co-Parv+    Parv+ Only    
% Marilyn D1R  45          88 
%         D2R 200          30

function p_val = cochran_mantel_haenszel_test( cell_mat, apply_cont_corr )

    if apply_cont_corr == 1
        cont_corr = 0.5;
    else
        cont_corr = 0;
    end
    
    numerators = [];
    denoms     = [];

    [m n k] = size( cell_mat );
    
    for i = 1:k
        a = cell_mat(1,1,k); b = cell_mat(1,2,k);
        c = cell_mat(2,1,k); d = cell_mat(2,2,k);
        
        numsum = a - ((a+b) * (a+c)) / (a+b+c+d); 
        numerators = [numerators numsum];

        denomsum = (a+b) * (a+c) * (b+d) * (c+d) / ( (a+b+c+d)^3 - (a+b+c+d)^2 );
        denoms = [denoms denomsum];
    end
    
    
    ch_val = (abs( sum( numerators ) ) - cont_corr) ^2 / sum( denoms );
    deg_free = 1; % Why? Biostats Handbook says so?
    p_val = 1-chi2cdf(ch_val, deg_free); % According to the internet = Equivalent of Chidist in excel


end