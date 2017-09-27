% Assumes a matrix 2 by 2 by k matrix with k = number of experiments. e.g.

% k = 1      Co-Parv+    Parv+ Only
% Benny D1R    77          139
%       D2R   150           40


% k = 2      Co-Parv+    Parv+ Only    
% Marilyn D1R  45          88 
%         D2R 200          30


function p = chi_sq_test( data_mat )

    %[m n k] = size( cell_mat );

    Cat1_CO = sum(data_mat(1,1,:)); Cat1_CT = sum(data_mat(1,2,:));
    Cat2_CO = sum(data_mat(2,1,:)); Cat2_CT = sum(data_mat(2,2,:));

    % Pooled estimate of proportion
    p0 = (Cat1_CO + Cat2_CO) / (Cat1_CT + Cat2_CT);

    % Expected counts under H0 (null hypothesis)
    Cat1_H0 = Cat1_CT * p0;
    Cat2_H0 = Cat2_CT * p0;
    
    % Chi-square test, by hand
    observed = [Cat1_CO Cat1_CT-Cat1_CO Cat2_CO Cat2_CT-Cat2_CO];
    expected = [Cat1_H0 Cat1_CT-Cat1_H0 Cat2_H0 Cat2_CT-Cat2_H0];
    
    chi2stat = sum((observed-expected).^2 ./ expected);
    p = 1 - chi2cdf(chi2stat,1);
    
    % [h,p,stats] = chi2gof([1 2 3 4],'freq',observed,'expected',expected,'ctrs',[1 2 3 4],'nparams',2)
end

