% D5R plot - show bar plot of D5R on different cell types, NeuN and others.
% D1R, D2R Quantificaton
% Four subplots, Top Left = D1R on pyr; Top Right = D2R on pyr; Bottom Left D1R on Inhbitory Neurons; Bottom Right: D2R on inhibitory neurons 

function rslt = d5r_plot( immuno_struct )

    TickLabel_FontSize = 14;
    AxisLabel_FontSize = 18;

    % Extract averages for each element across animals

    D5R_NeuN  = avg_X_animals( immuno_struct, 'D5R', 'NeuN', 'FEF' );
    D5R_SMI32 = avg_X_animals( immuno_struct, 'D5R', 'SMI-32', 'FEF' );
    D5R_NRG   = avg_X_animals( immuno_struct, 'D5R', 'Neurogranin', 'FEF' );
    D5R_Inhib = avg_X_animals( immuno_struct, 'D5R', 'Inhibitory', 'FEF' );
    D5R_Parv  = avg_X_animals( immuno_struct, 'D5R', 'Parvalbumin', 'FEF' );
    D5R_Calb  = avg_X_animals( immuno_struct, 'D5R', 'Calbindin', 'FEF' );
    D5R_Calr  = avg_X_animals( immuno_struct, 'D5R', 'Calretinin', 'FEF' );
    D5R_Som   = avg_X_animals( immuno_struct, 'D5R', 'Somatostatin', 'FEF' );
    
    % Plot
    figure();
    set(gcf, 'Position', [100, 100, 500, 1100])
    
    subplot( 2,1,1)
    bar( [D5R_NRG/100 D5R_SMI32/100], 'w' );       
    ylim( [0 1] ); set(gca, 'ytick', [0:0.2:1]);
    set(gca,'XTickLabel',{'Neurogranin', 'SMI-32'}, 'FontSize', TickLabel_FontSize, 'FontWeight', 'bold');
    ylabel( 'Proportion of Neurons Expressing D5R', 'FontSize', AxisLabel_FontSize, 'FontWeight', 'bold' );
    xlabel( '', 'FontSize', AxisLabel_FontSize );
    box(gca,'off');
    set(gca,'XTickLabelRotation',45);
    
    D5R_PYR_cell_mat = gen_CMH_cell_mat( immuno_struct, 'D5R', 'PYR' );
    %D5R_PYR_pval = cochran_mantel_haenszel_test( D5R_PYR_cell_mat, 1 )
    D5R_PYR_ChSq_pval = general_chi_sq_test( D5R_PYR_cell_mat );
    sigstar( {{'SMI-32','Neurogranin'}}, D5R_PYR_ChSq_pval);    
        
    
    subplot( 2,1,2)
    bar( [D5R_Inhib/100 0 D5R_Parv/100 D5R_Calb/100 D5R_Calr/100 D5R_Som/100], 'k' );       
    ylim( [0 1] ); set(gca, 'ytick', [0:0.2:1]);
    set(gca,'XTickLabel',{'Inhibitory', '', 'Parvalbumin','Calbindin', 'Calretinin', 'Somatostatin'}, ...
        'FontSize', TickLabel_FontSize, 'FontWeight', 'bold');
    ylabel( 'Proportion of Neurons Expressing D5R', 'FontSize', AxisLabel_FontSize, 'FontWeight', 'bold' );
    xlabel( '', 'FontSize', AxisLabel_FontSize );
    box(gca,'off');
    set(gca,'XTickLabelRotation',45);
    

    
    D5R_Inhib1_cell_mat = gen_CMH_cell_mat( immuno_struct, 'D5R', 'ParvCalb' );
    D5R_Inhib1_ChSq_pval = general_chi_sq_test( D5R_Inhib1_cell_mat );
    
    D5R_Inhib2_cell_mat = gen_CMH_cell_mat( immuno_struct, 'D5R', 'CalbCalr' );
    D5R_Inhib2_ChSq_pval = general_chi_sq_test( D5R_Inhib2_cell_mat );
    
    D5R_Inhib3_cell_mat = gen_CMH_cell_mat( immuno_struct, 'D5R', 'CalrParv' );
    D5R_Inhib3_ChSq_pval = general_chi_sq_test( D5R_Inhib3_cell_mat );
    
    % NRG vs Inhibs
    D5R_NRGInhib_cell_mat = gen_CMH_cell_mat( immuno_struct, 'D5R', 'NRGInhib' );
    D5R_NRGInhib_ChSq_pval = general_chi_sq_test( D5R_NRGInhib_cell_mat );
    
    D5R_NRGParv_cell_mat = gen_CMH_cell_mat( immuno_struct, 'D5R', 'NRGParv' );
    D5R_NRGParv_ChSq_pval = general_chi_sq_test( D5R_NRGParv_cell_mat );
    
    D5R_NRGCalb_cell_mat = gen_CMH_cell_mat( immuno_struct, 'D5R', 'NRGCalb' );
    D5R_NRGCalb_ChSq_pval = general_chi_sq_test( D5R_NRGCalb_cell_mat );
    
    D5R_NRGCalr_cell_mat = gen_CMH_cell_mat( immuno_struct, 'D5R', 'NRGCalr' );
    D5R_NRGCalr_ChSq_pval = general_chi_sq_test( D5R_NRGCalr_cell_mat );
    
    D5R_NRGSom_cell_mat = gen_CMH_cell_mat( immuno_struct, 'D5R', 'NRGSom' );
    D5R_NRGSom_cell_mat = round(sum( D5R_NRGSom_cell_mat, 3));
    [h_ignore D5R_NRGSom_ChSq_pval stats_ignore] = fishertest( D5R_NRGSom_cell_mat );
    
    sigstar( {{'Parvalbumin','Calbindin'}, {'Calbindin', 'Calretinin'}, {'Calretinin', 'Parvalbumin'}}, [D5R_Inhib1_ChSq_pval D5R_Inhib2_ChSq_pval, D5R_Inhib3_ChSq_pval]);

    tightfig( gcf );
    resize_paper_for_pdf( gcf );

end

