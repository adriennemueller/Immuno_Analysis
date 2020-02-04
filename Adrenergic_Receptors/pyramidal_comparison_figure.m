function pyr_fig = pyramidal_comparison_figure( immuno_struct )

    avgs_stes = get_avgs_stes( immuno_struct );
    
    A1AR_Excit = [avgs_stes.A1AR_Nrg.mean, avgs_stes.A1AR_RatPyr.mean, avgs_stes.A1AR_SMI32.mean ];
    A1AR_Excit_ste = [avgs_stes.A1AR_Nrg.ste, avgs_stes.A1AR_RatPyr.ste, avgs_stes.A1AR_SMI32.ste ];
    
    A2AR_Excit = [avgs_stes.A2AR_Nrg.mean, avgs_stes.A2AR_RatPyr.mean, avgs_stes.A2AR_SMI32.mean ];
    A2AR_Excit_ste = [avgs_stes.A2AR_Nrg.ste, avgs_stes.A2AR_RatPyr.ste, avgs_stes.A2AR_SMI32.ste ];
 
    B1R_Excit = [avgs_stes.B1R_Nrg.mean, avgs_stes.B1R_RatPyr.mean, avgs_stes.B1R_SMI32.mean ];
    B1R_Excit_ste = [avgs_stes.B1R_Nrg.ste, avgs_stes.B1R_RatPyr.ste, avgs_stes.B1R_SMI32.ste ];
 
    B2R_Excit = [avgs_stes.B2R_Nrg.mean, avgs_stes.B2R_RatPyr.mean, avgs_stes.B2R_SMI32.mean ];
    B2R_Excit_ste = [avgs_stes.B2R_Nrg.ste, avgs_stes.B2R_RatPyr.ste, avgs_stes.B2R_SMI32.ste ];
 
    
    % Plot
    figure(); 
    
    y = [A1AR_Excit; A2AR_Excit; B1R_Excit; B2R_Excit];
    b = bar( y );
    hold on;
     
    % P-Values 
    A1R_RP_SMI32_cell_mat = gen_CMH_cell_mat( immuno_struct, 'Alpha1AR', 'RatPyr_SMI32' );
    A1R_RP_SMI32_cell_mat_pval  = general_chi_sq_test( A1R_RP_SMI32_cell_mat );
    A1R_NRG_SMI32_cell_mat = gen_CMH_cell_mat( immuno_struct, 'Alpha1AR', 'NRG_SMI32' );
    A1R_NRG_SMI32_cell_mat_pval  = general_chi_sq_test( A1R_NRG_SMI32_cell_mat );

    A2R_RP_SMI32_cell_mat = gen_CMH_cell_mat( immuno_struct, 'Alpha2AR', 'RatPyr_SMI32' );
    A2R_RP_SMI32_cell_mat_pval  = general_chi_sq_test( A2R_RP_SMI32_cell_mat );
    A2R_NRG_SMI32_cell_mat = gen_CMH_cell_mat( immuno_struct, 'Alpha2AR', 'NRG_SMI32' );
    A2R_NRG_SMI32_cell_mat_pval  = general_chi_sq_test( A2R_NRG_SMI32_cell_mat );
     
    B1R_RP_SMI32_cell_mat = gen_CMH_cell_mat( immuno_struct, 'Beta1R', 'RatPyr_SMI32' );
    B1R_RP_SMI32_cell_mat_pval  = general_chi_sq_test( B1R_RP_SMI32_cell_mat );
    B1R_NRG_SMI32_cell_mat = gen_CMH_cell_mat( immuno_struct, 'Beta1R', 'NRG_SMI32' );
    B1R_NRG_SMI32_cell_mat_pval  = general_chi_sq_test( B1R_NRG_SMI32_cell_mat );
     
    B2R_RP_SMI32_cell_mat = gen_CMH_cell_mat( immuno_struct, 'Beta2R', 'RatPyr_SMI32' );
    B2R_RP_SMI32_cell_mat_pval  = general_chi_sq_test( B2R_RP_SMI32_cell_mat );
    B2R_NRG_SMI32_cell_mat = gen_CMH_cell_mat( immuno_struct, 'Beta2R', 'NRG_SMI32' );
    B2R_NRG_SMI32_cell_mat_pval  = general_chi_sq_test( B2R_NRG_SMI32_cell_mat );

    RP_pval_list = [A1R_RP_SMI32_cell_mat_pval, A2R_RP_SMI32_cell_mat_pval, ...
                    B1R_RP_SMI32_cell_mat_pval, B2R_RP_SMI32_cell_mat_pval];
             
    RP_pval_list = RP_pval_list .* 8; % Bonferonni correction
    
    NRG_pval_list = [A1R_NRG_SMI32_cell_mat_pval, A2R_NRG_SMI32_cell_mat_pval, ...
                     B1R_NRG_SMI32_cell_mat_pval, B2R_NRG_SMI32_cell_mat_pval];
             
    NRG_pval_list = NRG_pval_list .* 8; % Bonferonni correction
    
    
    % Addition of Pvals to Plot
    rp_xpos1 = [b(1).XData(1) + b(1).XOffset, b(1).XData(1) + b(3).XOffset];
    rp_xpos2 = [b(1).XData(2) + b(1).XOffset, b(1).XData(2) + b(3).XOffset];
    rp_xpos3 = [b(1).XData(3) + b(1).XOffset, b(1).XData(3) + b(3).XOffset];
    rp_xpos4 = [b(1).XData(4) + b(1).XOffset, b(1).XData(4) + b(3).XOffset];
    sigstar( {rp_xpos1, rp_xpos2, rp_xpos3, rp_xpos4}, RP_pval_list);    

    nrg_xpos1 = [b(1).XData(1) + b(2).XOffset, b(1).XData(1) + b(3).XOffset];
    nrg_xpos2 = [b(1).XData(2) + b(2).XOffset, b(1).XData(2) + b(3).XOffset];
    nrg_xpos3 = [b(1).XData(3) + b(2).XOffset, b(1).XData(3) + b(3).XOffset];
    nrg_xpos4 = [b(1).XData(4) + b(2).XOffset, b(1).XData(4) + b(3).XOffset];
    sigstar( {nrg_xpos1, nrg_xpos2, nrg_xpos3, nrg_xpos4}, NRG_pval_list);    

    for i = 1:4
        for j = 1:3
            b(j).FaceColor = 'flat';
            b(j).CData(i,:) = get_bar_facecolor( 'excit', i );
        end
    end
    
    %lb_col = [0.76 0.88 0.92]; db_col = [0.32 0.68 0.80];
    %lg_col = [0.79 0.94 0.82]; dg_col = [0.56 0.87 0.63];
    %b(1).FaceColor = lb_col; b(2).FaceColor = db_col;
    %b(3).FaceColor = lg_col; b(4).FaceColor = dg_col;

    ylim( [0 130] ); set(gca, 'ytick', [0:20:100]);
    set(gca,'XTickLabel',{'Alpha1AR', 'Alpha2AR', 'Beta1R', 'Beta2R'});
    ylabel( {'% of Neurons with'; 'Receptor Type'}, 'FontSize', 12, 'FontWeight', 'bold' );
    set(gca,'FontSize',10, 'FontWeight', 'bold');

    
    legend('Neurogranin', 'Rat Pyramidal', 'SMI-32' );

    set(gcf, 'Units', 'centimeters' );
    %set(gcf, 'Position', [30, 30, 8.6, 7.2])
    set(gca, 'box', 'off' );
    tightfig( gcf );
    resize_paper_for_pdf( gcf );
    save_out_fig( gcf, strcat('Adrenergic_Excitatory_Proportions') );

end

