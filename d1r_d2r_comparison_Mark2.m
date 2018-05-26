% D1R, D2R Quantificaton
% Two Plots: Excitatory and Inhibiory.
function rslt = d1r_d2r_comparison_Mark2( immuno_struct )

    % Extract averages for each element across animals

    rslt.D1R_SMI32 = avg_X_animals( immuno_struct, 'D1R', 'SMI-32', 'FEF' );
    rslt.D1R_NRG   = avg_X_animals( immuno_struct, 'D1R', 'Neurogranin', 'FEF' );
    
    rslt.D2R_SMI32 = avg_X_animals( immuno_struct, 'D2R', 'SMI-32', 'FEF' );
    rslt.D2R_NRG   = avg_X_animals( immuno_struct, 'D2R', 'Neurogranin', 'FEF' );
    
    rslt.D1R_Parv  = avg_X_animals( immuno_struct, 'D1R', 'Parvalbumin', 'FEF' );
    rslt.D1R_Calb  = avg_X_animals( immuno_struct, 'D1R', 'Calbindin', 'FEF' );
    rslt.D1R_Calr  = avg_X_animals( immuno_struct, 'D1R', 'Calretinin', 'FEF' );
    rslt.D1R_Som   = avg_X_animals( immuno_struct, 'D1R', 'Somatostatin', 'FEF' );
    rslt.D1R_Inhib = avg_X_animals( immuno_struct, 'D1R', 'Inhibitory', 'FEF' );
    
    rslt.D2R_Parv  = avg_X_animals( immuno_struct, 'D2R', 'Parvalbumin', 'FEF' );
    rslt.D2R_Calb  = avg_X_animals( immuno_struct, 'D2R', 'Calbindin', 'FEF' );
    rslt.D2R_Calr  = avg_X_animals( immuno_struct, 'D2R', 'Calretinin', 'FEF' );
    rslt.D2R_Som   = avg_X_animals( immuno_struct, 'D2R', 'Somatostatin', 'FEF' );
    rslt.D2R_Inhib = avg_X_animals( immuno_struct, 'D2R', 'Inhibitory', 'FEF' );
    
    D1R_Excit = [rslt.D1R_NRG rslt.D1R_SMI32];
    D2R_Excit = [rslt.D2R_NRG rslt.D2R_SMI32];
    D1R_Inhib = [rslt.D1R_Inhib 0 rslt.D1R_Parv rslt.D1R_Calb rslt.D1R_Calr rslt.D1R_Som ];
    D2R_Inhib = [rslt.D2R_Inhib 0 rslt.D2R_Parv rslt.D2R_Calb rslt.D2R_Calr rslt.D2R_Som ];
    
    % Plot
    figure(); gray_col = [0.8 0.8 0.8];
    y = [D1R_Excit; D2R_Excit]';
    b = bar( y ); b(1).FaceColor = 'k'; b(2).FaceColor = gray_col;
    ylim( [0 120] ); set(gca, 'ytick', [0:20:100]);
    %set(gca,'XTickLabel',{'SMI-32','Neurogranin'});
    set(gca,'XTickLabel',{'Neurogranin','SMI-32'});
    ylabel( {'% of Neurons with'; 'Receptor Type'}, 'FontSize', 12, 'FontWeight', 'bold' );
    set(gca,'FontSize',10, 'FontWeight', 'bold');
    %legend( 'D1R', 'D2R');
    
    
    % P-Values and Significance Plots 
    %ctr2 = bsxfun(@plus, b(2).XData, [b(2).XOffset]');
    D1R_SMI32_cell_mat = gen_CMH_cell_mat( immuno_struct, 'D1RD2R', 'SMI-32' );
    % D1R_SMI32_pval = cochran_mantel_haenszel_test( D1R_SMI32_cell_mat, 1 );
    D1R_SMI32_pval  = general_chi_sq_test( D1R_SMI32_cell_mat );
    
    D1R_NRG_cell_mat = gen_CMH_cell_mat( immuno_struct, 'D1RD2R', 'Neurogranin' );
    %D1R_NRG_pval = cochran_mantel_haenszel_test( D1R_NRG_cell_mat, 1 );
    D1R_NRG_pval  = general_chi_sq_test( D1R_NRG_cell_mat );
    
    xpos1 = [b(1).XData(1) + b(1).XOffset, b(1).XData(1) + b(2).XOffset];
    xpos2 = [b(1).XData(2) + b(1).XOffset, b(1).XData(2) + b(2).XOffset];
    sigstar( {xpos1, xpos2}, [D1R_SMI32_pval, D1R_NRG_pval]);    
    
    legend( b, 'D1R', 'D2R', 'Location', 'northwest');
    set(gcf, 'Units', 'centimeters' );
    set(gcf, 'Position', [30, 30, 8.6, 7.2])
    set(gca, 'box', 'off' );
    tightfig( gcf );
    resize_paper_for_pdf( gcf );
    save_out_fig( gcf, strcat('Fig2_D1R_D2R_Excitatory_Proportions') );
    
    figure();
    b = bar( [D1R_Inhib; D2R_Inhib]' ); b(1).FaceColor = 'k'; b(2).FaceColor = gray_col;
    ylim( [0 100] ); set(gca, 'ytick', [0:20:100]);
    set(gca,'XTickLabel',{'All Inhibitory', ' ', 'Parvalbumin','Calbindin', 'Calretinin', 'Somatostatin'});
    ylabel( {'% of Neurons with'; 'Receptor Type'}, 'FontSize', 12, 'FontWeight', 'bold' );
    set(gca,'XTickLabelRotation',45);
    set(gca,'FontSize',10, 'FontWeight', 'bold');
    
    % Get P- values
    celltype_list = {'Inhibitory', 'Parvalbumin','Calbindin', 'Calretinin'};
    pval_list = [];
    for i = 1:length(celltype_list)
        cell_mat = gen_CMH_cell_mat( immuno_struct, 'D1RD2R', celltype_list(i) );
        %pval_list(i) = cochran_mantel_haenszel_test( cell_mat, 1 );
        pval_list(i) = general_chi_sq_test( cell_mat );
    end
    
    %Figure out how to do cellfun for this
    xpos1 = [b(1).XData(1) + b(1).XOffset, b(1).XData(1) + b(2).XOffset];
    xpos3 = [b(1).XData(3) + b(1).XOffset, b(1).XData(3) + b(2).XOffset];
    xpos4 = [b(1).XData(4) + b(1).XOffset, b(1).XData(4) + b(2).XOffset];
    xpos5 = [b(1).XData(5) + b(1).XOffset, b(1).XData(5) + b(2).XOffset];
    sigstar( {xpos1, xpos3, xpos4, xpos5}, pval_list);
    
    legend( b, 'D1R', 'D2R', 'Location', 'northwest');
    set(gcf, 'Units', 'centimeters' );
    set(gcf, 'Position', [30, 30, 8.6, 7.2])
    set(gca, 'box', 'off' );
    tightfig( gcf );
    resize_paper_for_pdf( gcf );
    save_out_fig( gcf, strcat('Fig5_D1R_D2R_Inhibitory_Proportions') );

end