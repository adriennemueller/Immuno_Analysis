function save_out_fig( fig_h, fig_label )

    direc = '/Volumes/Olaf/Papers/D5R Frontiers/Figures';

    ext_list = {'fig', 'eps', 'pdf'};
    
    for i = 1:length(ext_list)
        file_string = strcat( direc, '/', fig_label, '.', ext_list(i) );
        saveas( fig_h, file_string{1} );
    end

end