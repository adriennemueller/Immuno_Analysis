% 4 points - 
    % 1: bottom of layer 1
    % 2: bottom of layer 2-3
    % 3: bottom of putative layer 4
    % 4: bottom of layer 5
    % 5: optional bottom of layer 6
function rslt = load_layerdepthCSV( filename ) %%% NEED THIS TO BE FULL FILE PATH!!!

    columns = {'Area', 'Mean', 'Min', 'Max', 'X', 'Y', 'Ch'};
    csv_data = csvimport( filename, 'columns', columns, 'delimiter', ',' );
    %Y_idx = find(strcmp('Y', columns));
    %rslt = csv_data( :, Y_idx );
    X_idx = find(strcmp('X', columns));
    rslt = csv_data( :, X_idx );

end



