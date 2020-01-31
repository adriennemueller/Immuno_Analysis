function beta1_comparison( immuno_struct )

    avgs_stes = get_avgs_stes( immuno_struct );

    %%% Beta1 Comparison - across inhib neuron types %%%
    B1R_Inhib = [avgs_stes.B1R_Parv.mean, avgs_stes.B1R_Calb.mean, avgs_stes.B1R_Calr.mean ];
    B1R_Inhib_ste = [avgs_stes.B1R_Parv.ste, avgs_stes.B1R_Calb.ste, avgs_stes.B1R_Calr.ste ];
       
    % Plot
    figure(); 
    
    cmp = colormap(lines(4));    
    yellow_col = cmp(3,:);
    b1_inhib = bar( B1R_Inhib, 'FaceColor', yellow_col );
    hold on;
     
    % P-Values 
    B1R_Parv_Calb_cell_mat = gen_CMH_cell_mat( immuno_struct, 'Beta1R', 'Parv_Calb' );
    B1R_Parv_Calb_cell_mat_pval  = general_chi_sq_test( B1R_Parv_Calb_cell_mat );
    
    B1R_Parv_Calr_cell_mat = gen_CMH_cell_mat( immuno_struct, 'Beta1R', 'Parv_Calr' );
    B1R_Parv_Calr_cell_mat_pval  = general_chi_sq_test( B1R_Parv_Calr_cell_mat );
    
    B1R_Calb_Calr_cell_mat = gen_CMH_cell_mat( immuno_struct, 'Beta1R', 'Calb_Calr' );
    B1R_Calb_Calr_cell_mat_pval  = general_chi_sq_test( B1R_Calb_Calr_cell_mat );
    
    
    B1R_Inhib_pval_list = [B1R_Parv_Calb_cell_mat_pval, B1R_Parv_Calr_cell_mat_pval, B1R_Calb_Calr_cell_mat_pval];
    B1R_Inhib_pval_list = B1R_Inhib_pval_list .* 3; % Bonferonni correction
    
    
    % Addition of Pvals to Plot
    xpos1 = [b1_inhib.XData(1), b1_inhib.XData(2)];
    xpos2 = [b1_inhib.XData(1), b1_inhib.XData(3)];
    xpos3 = [b1_inhib.XData(2), b1_inhib.XData(3)];
    sigstar( {xpos1, xpos2, xpos3}, B1R_Inhib_pval_list);    

    ylim( [0 100] ); set(gca, 'ytick', [0:20:100]);
    set(gca,'XTickLabel',{'Parvalbumin', 'Calbindin', 'Calretinin'});
    ylabel( {'% of Neurons with'; 'Beta1 Receptors'}, 'FontSize', 12, 'FontWeight', 'bold' );
    set(gca,'FontSize',10, 'FontWeight', 'bold');

    set(gcf, 'Units', 'centimeters' );
    %set(gcf, 'Position', [30, 30, 8.6, 7.2])
    set(gca, 'box', 'off' );
    tightfig( gcf );
    resize_paper_for_pdf( gcf );
    save_out_fig( gcf, strcat('Beta1R_vs_Inhibitory_Neurons_Proportions') );

    
    %%% Beta1 Comparison - with other receptors in Parvalbumin and Calretinin neurons %%%
    Parv_Rs = [avgs_stes.A1AR_Parv.mean, avgs_stes.A2AR_Parv.mean, avgs_stes.B1R_Parv.mean, avgs_stes.B2R_Parv.mean];
    Parv_Rs_ste = [avgs_stes.A1AR_Parv.ste, avgs_stes.A2AR_Parv.ste, avgs_stes.B1R_Parv.ste, avgs_stes.B2R_Parv.ste ];
    
    Calb_Rs = [avgs_stes.A1AR_Calb.mean, avgs_stes.A2AR_Calb.mean, avgs_stes.B1R_Calb.mean, avgs_stes.B2R_Calb.mean];
    Calb_Rs_ste = [avgs_stes.A1AR_Calb.ste, avgs_stes.A2AR_Calb.ste, avgs_stes.B1R_Calb.ste, avgs_stes.B2R_Calb.ste ];
    
    Calr_Rs = [avgs_stes.A1AR_Calr.mean, avgs_stes.A2AR_Calr.mean, avgs_stes.B1R_Calr.mean, avgs_stes.B2R_Calr.mean];
    Calr_Rs_ste = [avgs_stes.A1AR_Calr.ste, avgs_stes.A2AR_Calr.ste, avgs_stes.B1R_Calr.ste, avgs_stes.B2R_Calr.ste ];
    
    
    figure(); 
    
    b = bar( [Parv_Rs; Calb_Rs; Calr_Rs] );
    hold on;
     
    % P-Values 
    A1R_B1R_Parv_cell_mat = gen_CMH_cell_mat( immuno_struct, 'A1R_B1R', 'Parvalbumin' );
    A1R_B1R_Parv_cell_mat_pval  = general_chi_sq_test( A1R_B1R_Parv_cell_mat );
    
    A2R_B1R_Parv_cell_mat = gen_CMH_cell_mat( immuno_struct, 'A2R_B1R', 'Parvalbumin' );
    A2R_B1R_Parv_cell_mat_pval  = general_chi_sq_test( A2R_B1R_Parv_cell_mat );
    
    B1R_B2R_Parv_cell_mat = gen_CMH_cell_mat( immuno_struct, 'B1R_B2R', 'Parvalbumin' );
    B1R_B2R_Parv_cell_mat_pval  = general_chi_sq_test( B1R_B2R_Parv_cell_mat );
    
    
    A1R_B1R_Calr_cell_mat = gen_CMH_cell_mat( immuno_struct, 'A1R_B1R', 'Calretinin' );
    A1R_B1R_Calr_cell_mat_pval  = general_chi_sq_test( A1R_B1R_Calr_cell_mat );
    
    A2R_B1R_Calr_cell_mat = gen_CMH_cell_mat( immuno_struct, 'A2R_B1R', 'Calretinin' );
    A2R_B1R_Calr_cell_mat_pval  = general_chi_sq_test( A2R_B1R_Calr_cell_mat );
    
    B1R_B2R_Calr_cell_mat = gen_CMH_cell_mat( immuno_struct, 'B1R_B2R', 'Calretinin' );
    B1R_B2R_Calr_cell_mat_pval  = general_chi_sq_test( B1R_B2R_Calr_cell_mat );

    
    Parv_pval_list = [A1R_B1R_Parv_cell_mat_pval, A2R_B1R_Parv_cell_mat_pval, B1R_B2R_Parv_cell_mat_pval];
    Parv_pval_list = Parv_pval_list .* 6; % Bonferonni correction
                           
    Calr_pval_list = [A1R_B1R_Calr_cell_mat_pval, A2R_B1R_Calr_cell_mat_pval, B1R_B2R_Calr_cell_mat_pval];
    Calr_pval_list = Calr_pval_list .* 6; % Bonferonni correction
    
    pv_xpos1 = [b(1).XData(1) + b(1).XOffset, b(1).XData(1) + b(3).XOffset];
    pv_xpos2 = [b(1).XData(1) + b(2).XOffset, b(1).XData(1) + b(3).XOffset];
    pv_xpos3 = [b(1).XData(1) + b(3).XOffset, b(1).XData(1) + b(4).XOffset];
    sigstar( {pv_xpos1, pv_xpos2, pv_xpos3}, Parv_pval_list);    

    cr_xpos1 = [b(1).XData(3) + b(1).XOffset, b(1).XData(3) + b(3).XOffset];
    cr_xpos2 = [b(1).XData(3) + b(2).XOffset, b(1).XData(3) + b(3).XOffset];
    cr_xpos3 = [b(1).XData(3) + b(3).XOffset, b(1).XData(3) + b(4).XOffset];
    sigstar( {cr_xpos1, cr_xpos2, cr_xpos3}, Calr_pval_list);    

    ylim( [0 110] ); set(gca, 'ytick', [0:20:100]);
    set(gca,'XTickLabel',{'Parvalbumin', 'Calbindin', 'Calretinin'});
    ylabel( {'% of Neurons with'; 'Receptor Type'}, 'FontSize', 12, 'FontWeight', 'bold' );
    set(gca,'FontSize',10, 'FontWeight', 'bold');
    
    legend('Alpha1AR', 'Alpha2AR', 'Beta1R', 'Beta2R' );

    set(gcf, 'Units', 'centimeters' );
    %set(gcf, 'Position', [30, 30, 8.6, 7.2])
    set(gca, 'box', 'off' );
    tightfig( gcf );
    resize_paper_for_pdf( gcf );
    save_out_fig( gcf, strcat('Beta1R_vs_Inhibitory_Neurons_Proportions_2') );



end