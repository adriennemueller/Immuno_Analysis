function rslt = get_pval_string( pvals, bonf_val )
    rslt = {};
    for i = 1:length( pvals )
       if pvals(i) <= 0.001/bonf_val;
           rslt{i} = '***';
       elseif pvals(i) <= 0.01/bonf_val;
           rslt{i} = '**';
       elseif pvals(i) <= 0.05/bonf_val; 
           rslt{i} = '*';
       else
           rslt{i} = []; 
       end        
    end
end