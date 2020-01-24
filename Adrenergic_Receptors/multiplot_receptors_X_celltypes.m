function rslt = multiplot_receptors_X_celltypes( immunostruct )
    
    avgs_stes = get_avgs_stes( immunostruct );
    
    A1AR_Excit = [avgs_stes.A1AR_Nrg.mean, avgs_stes.A1AR_RatPyr.mean, avgs_stes.A1AR_SMI32.mean ];
    A1AR_Excit_ste = [avgs_stes.A1AR_Nrg.ste, avgs_stes.A1AR_RatPyr.ste, avgs_stes.A1AR_SMI32.ste ];
    A1AR_Inhib = [avgs_stes.A1AR_Parv.mean, avgs_stes.A1AR_Calb.mean, avgs_stes.A1AR_Calr.mean, avgs_stes.A1AR_Som.mean ];
    A1AR_Inhib_ste = [avgs_stes.A1AR_Parv.ste, avgs_stes.A1AR_Calb.ste, avgs_stes.A1AR_Calr.ste, avgs_stes.A1AR_Som.ste ];
    
    A2AR_Excit = [avgs_stes.A2AR_Nrg.mean, avgs_stes.A2AR_RatPyr.mean, avgs_stes.A2AR_SMI32.mean ];
    A2AR_Excit_ste = [avgs_stes.A2AR_Nrg.ste, avgs_stes.A2AR_RatPyr.ste, avgs_stes.A2AR_SMI32.ste ];
    A2AR_Inhib = [avgs_stes.A2AR_Parv.mean, avgs_stes.A2AR_Calb.mean, avgs_stes.A2AR_Calr.mean, avgs_stes.A2AR_Som.mean ];
    A2AR_Inhib_ste = [avgs_stes.A2AR_Parv.ste, avgs_stes.A2AR_Calb.ste, avgs_stes.A2AR_Calr.ste, avgs_stes.A2AR_Som.ste ];

    B1R_Excit = [avgs_stes.B1R_Nrg.mean, avgs_stes.B1R_RatPyr.mean, avgs_stes.B1R_SMI32.mean ];
    B1R_Excit_ste = [avgs_stes.B1R_Nrg.ste, avgs_stes.B1R_RatPyr.ste, avgs_stes.B1R_SMI32.ste ];
    B1R_Inhib = [avgs_stes.B1R_Parv.mean, avgs_stes.B1R_Calb.mean, avgs_stes.B1R_Calr.mean, avgs_stes.B1R_Som.mean ];
    B1R_Inhib_ste = [avgs_stes.B1R_Parv.ste, avgs_stes.B1R_Calb.ste, avgs_stes.B1R_Calr.ste, avgs_stes.B1R_Som.ste ];

    B2R_Excit = [avgs_stes.B2R_Nrg.mean, avgs_stes.B2R_RatPyr.mean, avgs_stes.B2R_SMI32.mean ];
    B2R_Excit_ste = [avgs_stes.B2R_Nrg.ste, avgs_stes.B2R_RatPyr.ste, avgs_stes.B2R_SMI32.ste ];
    B2R_Inhib = [avgs_stes.B2R_Parv.mean, avgs_stes.B2R_Calb.mean, avgs_stes.B2R_Calr.mean, avgs_stes.B2R_Som.mean ];
    B2R_Inhib_ste = [avgs_stes.B2R_Parv.ste, avgs_stes.B2R_Calb.ste, avgs_stes.B2R_Calr.ste, avgs_stes.B2R_Som.ste ];

    
    % Plot
    figure(); 
    y = [A1AR_Excit; A2AR_Excit; B1R_Excit; B2R_Excit]';
    b = bar( y );
    
    %lb_col = [0.76 0.88 0.92]; db_col = [0.32 0.68 0.80];
    %lg_col = [0.79 0.94 0.82]; dg_col = [0.56 0.87 0.63];
    %b(1).FaceColor = lb_col; b(2).FaceColor = db_col;
    %b(3).FaceColor = lg_col; b(4).FaceColor = dg_col;
    

    ylim( [0 120] ); set(gca, 'ytick', [0:20:100]);
    %set(gca,'XTickLabel',{'SMI-32','Neurogranin'});
    set(gca,'XTickLabel',{'Neurogranin', 'Rat Pyramidal', 'SMI-32'});
    ylabel( {'% of Neurons with'; 'Receptor Type'}, 'FontSize', 12, 'FontWeight', 'bold' );
    set(gca,'FontSize',10, 'FontWeight', 'bold');
    legend( 'Alpha1AR', 'Alpha2AR', 'Beta1R', 'Beta2R');
    saveas( gcf, 'ExcitatoryCounts', 'png' );

    
%     % P-Values and Significance Plots 
%     %ctr2 = bsxfun(@plus, b(2).XData, [b(2).XOffset]');
%     D1R_SMI32_cell_mat = gen_CMH_cell_mat( immuno_struct, 'D1RD2R', 'SMI-32' );
%     % D1R_SMI32_pval = cochran_mantel_haenszel_test( D1R_SMI32_cell_mat, 1 );
%     D1R_SMI32_pval  = general_chi_sq_test( D1R_SMI32_cell_mat );
%     
%     D1R_NRG_cell_mat = gen_CMH_cell_mat( immuno_struct, 'D1RD2R', 'Neurogranin' );
%     %D1R_NRG_pval = cochran_mantel_haenszel_test( D1R_NRG_cell_mat, 1 );
%     D1R_NRG_pval  = general_chi_sq_test( D1R_NRG_cell_mat );
%     
%     hold on;
%     err_x1 = b(1).XData + b(1).XOffset;
%     err_x2 = b(2).XData + b(2).XOffset;
%     errorbar( err_x1, D1R_Excit, D1R_Excit_ste, 'k', 'linestyle', 'none' );
%     errorbar( err_x2, D2R_Excit, D2R_Excit_ste, 'k', 'linestyle', 'none' );
%     hold off;
% 
%     xpos1 = [b(1).XData(1) + b(1).XOffset, b(1).XData(1) + b(2).XOffset];
%     xpos2 = [b(1).XData(2) + b(1).XOffset, b(1).XData(2) + b(2).XOffset];
%     sigstar( {xpos1, xpos2}, [D1R_SMI32_pval, D1R_NRG_pval]);    
%     
%     legend( b, 'D1R', 'D2R', 'Location', 'northwest');
%     set(gcf, 'Units', 'centimeters' );
%     set(gcf, 'Position', [30, 30, 8.6, 7.2])
%     set(gca, 'box', 'off' );
%     tightfig( gcf );
%     resize_paper_for_pdf( gcf );
%     save_out_fig( gcf, strcat('Fig2_D1R_D2R_Excitatory_Proportions') );
    
    figure();
    b = bar( [A1AR_Inhib; A2AR_Inhib; B1R_Inhib; B2R_Inhib]' ); 
    % b(1).FaceColor = 'k'; b(2).FaceColor = gray_col;
    ylim( [0 120] ); set(gca, 'ytick', [0:20:100]);
    set(gca,'XTickLabel',{'Parvalbumin','Calbindin', 'Calretinin', 'Somatostatin'});
    ylabel( {'% of Neurons with'; 'Receptor Type'}, 'FontSize', 12, 'FontWeight', 'bold' );
    set(gca,'XTickLabelRotation',45);
    set(gca,'FontSize',10, 'FontWeight', 'bold');
    legend( 'Alpha1AR', 'Alpha2AR', 'Beta1R', 'Beta2R');
    
    saveas( gcf, 'InhibitoryCounts', 'png' );

    
    % Get P- values
%     celltype_list = {'Parvalbumin','Calbindin', 'Calretinin', 'Somatostatin'};
%     pval_list = [];
%     for i = 1:length(celltype_list)
%         cell_mat = gen_CMH_cell_mat( immuno_struct, 'D1RD2R', celltype_list(i) );
%         %pval_list(i) = cochran_mantel_haenszel_test( cell_mat, 1 );
%         pval_list(i) = general_chi_sq_test( cell_mat );
%     end
%     
%     
%     hold on;
%     err_x1 = b(1).XData + b(1).XOffset;
%     err_x2 = b(2).XData + b(2).XOffset;
%     errorbar( err_x1, D1R_Inhib, D1R_Inhib_ste, 'k', 'linestyle', 'none' );
%     errorbar( err_x2, D2R_Inhib, D2R_Inhib_ste, 'k', 'linestyle', 'none' );
%     hold off;
%     
%     
%     %Figure out how to do cellfun for this
%     xpos1 = [b(1).XData(1) + b(1).XOffset, b(1).XData(1) + b(2).XOffset];
%     xpos3 = [b(1).XData(3) + b(1).XOffset, b(1).XData(3) + b(2).XOffset];
%     xpos4 = [b(1).XData(4) + b(1).XOffset, b(1).XData(4) + b(2).XOffset];
%     xpos5 = [b(1).XData(5) + b(1).XOffset, b(1).XData(5) + b(2).XOffset];
%     sigstar( {xpos1, xpos3, xpos4, xpos5}, pval_list);
%     
%     legend( b, 'D1R', 'D2R', 'Location', 'northwest');
%     set(gcf, 'Units', 'centimeters' );
%     set(gcf, 'Position', [30, 30, 8.6, 7.2])
%     set(gca, 'box', 'off' );
%     tightfig( gcf );
%     resize_paper_for_pdf( gcf );
%     save_out_fig( gcf, strcat('Fig5_D1R_D2R_Inhibitory_Proportions') );
%     
end

function rslt = get_avgs_stes( immunostruct )
    rslt.A1AR_NeuN   = avg_X_animals( immunostruct, 'Alpha1AR', 'NeuN', 'FEF' );
    rslt.A1AR_Nrg    = avg_X_animals( immunostruct, 'Alpha1AR', 'Neurogranin', 'FEF' );
    rslt.A1AR_SMI32  = avg_X_animals( immunostruct, 'Alpha1AR', 'SMI-32', 'FEF' );
    rslt.A1AR_RatPyr = avg_X_animals( immunostruct, 'Alpha1AR', 'Rat-Pyramidal', 'FEF' );
    rslt.A1AR_Parv   = avg_X_animals( immunostruct, 'Alpha1AR', 'Parvalbumin', 'FEF' );
    rslt.A1AR_Calb   = avg_X_animals( immunostruct, 'Alpha1AR', 'Calbindin', 'FEF' );
    rslt.A1AR_Calr   = avg_X_animals( immunostruct, 'Alpha1AR', 'Calretinin', 'FEF' );
    rslt.A1AR_Som    = avg_X_animals( immunostruct, 'Alpha1AR', 'Somatostatin', 'FEF' );

    rslt.A2AR_NeuN   = avg_X_animals( immunostruct, 'Alpha2AR', 'NeuN', 'FEF' );
    rslt.A2AR_Nrg    = avg_X_animals( immunostruct, 'Alpha2AR', 'Neurogranin', 'FEF' );
    rslt.A2AR_SMI32  = avg_X_animals( immunostruct, 'Alpha2AR', 'SMI-32', 'FEF' );
    rslt.A2AR_RatPyr = avg_X_animals( immunostruct, 'Alpha2AR', 'Rat-Pyramidal', 'FEF' );
    rslt.A2AR_Parv   = avg_X_animals( immunostruct, 'Alpha2AR', 'Parvalbumin', 'FEF' );
    rslt.A2AR_Calb   = avg_X_animals( immunostruct, 'Alpha2AR', 'Calbindin', 'FEF' );
    rslt.A2AR_Calr   = avg_X_animals( immunostruct, 'Alpha2AR', 'Calretinin', 'FEF' );
    rslt.A2AR_Som    = avg_X_animals( immunostruct, 'Alpha2AR', 'Somatostatin', 'FEF' );

    rslt.B1R_NeuN   = avg_X_animals( immunostruct, 'Beta1R', 'NeuN', 'FEF' );
    rslt.B1R_Nrg    = avg_X_animals( immunostruct, 'Beta1R', 'Neurogranin', 'FEF' );
    rslt.B1R_SMI32  = avg_X_animals( immunostruct, 'Beta1R', 'SMI-32', 'FEF' );
    rslt.B1R_RatPyr = avg_X_animals( immunostruct, 'Beta1R', 'Rat-Pyramidal', 'FEF' );
    rslt.B1R_Parv   = avg_X_animals( immunostruct, 'Beta1R', 'Parvalbumin', 'FEF' );
    rslt.B1R_Calb   = avg_X_animals( immunostruct, 'Beta1R', 'Calbindin', 'FEF' );
    rslt.B1R_Calr   = avg_X_animals( immunostruct, 'Beta1R', 'Calretinin', 'FEF' );
    rslt.B1R_Som    = avg_X_animals( immunostruct, 'Beta1R', 'Somatostatin', 'FEF' );

    rslt.B2R_NeuN   = avg_X_animals( immunostruct, 'Beta2R', 'NeuN', 'FEF' );
    rslt.B2R_Nrg    = avg_X_animals( immunostruct, 'Beta2R', 'Neurogranin', 'FEF' );
    rslt.B2R_SMI32  = avg_X_animals( immunostruct, 'Beta2R', 'SMI-32', 'FEF' );
    rslt.B2R_RatPyr = avg_X_animals( immunostruct, 'Beta2R', 'Rat-Pyramidal', 'FEF' );
    rslt.B2R_Parv   = avg_X_animals( immunostruct, 'Beta2R', 'Parvalbumin', 'FEF' );
    rslt.B2R_Calb   = avg_X_animals( immunostruct, 'Beta2R', 'Calbindin', 'FEF' );
    rslt.B2R_Calr   = avg_X_animals( immunostruct, 'Beta2R', 'Calretinin', 'FEF' );
    rslt.B2R_Som    = avg_X_animals( immunostruct, 'Beta2R', 'Somatostatin', 'FEF' );
end