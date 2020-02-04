% Create Mean, STE, N Table
function rslt = mean_ste_n_table( immuno_struct )

    avg_struct = get_avgs_stes( immuno_struct );
    
    %s_fields = fieldnames( avg_struct );
    
    receptors = {'A1AR', 'A2AR', 'B1R', 'B2R'};
    celltypes = {'Nrg', 'RatPyr', 'SMI32', 'Parv', 'Calb', 'Calr', 'Som'};
    
    
    % Loop through Receptors
    for i = 1:length( celltypes )
        
        row = [];
        for j = 1:length( receptors )
       
            curr_field = strcat( receptors(j), '_', celltypes(i) );
            curr_field = curr_field{1};
            
            
            curr_row = [avg_struct.(curr_field).mean avg_struct.(curr_field).ste avg_struct.(curr_field).total_n];
            row = horzcat( row, curr_row );
            
        end
        
        rslt(i,:) = row;
    end

end