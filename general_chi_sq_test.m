% Assumes a matrix m by n by k matrix with k = number of experiments. e.g.

% k = 1      Co-Parv+    Parv+ Only
% Benny D1R    77          139
%       D2R   150           40


% k = 2      Co-Parv+    Parv+ Only    
% Marilyn D1R  45          88 
%         D2R 200          30

function p = general_chi_sq_test( data_mat )

    % Collapse K dimension, if exists
    numDims = ndims( data_mat );
    if numDims == 3
        data_mat = sum( data_mat, 3);
    end
    
    % Row Marginal
    rm = sum(data_mat,2);
    
    % Column Marginal
    cm = sum(data_mat,1);
    
    total = sum(data_mat(:));
    
    expecteds = (rm * cm) ./ total; % Same dimensions as observed.

    ObsExpTmp = (abs( data_mat - expecteds )) .^ 2;
    ObsExpFinal = ObsExpTmp ./ expecteds;
    
    chsq_val = sum(ObsExpFinal(:));
    
    [m, n] = size(data_mat);
    df = (m - 1) * (n - 1);
    
    p = 1 - chi2cdf(chsq_val, df);

end