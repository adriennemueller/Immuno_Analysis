function inhib_comparison( immuno_struct )

    avgs_stes = get_avgs_stes( immuno_struct );

    %%% Receptor Comparison - across inhib neuron types %%%
%     A1AR_Inhib = [avgs_stes.A1AR_Parv.mean, avgs_stes.A1AR_Calb.mean, avgs_stes.A1AR_Calr.mean ];
%     A1AR_Inhib_ste = [avgs_stes.A1AR_Parv.ste, avgs_stes.A1AR_Calb.ste, avgs_stes.A1AR_Calr.ste ];
% 
%     A2AR_Inhib = [avgs_stes.A2AR_Parv.mean, avgs_stes.A2AR_Calb.mean, avgs_stes.A2AR_Calr.mean ];
%     A2AR_Inhib_ste = [avgs_stes.A2AR_Parv.ste, avgs_stes.A2AR_Calb.ste, avgs_stes.A2AR_Calr.ste ];
% 
%     B1R_Inhib = [avgs_stes.B1R_Parv.mean, avgs_stes.B1R_Calb.mean, avgs_stes.B1R_Calr.mean ];
%     B1R_Inhib_ste = [avgs_stes.B1R_Parv.ste, avgs_stes.B1R_Calb.ste, avgs_stes.B1R_Calr.ste ];
%     
%     B2R_Inhib = [avgs_stes.B2R_Parv.mean, avgs_stes.B2R_Calb.mean, avgs_stes.B2R_Calr.mean ];
%     B2R_Inhib_ste = [avgs_stes.B2R_Parv.ste, avgs_stes.B2R_Calb.ste, avgs_stes.B2R_Calr.ste ];      
     
    % P-Values BY RECEPTOR 

    A1AR_Parv_Calb_cell_mat = gen_CMH_cell_mat( immuno_struct, 'Alpha1AR', 'Parv_Calb' );
    A1AR_Parv_Calb_cell_mat_pval  = general_chi_sq_test( A1AR_Parv_Calb_cell_mat );
    
    A1AR_Parv_Calr_cell_mat = gen_CMH_cell_mat( immuno_struct, 'Alpha1AR', 'Parv_Calr' );
    A1AR_Parv_Calr_cell_mat_pval  = general_chi_sq_test( A1AR_Parv_Calr_cell_mat );
    
    A1AR_Calb_Calr_cell_mat = gen_CMH_cell_mat( immuno_struct, 'Alpha1AR', 'Calb_Calr' );
    A1AR_Calb_Calr_cell_mat_pval  = general_chi_sq_test( A1AR_Calb_Calr_cell_mat );
    

    A2AR_Parv_Calb_cell_mat = gen_CMH_cell_mat( immuno_struct, 'Alpha2AR', 'Parv_Calb' );
    A2AR_Parv_Calb_cell_mat_pval  = general_chi_sq_test( A2AR_Parv_Calb_cell_mat );
    
    A2AR_Parv_Calr_cell_mat = gen_CMH_cell_mat( immuno_struct, 'Alpha2AR', 'Parv_Calr' );
    A2AR_Parv_Calr_cell_mat_pval  = general_chi_sq_test( A2AR_Parv_Calr_cell_mat );
    
    A2AR_Calb_Calr_cell_mat = gen_CMH_cell_mat( immuno_struct, 'Alpha2AR', 'Calb_Calr' );
    A2AR_Calb_Calr_cell_mat_pval  = general_chi_sq_test( A2AR_Calb_Calr_cell_mat );
    

    B1R_Parv_Calb_cell_mat = gen_CMH_cell_mat( immuno_struct, 'Beta1R', 'Parv_Calb' );
    B1R_Parv_Calb_cell_mat_pval  = general_chi_sq_test( B1R_Parv_Calb_cell_mat );
    
    B1R_Parv_Calr_cell_mat = gen_CMH_cell_mat( immuno_struct, 'Beta1R', 'Parv_Calr' );
    B1R_Parv_Calr_cell_mat_pval  = general_chi_sq_test( B1R_Parv_Calr_cell_mat );
    
    B1R_Calb_Calr_cell_mat = gen_CMH_cell_mat( immuno_struct, 'Beta1R', 'Calb_Calr' );
    B1R_Calb_Calr_cell_mat_pval  = general_chi_sq_test( B1R_Calb_Calr_cell_mat );
    
    
    B2R_Parv_Calb_cell_mat = gen_CMH_cell_mat( immuno_struct, 'Beta2R', 'Parv_Calb' );
    B2R_Parv_Calb_cell_mat_pval  = general_chi_sq_test( B2R_Parv_Calb_cell_mat );
    
    B2R_Parv_Calr_cell_mat = gen_CMH_cell_mat( immuno_struct, 'Beta2R', 'Parv_Calr' );
    B2R_Parv_Calr_cell_mat_pval  = general_chi_sq_test( B2R_Parv_Calr_cell_mat );
    
    B2R_Calb_Calr_cell_mat = gen_CMH_cell_mat( immuno_struct, 'Beta2R', 'Calb_Calr' );
    B2R_Calb_Calr_cell_mat_pval  = general_chi_sq_test( B2R_Calb_Calr_cell_mat );
    

    % Receptor-based comparison between inhibitory cell types, p values list
    A1AR_Inhib_pval_list = [A1AR_Parv_Calb_cell_mat_pval, A1AR_Parv_Calr_cell_mat_pval, A1AR_Calb_Calr_cell_mat_pval];
    A1AR_Inhib_pval_list = A1AR_Inhib_pval_list .* 12; % Bonferonni correction
    
    A2AR_Inhib_pval_list = [A2AR_Parv_Calb_cell_mat_pval, A2AR_Parv_Calr_cell_mat_pval, A2AR_Calb_Calr_cell_mat_pval];
    A2AR_Inhib_pval_list = A2AR_Inhib_pval_list .* 12; % Bonferonni correction
    
    B1R_Inhib_pval_list = [B1R_Parv_Calb_cell_mat_pval, B1R_Parv_Calr_cell_mat_pval, B1R_Calb_Calr_cell_mat_pval];
    B1R_Inhib_pval_list = B1R_Inhib_pval_list .* 12; % Bonferonni correction
    
    B2R_Inhib_pval_list = [B2R_Parv_Calb_cell_mat_pval, B2R_Parv_Calr_cell_mat_pval, B2R_Calb_Calr_cell_mat_pval];
    B2R_Inhib_pval_list = B2R_Inhib_pval_list .* 12; % Bonferonni correction
    
    
    % Generate P Value Table for Manuscript
    % Receptor-based inhib v inhib cell type pvalue list
    disp( 'Parv v Calb, Parv v Calr, Calb v Calr - assigned in as R_pval_list' );
    R_pval_list = [A1AR_Inhib_pval_list; A2AR_Inhib_pval_list; B1R_Inhib_pval_list; B2R_Inhib_pval_list];
    assignin( 'base', 'R_pval_list', R_pval_list );

    
    % P-Values BY CELL TYPE
    A1R_A2R_Parv_cell_mat = gen_CMH_cell_mat( immuno_struct, 'A1R_A2R', 'Parvalbumin' );
    A1R_A2R_Parv_cell_mat_pval  = general_chi_sq_test( A1R_A2R_Parv_cell_mat );

    A1R_B1R_Parv_cell_mat = gen_CMH_cell_mat( immuno_struct, 'A1R_B1R', 'Parvalbumin' );
    A1R_B1R_Parv_cell_mat_pval  = general_chi_sq_test( A1R_B1R_Parv_cell_mat );

    A1R_B2R_Parv_cell_mat = gen_CMH_cell_mat( immuno_struct, 'A1R_B2R', 'Parvalbumin' );
    A1R_B2R_Parv_cell_mat_pval  = general_chi_sq_test( A1R_B2R_Parv_cell_mat );

    A2R_B1R_Parv_cell_mat = gen_CMH_cell_mat( immuno_struct, 'A2R_B1R', 'Parvalbumin' );
    A2R_B1R_Parv_cell_mat_pval  = general_chi_sq_test( A2R_B1R_Parv_cell_mat );

    A2R_B2R_Parv_cell_mat = gen_CMH_cell_mat( immuno_struct, 'A2R_B2R', 'Parvalbumin' );
    A2R_B2R_Parv_cell_mat_pval  = general_chi_sq_test( A2R_B2R_Parv_cell_mat );

    B1R_B2R_Parv_cell_mat = gen_CMH_cell_mat( immuno_struct, 'B1R_B2R', 'Parvalbumin' );
    B1R_B2R_Parv_cell_mat_pval  = general_chi_sq_test( B1R_B2R_Parv_cell_mat );
    
    
    A1R_A2R_Calb_cell_mat = gen_CMH_cell_mat( immuno_struct, 'A1R_A2R', 'Calbindin' );
    A1R_A2R_Calb_cell_mat_pval  = general_chi_sq_test( A1R_A2R_Calb_cell_mat );

    A1R_B1R_Calb_cell_mat = gen_CMH_cell_mat( immuno_struct, 'A1R_B1R', 'Calbindin' );
    A1R_B1R_Calb_cell_mat_pval  = general_chi_sq_test( A1R_B1R_Calb_cell_mat );
    
    A1R_B2R_Calb_cell_mat = gen_CMH_cell_mat( immuno_struct, 'A1R_B2R', 'Calbindin' );
    A1R_B2R_Calb_cell_mat_pval  = general_chi_sq_test( A1R_B2R_Calb_cell_mat );
    
    A2R_B1R_Calb_cell_mat = gen_CMH_cell_mat( immuno_struct, 'A2R_B1R', 'Calbindin' );
    A2R_B1R_Calb_cell_mat_pval  = general_chi_sq_test( A2R_B1R_Calb_cell_mat );

    A2R_B2R_Calb_cell_mat = gen_CMH_cell_mat( immuno_struct, 'A2R_B2R', 'Calbindin' );
    A2R_B2R_Calb_cell_mat_pval  = general_chi_sq_test( A2R_B2R_Calb_cell_mat );
   
    B1R_B2R_Calb_cell_mat = gen_CMH_cell_mat( immuno_struct, 'B1R_B2R', 'Calbindin' );
    B1R_B2R_Calb_cell_mat_pval  = general_chi_sq_test( B1R_B2R_Calb_cell_mat );

    
    A1R_A2R_Calr_cell_mat = gen_CMH_cell_mat( immuno_struct, 'A1R_A2R', 'Calretinin' );
    A1R_A2R_Calr_cell_mat_pval  = general_chi_sq_test( A1R_A2R_Calr_cell_mat );

    A1R_B1R_Calr_cell_mat = gen_CMH_cell_mat( immuno_struct, 'A1R_B1R', 'Calretinin' );
    A1R_B1R_Calr_cell_mat_pval  = general_chi_sq_test( A1R_B1R_Calr_cell_mat );
    
    A1R_B2R_Calr_cell_mat = gen_CMH_cell_mat( immuno_struct, 'A1R_B2R', 'Calretinin' );
    A1R_B2R_Calr_cell_mat_pval  = general_chi_sq_test( A1R_B2R_Calr_cell_mat );
    
    A2R_B1R_Calr_cell_mat = gen_CMH_cell_mat( immuno_struct, 'A2R_B1R', 'Calretinin' );
    A2R_B1R_Calr_cell_mat_pval  = general_chi_sq_test( A2R_B1R_Calr_cell_mat );

    A2R_B2R_Calr_cell_mat = gen_CMH_cell_mat( immuno_struct, 'A2R_B2R', 'Calretinin' );
    A2R_B2R_Calr_cell_mat_pval  = general_chi_sq_test( A2R_B2R_Calr_cell_mat );
    
    B1R_B2R_Calr_cell_mat = gen_CMH_cell_mat( immuno_struct, 'B1R_B2R', 'Calretinin' );
    B1R_B2R_Calr_cell_mat_pval  = general_chi_sq_test( B1R_B2R_Calr_cell_mat );   
    
    
    Parv_pval_list = [A1R_A2R_Parv_cell_mat_pval, A1R_B1R_Parv_cell_mat_pval, A1R_B2R_Parv_cell_mat_pval, ...
                      A2R_B1R_Parv_cell_mat_pval, A2R_B2R_Parv_cell_mat_pval, B1R_B2R_Parv_cell_mat_pval];
    Parv_pval_list = Parv_pval_list .* 18; % Bonferonni correction

    Calb_pval_list = [A1R_A2R_Calb_cell_mat_pval, A1R_B1R_Calb_cell_mat_pval, A1R_B2R_Calb_cell_mat_pval, ...
                      A2R_B1R_Calb_cell_mat_pval, A2R_B2R_Calb_cell_mat_pval, B1R_B2R_Calb_cell_mat_pval];
    Calb_pval_list = Calb_pval_list .* 18; % Bonferonni correction

    Calr_pval_list = [A1R_A2R_Calr_cell_mat_pval, A1R_B1R_Calr_cell_mat_pval, A1R_B2R_Calr_cell_mat_pval, ...
                      A2R_B1R_Calr_cell_mat_pval, A2R_B2R_Calr_cell_mat_pval, B1R_B2R_Calr_cell_mat_pval];
    Calr_pval_list = Calr_pval_list .* 18; % Bonferonni correction

   
    % Generate P Value Table for Manuscript
    disp( 'A1AR v A2AR, A1AR v B1R, A1AR v B2R, A2AR v B1R, A2AR v B2R, B1r v B2R  - assigned in as CT_pval_list' );
    CT_pval_list = [Parv_pval_list; Calb_pval_list; Calr_pval_list];
    assignin( 'base', 'CT_pval_list', CT_pval_list );
    
    
    %%% MEANS AND STES %%%
    Parv_Rs = [avgs_stes.A1AR_Parv.mean, avgs_stes.A2AR_Parv.mean, avgs_stes.B1R_Parv.mean, avgs_stes.B2R_Parv.mean];
    Parv_Rs_ste = [avgs_stes.A1AR_Parv.ste, avgs_stes.A2AR_Parv.ste, avgs_stes.B1R_Parv.ste, avgs_stes.B2R_Parv.ste ];
    
    Calb_Rs = [avgs_stes.A1AR_Calb.mean, avgs_stes.A2AR_Calb.mean, avgs_stes.B1R_Calb.mean, avgs_stes.B2R_Calb.mean];
    Calb_Rs_ste = [avgs_stes.A1AR_Calb.ste, avgs_stes.A2AR_Calb.ste, avgs_stes.B1R_Calb.ste, avgs_stes.B2R_Calb.ste ];
    
    Calr_Rs = [avgs_stes.A1AR_Calr.mean, avgs_stes.A2AR_Calr.mean, avgs_stes.B1R_Calr.mean, avgs_stes.B2R_Calr.mean];
    Calr_Rs_ste = [avgs_stes.A1AR_Calr.ste, avgs_stes.A2AR_Calr.ste, avgs_stes.B1R_Calr.ste, avgs_stes.B2R_Calr.ste ];

    
    
    figure(); 
    
    b = bar( [Parv_Rs; Calb_Rs; Calr_Rs] );
%     for j = 1:4
%         b(j).FaceColor = get_bar_facecolor( 'inhib', j );
%     end
    hold on;
    
    inhib_name_list = {'Parvalbumin', 'Calbindin', 'Calretinin'};
    for j = 1:4
        for i = 1:3
            b(j).FaceColor = 'flat';
            b(j).CData(i,:) = get_bar_facecolor( inhib_name_list{i}, j );
        end
    end
    
%     for i = 1:4
%         for j = 1:3
%             b(j).FaceColor = 'flat';
%             b(j).CData(i,:) = get_bar_facecolor( inhib_name_list{j}, i );
%         end
%     end
    
    
    
    % Cell Type Significance Stars
    pv_xpos1 = [b(1).XData(1) + b(1).XOffset, b(1).XData(1) + b(2).XOffset];
    pv_xpos2 = [b(1).XData(1) + b(1).XOffset, b(1).XData(1) + b(3).XOffset];
    pv_xpos3 = [b(1).XData(1) + b(1).XOffset, b(1).XData(1) + b(4).XOffset];
    pv_xpos4 = [b(1).XData(1) + b(2).XOffset, b(1).XData(1) + b(3).XOffset];
    pv_xpos5 = [b(1).XData(1) + b(2).XOffset, b(1).XData(1) + b(4).XOffset];
    pv_xpos6 = [b(1).XData(1) + b(3).XOffset, b(1).XData(1) + b(4).XOffset];
    sigstar( {pv_xpos1, pv_xpos2, pv_xpos3, pv_xpos4, pv_xpos5, pv_xpos6}, Parv_pval_list);    

    cb_xpos1 = [b(1).XData(2) + b(1).XOffset, b(1).XData(2) + b(2).XOffset];
    cb_xpos2 = [b(1).XData(2) + b(1).XOffset, b(1).XData(2) + b(3).XOffset];
    cb_xpos3 = [b(1).XData(2) + b(1).XOffset, b(1).XData(2) + b(4).XOffset];
    cb_xpos4 = [b(1).XData(2) + b(2).XOffset, b(1).XData(2) + b(3).XOffset];
    cb_xpos5 = [b(1).XData(2) + b(2).XOffset, b(1).XData(2) + b(4).XOffset];
    cb_xpos6 = [b(1).XData(2) + b(3).XOffset, b(1).XData(2) + b(4).XOffset];
    sigstar( {cb_xpos1, cb_xpos2, cb_xpos3, cb_xpos4, cb_xpos5, cb_xpos6}, Calb_pval_list);    

    cr_xpos1 = [b(1).XData(3) + b(1).XOffset, b(1).XData(3) + b(2).XOffset];
    cr_xpos2 = [b(1).XData(3) + b(1).XOffset, b(1).XData(3) + b(3).XOffset];
    cr_xpos3 = [b(1).XData(3) + b(1).XOffset, b(1).XData(3) + b(4).XOffset];
    cr_xpos4 = [b(1).XData(3) + b(2).XOffset, b(1).XData(3) + b(3).XOffset];
    cr_xpos5 = [b(1).XData(3) + b(2).XOffset, b(1).XData(3) + b(4).XOffset];
    cr_xpos6 = [b(1).XData(3) + b(3).XOffset, b(1).XData(3) + b(4).XOffset];
    sigstar( {cr_xpos1, cr_xpos2, cr_xpos3, cr_xpos4, cr_xpos5, cr_xpos6}, Calr_pval_list);    

    
    % Receptor Significance Stars
    a1ar_xpos1 = [b(1).XData(1) + b(1).XOffset, b(1).XData(2) + b(1).XOffset];
    a1ar_xpos2 = [b(1).XData(1) + b(1).XOffset, b(1).XData(3) + b(1).XOffset];
    a1ar_xpos3 = [b(1).XData(2) + b(1).XOffset, b(1).XData(3) + b(1).XOffset];
    a1ar_ss = sigstar({a1ar_xpos1, a1ar_xpos2, a1ar_xpos3}, A1AR_Inhib_pval_list);
    set( a1ar_ss, 'color', get_bar_facecolor( 'greyscale', 1 ) );
    
    a2ar_xpos1 = [b(1).XData(1) + b(2).XOffset, b(1).XData(2) + b(2).XOffset];
    a2ar_xpos2 = [b(1).XData(1) + b(2).XOffset, b(1).XData(3) + b(2).XOffset];
    a2ar_xpos3 = [b(1).XData(2) + b(2).XOffset, b(1).XData(3) + b(2).XOffset];
    a2ar_ss = sigstar({a2ar_xpos1, a2ar_xpos2, a2ar_xpos3}, A2AR_Inhib_pval_list);
    set( a2ar_ss, 'color', get_bar_facecolor( 'greyscale', 2 ) );
    
    b1r_xpos1 = [b(1).XData(1) + b(3).XOffset, b(1).XData(2) + b(3).XOffset];
    b1r_xpos2 = [b(1).XData(1) + b(3).XOffset, b(1).XData(3) + b(3).XOffset];
    b1r_xpos3 = [b(1).XData(2) + b(3).XOffset, b(1).XData(3) + b(3).XOffset];
    b1r_ss = sigstar({b1r_xpos1, b1r_xpos2, b1r_xpos3}, B1R_Inhib_pval_list);
    set( b1r_ss, 'color', get_bar_facecolor( 'greyscale', 3 ) );
    
    b2r_xpos1 = [b(1).XData(1) + b(4).XOffset, b(1).XData(2) + b(4).XOffset];
    b2r_xpos2 = [b(1).XData(1) + b(4).XOffset, b(1).XData(3) + b(4).XOffset];
    b2r_xpos3 = [b(1).XData(2) + b(4).XOffset, b(1).XData(3) + b(4).XOffset];
    b2r_ss = sigstar({b2r_xpos1, b2r_xpos2, b2r_xpos3}, B2R_Inhib_pval_list);
    set( b2r_ss, 'color', get_bar_facecolor( 'greyscale', 4 ) );
    
    
    ylim( [0 200] ); set(gca, 'ytick', [0:20:100]);
    set(gca,'XTickLabel',{'Parvalbumin', 'Calbindin', 'Calretinin'});
    ylabel( {'% of Neurons with'; 'Receptor Type'}, 'FontSize', 12, 'FontWeight', 'bold' );
    set(gca,'FontSize',10, 'FontWeight', 'bold');
    
    legend({'Alpha1AR', 'Alpha2AR', 'Beta1R', 'Beta2R'}, 'Location', 'northwest' );

    set(gcf, 'Units', 'centimeters' );
    %set(gcf, 'Position', [30, 30, 8.6, 7.2])
    set(gca, 'box', 'off' );
    tightfig( gcf );
    resize_paper_for_pdf( gcf );
    save_out_fig( gcf, strcat('Inhibitory_Neurons_Proportions') );



end