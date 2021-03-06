
    immuno_struct = make_cellpos_struct();
    immuno_struct = gen_celldensities( immuno_struct );
    
    fef_and_dlPFC_Mark2( immuno_struct )

    %%
    % Normalized by NeuN Within Animal. So, using only NeuN/Receptor
    % Stained sections and normalizing by the NeuN count of each section.
    [D1R_all_Avg, D1R_all_STE, D1R_boot_avg, D1R_boot_ste] = celldensity_by_depth_NeuNNorm( immuno_struct, 'D1R', 'NeuN', 'FEF', 'B', 1, 1 );    
    [D2R_all_Avg, D2R_all_STE, D2R_boot_avg, D2R_boot_ste] = celldensity_by_depth_NeuNNorm( immuno_struct, 'D2R', 'NeuN', 'FEF', 'B', 1, 1 );    
    figure();
    subplot(2,1,1);
    %yyaxis left;
    s1_boot = shadedErrorBar( [], D1R_boot_avg, D1R_boot_ste, 'k', 0.3);  hold on;
    s1 = shadedErrorBar( [], D1R_all_Avg, D1R_all_STE, 'g', 0.5); hold off;
    %xlabel('Normalized Distance from Pial Surface', 'FontSize', 24, 'FontWeight', 'bold');
    ylabel('D1R Cell Density (um^{-2})', 'FontSize', 20, 'FontWeight', 'bold');
    set(gca,'XTick',[0:500:1000]);
    set(gca,'XTickLabel', {'0', '0.5', '1'})
    set(gca,'FontSize',16)    %yyaxis right;
    title( 'dlPFC Within-Section NeuN-Normalized / Only NeuN/R Sections' );
    %figure();
    subplot(2,1,2);
    s2_boot = shadedErrorBar( [], D2R_boot_avg, D2R_boot_ste, {'Color', '[0 0 0]'}, 0.3); hold on;
    s2 = shadedErrorBar( [], D2R_all_Avg, D2R_all_STE, 'b', 0.5);  hold off;
    xlabel('Normalized Distance from Pial Surface', 'FontSize', 20, 'FontWeight', 'bold');
    ylabel('D2R Cell Density (um^{-2})', 'FontSize', 24, 'FontWeight', 'bold');
    set(gca,'XTick',[0:500:1000]);
    set(gca,'XTickLabel', {'0', '0.5', '1'})
    set(gca,'FontSize',16)
   
    %%
    % Average of all D1R Receptors across sections (not just NeuN), but then divided
    % by the average of all NeuN Counts across sections. No Error Bars.
    [D1R_all_Avg, D1R_all_STE, D1R_bsAvg, D1R_bsSte] = celldensity_by_depth( immuno_struct, 'D1R', 'all', 'FEF', 'R', 1 );   
    [D2R_all_Avg, D2R_all_STE, D2R_bsAvg, D2R_bsSte] = celldensity_by_depth( immuno_struct, 'D2R', 'all', 'FEF', 'R', 1 );   
    [all_NeuN_Avg, all_NeuN_STE] = celldensity_by_depth( immuno_struct, 'all', 'NeuN', 'FEF', 'C', 1 );    
    D1R_all_Avg = D1R_all_Avg ./ all_NeuN_Avg; %D1R_all_STE = D1R_all_STE ./ all_NeuN_STE; %% Probably can't do this to STE.
    D2R_all_Avg = D2R_all_Avg ./ all_NeuN_Avg; %D2R_all_STE = D2R_all_STE ./ all_NeuN_STE;
    figure();
    %yyaxis left;
    %s1 = shadedErrorBar( [], D1R_all_Avg, D1R_all_STE, 'g', 0.5); hold on;
    h1 = plot( D1R_all_Avg, 'g'); hold on;
    %yyaxis right;
    %s2 = shadedErrorBar( [], D2R_all_Avg, D2R_all_STE, 'b', 0.5); hold off;
    h2 = plot( D2R_all_Avg, 'b'); hold off;
    xlabel('Normalized Distance from Pial Surface', 'FontSize', 20, 'FontWeight', 'bold');
    ylabel('Cell Density (A.U.)', 'FontSize', 24, 'FontWeight', 'bold');
    title( {'Average of All Receptors across Sections /', 'Average of All NeuN across Sections', 'Not Paired'} );
    xlim([80 1000]);
    ylim([0 0.8]);
    set(gca,'XTick',[0:500:1000]);
    set(gca,'XTickLabel', {'0', '0.5', '1'});
    set(gca,'FontSize',16);
    %h = findobj(gca,'Type','patch');
    legend( [ h1 h2 ], {'D1R','D2R'} );

    
    %%
    % Average of all D1R Receptors across sections (not just NeuN)
    [D1R_all_Avg, D1R_all_STE, D1R_bsAvg, D1R_bsSte] = celldensity_by_depth( immuno_struct, 'D1R', 'all', 'FEF', 'R', 1 );   
    [D2R_all_Avg, D2R_all_STE, D2R_bsAvg, D2R_bsSte] = celldensity_by_depth( immuno_struct, 'D2R', 'all', 'FEF', 'R', 1 );   
    %[all_NeuN_Avg, all_NeuN_STE] = celldensity_by_depth( immuno_struct, 'all', 'NeuN', 'FEF', 'C', 1 );    
    %D1R_all_Avg = D1R_all_Avg ./ all_NeuN_Avg; %D1R_all_STE = D1R_all_STE ./ all_NeuN_STE; %% Probably can't do this to STE.
    %D2R_all_Avg = D2R_all_Avg ./ all_NeuN_Avg; %D2R_all_STE = D2R_all_STE ./ all_NeuN_STE;
    figure();
    %yyaxis left;
    s1 = shadedErrorBar( [], D1R_all_Avg, D1R_all_STE, 'g', 0.5); hold on;
    %h1 = plot( D1R_all_Avg, 'g'); hold on;
    %yyaxis right;
    s2 = shadedErrorBar( [], D2R_all_Avg, D2R_all_STE, 'b', 0.5); hold off;
    %h2 = plot( D2R_all_Avg, 'b'); hold off;
    xlabel('Normalized Distance from Pial Surface', 'FontSize', 20, 'FontWeight', 'bold');
    ylabel('Cell Density (um^{-2})', 'FontSize', 24, 'FontWeight', 'bold');
    title( {'Average of All Receptors across Sections'} );
    set(gca,'XTick',[0:500:1000]);
    set(gca,'XTickLabel', {'0', '0.5', '1'});
    set(gca,'FontSize',16);
    h = findobj(gca,'Type','patch');
    legend( [ h(2) h(1) ], {'D1R','D2R'} );
    
    %%
    % Averaging only those sections which are Receptor/NeuN, but don't pair
    % the sections. So Average Rs of R/NeuN sections divided by average
    % NeuNs for those sections
    [D1R_all_Avg, D1R_all_STE] = celldensity_by_depth( immuno_struct, 'D1R', 'NeuN', 'FEF', 'R', 1 );   
    [D2R_all_Avg, D2R_all_STE] = celldensity_by_depth( immuno_struct, 'D2R', 'NeuN', 'FEF', 'R', 1 );   
    [D1R_NeuN_Avg, D1R_NeuN_STE] = celldensity_by_depth( immuno_struct, 'D1R', 'NeuN', 'FEF', 'C', 1 );    
    [D2R_NeuN_Avg, D2R_NeuN_STE] = celldensity_by_depth( immuno_struct, 'D2R', 'NeuN', 'FEF', 'C', 1 );    
    D1R_all_Avg = D1R_all_Avg ./ D1R_NeuN_Avg; %D1R_all_STE = D1R_all_STE ./ all_NeuN_STE; %% Probably can't do this to STE.
    D2R_all_Avg = D2R_all_Avg ./ D2R_NeuN_Avg; %D2R_all_STE = D2R_all_STE ./ all_NeuN_STE;
    
   figure();
    %yyaxis left;
    %s1 = shadedErrorBar( [], D1R_all_Avg, D1R_all_STE, 'g', 0.5); hold on;
    h1 = plot( D1R_all_Avg, 'g'); hold on;
    %yyaxis right;
    %s2 = shadedErrorBar( [], D2R_all_Avg, D2R_all_STE, 'b', 0.5); hold off;
    h2 = plot( D2R_all_Avg, 'b'); hold off;
    xlabel('Normalized Distance from Pial Surface', 'FontSize', 20, 'FontWeight', 'bold');
    ylabel('Cell Density (A.U.)', 'FontSize', 24, 'FontWeight', 'bold');
    title( {'Average of Receptors from NeuN Sections /', 'Average of NeuN from NeuN Sections', 'Not Paired'} );
    xlim([80 1000]);
    ylim([0 0.8]);
    set(gca,'XTick',[0:500:1000]);
    set(gca,'XTickLabel', {'0', '0.5', '1'});
    set(gca,'FontSize',16);
    %h = findobj(gca,'Type','patch');
    legend( [ h1 h2 ], {'D1R','D2R'} );
        
    
    
    
    %%
    %
    [D1R_all_Avg, D1R_all_STE, D1R_boot_avg, D1R_boot_ste] = celldensity_by_depth( immuno_struct, 'D1R', 'all', 'FEF', 'R', 1 );    
    [D2R_all_Avg, D2R_all_STE, D2R_boot_avg, D2R_boot_ste] = celldensity_by_depth( immuno_struct, 'D2R', 'all', 'FEF', 'R', 1 );    
    figure();
    %yyaxis left;
    s1_boot = shadedErrorBar( [], D1R_boot_avg, D1R_boot_ste, 'k', 0.5); hold on;
    s1 = shadedErrorBar( [], D1R_all_Avg, D1R_all_STE, 'g', 0.5); 
    %yyaxis right;
    %figure();
    s2_boot = shadedErrorBar( [], D2R_boot_avg, D2R_boot_ste, 'k', 0.5); 
    s2 = shadedErrorBar( [], D2R_all_Avg, D2R_all_STE, 'b', 0.5);hold off;
    
    xlabel('Normalized Distance from Pial Surface', 'FontSize', 20, 'FontWeight', 'bold');
    ylabel('Cell Density (um^{-2})', 'FontSize', 24, 'FontWeight', 'bold');
    title( {'FEF Average of All Receptors across Sections'} );
    set(gca,'XTick',[0:500:1000]);
    set(gca,'XTickLabel', {'0', '0.5', '1'});
    set(gca,'FontSize',16);
    h = findobj(gca,'Type','patch');
    legend( [ h(3) h(1) ], {'D1R','D2R'} );
    
    
    %% D1R vs D2R, By Layer - With ErrorBars and PVal
    
    D1_substruct = immuno_struct(strcmp({immuno_struct.Stain1}, 'D1R') & strcmp({immuno_struct.Region}, 'FEF'));
    d1_dens = get_density_individ( D1_substruct, 'TR' );
   
    D2_substruct = immuno_struct(strcmp({immuno_struct.Stain1}, 'D2R') & strcmp({immuno_struct.Region}, 'FEF'));
    d2_dens = get_density_individ( D2_substruct, 'TR' );
    
    d1_means = mean( d1_dens, 1 );
    d2_means = mean( d2_dens, 1 );
    
    d1_std = std( d1_dens, 1);
    d2_std = std( d2_dens, 1);
    
    d1_ste = d1_std ./ sqrt( length(d1_dens) );
    d2_ste = d2_std ./ sqrt( length(d2_dens) );
       
    
    green_col = [0 0.8 0];
    mm_factor = 1000000;
    figure();
    b = barwitherr( [d1_ste', d2_ste'].* mm_factor, [d1_means', d2_means' ] .* mm_factor ); b(1).FaceColor = green_col; b(2).FaceColor = 'b';
    
    set(gca,'XTickLabel',{'I', 'II-III' 'IV' 'V' 'VI'});
    ylabel( 'Density of Neurons Expressing Receptor (/mm^{2})', 'FontSize', 16, 'FontWeight', 'bold' );
    set(gca,'FontSize',14, 'FontWeight', 'bold');
    legend( 'D1R', 'D2R');
    title( 'Cell Density by Layer ' );

    [tmp pvals] = ttest2( d1_dens, d2_dens, 'Dim', 1 );
    
    pval_strings = get_pval_string(pvals, 0.05/5);
    text( 1:5, d1_means .* mm_factor + 10, pval_strings, 'FontWeight', 'bold', 'FontSize', 11); 
    
    % Fix so saving as pdf will be the right size.
    tightfig( gcf );
    resize_paper_for_pdf( gcf );
    save_out_fig( gcf, 'Fig1_D1R_D2R_Densities_By_Layer' );
    
    
    %% D1R vs D2R, By Layer - Normalized by total number so can compare within R, across layers
    
    D1_substruct = immuno_struct(strcmp({immuno_struct.Stain1}, 'D1R') & strcmp({immuno_struct.Region}, 'FEF'));
    d1_dens = get_density_individ( D1_substruct, 'TR' );
    d1_section_totals = sum( d1_dens, 2);
    norm_d1_dens = bsxfun( @rdivide, d1_dens, d1_section_totals);
    d1_means = mean( norm_d1_dens, 1 );
    
    D2_substruct = immuno_struct(strcmp({immuno_struct.Stain1}, 'D2R') & strcmp({immuno_struct.Region}, 'FEF'));
    d2_dens = get_density_individ( D2_substruct, 'TR' );
    d2_section_totals = sum( d2_dens, 2);
    norm_d2_dens = bsxfun( @rdivide, d2_dens, d2_section_totals);
    d2_means = mean( norm_d2_dens, 1 );

    green_col = [0 0.8 0];
    figure();
    b = bar( [d1_means', d2_means' ] ); b(1).FaceColor = green_col; b(2).FaceColor = 'b';
    set(gca,'XTickLabel',{'I' 'II-III' 'IV' 'V' 'VI'});
    %ylabel( 'Density of Neurons Expressing Receptor (/mm^{2})', 'FontSize', 16, 'FontWeight', 'bold' );
    set(gca,'FontSize',14, 'FontWeight', 'bold');
    legend( 'D1R', 'D2R');
    %title( 'Cell Density by Layer ' );
    
    % Do pval D1R 
    [tmp pval_d1_l2vl4] = ttest2( norm_d1_dens( :,2 ), norm_d1_dens( :,3 ) );
    [tmp pval_d1_l2vl5] = ttest2( norm_d1_dens( :,2 ), norm_d1_dens( :,4 ) );
    [tmp pval_d1_l2vl6] = ttest2( norm_d1_dens( :,2 ), norm_d1_dens( :,5 ) );
    
    % pval D2Rs
    [tmp pval_d2_l2vl4] = ttest2( norm_d2_dens( :,2 ), norm_d2_dens( :,3 ) );
    [tmp pval_d2_l2vl5] = ttest2( norm_d2_dens( :,2 ), norm_d2_dens( :,4 ) );
    [tmp pval_d2_l2vl6] = ttest2( norm_d2_dens( :,2 ), norm_d2_dens( :,5 ) );

    %bar([5,2,1.5])
    %sigstar({[1,2], [1,3]})
    
    
    %% D1R vs D2R, By Layer - incomplete

    Counts_Struct = struct;

    % D1R 
    D1_substruct = immuno_struct(strcmp({immuno_struct.Stain1}, 'D1R') & strcmp({immuno_struct.Region}, 'FEF'));
    Counts_Struct.D1_CT_Total_count = get_count( D1_substruct, 'TR' );
    Counts_Struct.D1_CT_Total_TotalXLayers = sum( Counts_Struct.D1_CT_Total_count ); 
    D1R_By_Layer = Counts_Struct.D1_CT_Total_count ./ Counts_Struct.D1_CT_Total_TotalXLayers;
    
    % D2R 
    D2_substruct = immuno_struct(strcmp({immuno_struct.Stain1}, 'D2R') & strcmp({immuno_struct.Region}, 'FEF'));
    Counts_Struct.D2_CT_Total_count = get_count( D2_substruct, 'TR' );
    Counts_Struct.D2_CT_Total_TotalXLayers = sum( Counts_Struct.D2_CT_Total_count ); 
    D2R_By_Layer = Counts_Struct.D2_CT_Total_count ./ Counts_Struct.D2_CT_Total_TotalXLayers;
     
    % NeuN
%     NeuN_substruct = immuno_struct(strcmp({immuno_struct.Stain2}, 'NeuN') & strcmp({immuno_struct.Region}, 'FEF'));
%     Counts_Struct.NeuN_CT_Total_count = get_count( NeuN_substruct, 'T' );
%     Counts_Struct.NeuN_CT_Total_TotalXLayers = sum( Counts_Struct.NeuN_CT_Total_count ); 
%     NeuN_By_Layer = Counts_Struct.NeuN_CT_Total_count ./ Counts_Struct.NeuN_CT_Total_TotalXLayers;
    
    %D1R_By_Layer_Norm = D1R_By_Layer ./ NeuN_By_Layer;
    %D2R_By_Layer_Norm = D2R_By_Layer ./ NeuN_By_Layer; 
    
    figure();
    mm_factor = 1000000;
    green_col = [0 0.8 0];
    b = bar( [D1R_By_Layer; D2R_By_Layer]' .* mm_factor ); b(1).FaceColor = green_col; b(2).FaceColor = 'b';
  
    %figure();
    %mm_factor = 1000000;
    %green_col = [0 0.8 0];
    %b = bar( [D1R_By_Layer_Norm; D2R_By_Layer_Norm]' .* mm_factor ); b(1).FaceColor = green_col; b(2).FaceColor = 'b';
 
  
 %%    D1R vs D2R, By Layer - NEWER VERSION
    
    D1R_by_Layer_struct = celldensity_by_layer( immuno_struct, 'D1R', 'all', 'FEF', 'TR' );
    D1R_by_Layer = D1R_by_Layer_struct.mean;
    D1R_by_Layer_STE = D1R_by_Layer_struct.ste;

    D2R_by_Layer_struct = celldensity_by_layer( immuno_struct, 'D2R', 'all', 'FEF', 'TR' );
    D2R_by_Layer = D2R_by_Layer_struct.mean;
    D2R_by_Layer_STE = D2R_by_Layer_struct.ste;

    % Norm by NeuN
    NeuN_by_Layer_struct = celldensity_by_layer( immuno_struct, 'all', 'NeuN', 'FEF', 'TC' );
    NeuN_by_Layer = NeuN_by_Layer_struct.mean;
    NeuN_by_Layer_STE = NeuN_by_Layer_struct.ste;

    %D1R_by_Layer = D1R_by_Layer ./ NeuN_by_Layer;
    %D2R_by_Layer = D2R_by_Layer ./ NeuN_by_Layer;
    
    
    NRG_by_Layer_struct = celldensity_by_layer( immuno_struct, 'all', 'Neurogranin', 'FEF', 'TC' );
    NRG_by_Layer = NRG_by_Layer_struct.mean;
    NRG_by_Layer_STE = NRG_by_Layer_struct.ste;
    SMI32_by_Layer_struct = celldensity_by_layer( immuno_struct, 'all', 'SMI-32', 'FEF', 'TC' );
    SMI32_by_Layer = SMI32_by_Layer_struct.mean;
    SMI32_by_Layer_STE = SMI32_by_Layer_struct.ste;
    Parv_by_Layer_struct = celldensity_by_layer( immuno_struct, 'all', 'Parvalbumin', 'FEF', 'TC' );
    Parv_by_Layer = Parv_by_Layer_struct.mean;
    Parv_by_Layer_STE = Parv_by_Layer_struct.ste;
    Calb_by_Layer_struct = celldensity_by_layer( immuno_struct, 'all', 'Calbindin', 'FEF', 'TC' );
    Calb_by_Layer = Calb_by_Layer_struct.mean;
    Calb_by_Layer_STE = Calb_by_Layer_struct.ste;
    Calr_by_Layer_struct = celldensity_by_layer( immuno_struct, 'all', 'Calretinin', 'FEF', 'TC' );
    Calr_by_Layer = Calr_by_Layer_struct.mean;
    Calr_by_Layer_STE = Calr_by_Layer_struct.ste;
    Som_by_Layer_struct = celldensity_by_layer( immuno_struct, 'all', 'Somatostatin', 'FEF', 'TC' );
    Som_by_Layer = Som_by_Layer_struct.mean;
    Som_by_Layer_STE = Som_by_Layer_struct.ste;
    
    mm_factor = 1000000;
    
    figure();
    subplot(1,2,2);
    hold on;
    gray_col = [0.8 0.8 0.8];
    a = bar( [D1R_by_Layer'; D2R_by_Layer']' .* mm_factor ); a(1).FaceColor = 'k'; a(2).FaceColor = gray_col;
    
    err_x1 = a(1).XData + a(1).XOffset;
    err_x2 = a(2).XData + a(2).XOffset;
    errorbar( err_x1, D1R_by_Layer .* mm_factor, D1R_by_Layer_STE .* mm_factor, 'k', 'linestyle', 'none', 'HandleVisibility','off' );
    errorbar( err_x2, D2R_by_Layer .* mm_factor, D2R_by_Layer_STE .* mm_factor, 'k', 'linestyle', 'none', 'HandleVisibility','off' );
    
    ylim( [0 370] ); set(gca, 'ytick', [0:50:300]);
    set(gca,'XTickLabel',{'I', 'II-III' 'IV' 'V' 'VI'});
    ylabel( 'Neurons / mm^{2}', 'FontSize', 12, 'FontWeight', 'bold' );
    xlabel( 'Layer' );
    %set(gca,'XTickLabelRotation',45);
    set(gca,'FontSize',10, 'FontWeight', 'bold');
    legend( 'D1R', 'D2R', 'Location', 'northwest');
    hold off;
    
    subplot(1,2,1);
    
    CT_by_Layer_Means = [NRG_by_Layer'; SMI32_by_Layer'; Parv_by_Layer'; Calr_by_Layer'; Calb_by_Layer'; Som_by_Layer']';
    CT_by_Layer_STEs = [NRG_by_Layer_STE'; SMI32_by_Layer_STE'; Parv_by_Layer_STE'; Calr_by_Layer_STE'; Calb_by_Layer_STE'; Som_by_Layer_STE']';
    
    hold on;
    b = bar( CT_by_Layer_Means .* mm_factor, 'BarWidth', 1);
    ylim( [0 370] ); set(gca, 'ytick', [0:50:300]);
    set(gca,'XTickLabel',{'I', 'II-III' 'IV' 'V' 'VI'});
    ylabel( 'Neurons / mm^{2}', 'FontSize', 12, 'FontWeight', 'bold' );
    xlabel( 'Layer' );
    %set(gca,'XTickLabelRotation',45);
    set(gca,'FontSize',10, 'FontWeight', 'bold');
    legend( 'Neurogranin', 'SMI-32','Parvalbumin', 'Calbindin', 'Calretinin', 'Somatostatin', 'Location', 'northwest');

    for i  = 1:length( b )
        err_x = b(i).XData + b(i).XOffset;
        err_y = CT_by_Layer_Means(:,i);
        errorbar( err_x, err_y .* mm_factor, CT_by_Layer_STEs(:,i) .* mm_factor, 'k', 'linestyle', 'none', 'HandleVisibility','off' );
    end
    
    
    set(gcf, 'Units', 'centimeters' );
    set(gcf, 'Position', [30, 30, 18, 7.2])
    set(gca, 'box', 'off' );
    tightfig( gcf );
    resize_paper_for_pdf( gcf );
    save_out_fig( gcf, strcat('Fig7_D1R_D2R_Densities_By_Layer') );
    hold off;

    %title( 'Cell Density by Layer' );
    
    %% FIG1 FOR D5R PAPER
    
    TickLabel_FontSize = 14;
    AxisLabel_FontSize = 18;
    SubFigureLabel_FontSize = 28;
    
    mm_factor = 1000000;
    
    % D5R by layer, irrespective of cell type: NeuN Stains Only
    D5R_by_Layer_struct = celldensity_by_layer( immuno_struct, 'D5R', 'NeuN', 'FEF', 'B' ); %%% Was D2`R
    D5R_by_Layer = D5R_by_Layer_struct.mean;
    figure();
    set(gcf, 'Position', [100, 100, 1200, 500])
    subplot(1,2,1);
    b = barh( D5R_by_Layer' * mm_factor ); b.FaceColor = [0.8 0.8 0.8]; set(gca,'Ydir','reverse');
    set(gca,'YTickLabel',{'I', 'II-III' 'IV' 'V' 'VI'}, 'FontSize', TickLabel_FontSize, ... 'XTick', [0 50000 100000 150000], ...
        'FontWeight', 'bold' ); box( gca, 'off');
    xlabel( {'D5R+ NeuN+ Neuron Density (mm^{2})'}, 'FontSize', AxisLabel_FontSize, 'FontWeight', 'bold' );
    ylabel( 'Cortical Layer', 'FontSize', AxisLabel_FontSize, 'FontWeight', 'bold' );
    
    ylims = get(gca,'ylim'); xlims = get(gca,'xlim');
    text(ylims(2)*0.95, xlims(2)*0.95, strcat( 'n = ', num2str(D5R_by_Layer_struct.n_cells), ', ', {' '}, num2str(D5R_by_Layer_struct.n_sections) ), 'FontWeight', 'bold', 'FontSize', 12, 'HorizontalAlignment', 'right');
    
    SubFigLabelBox_A = uicontrol('style','text');
    set(SubFigLabelBox_A,'String','A', 'FontSize', SubFigureLabel_FontSize, 'BackgroundColor', 'white', ...
        'Position', [1, 440, 30, 30]);
        
    NeuN_by_Layer_struct = celldensity_by_layer( immuno_struct, 'D5R', 'NeuN', 'FEF', 'C' );
    NeuN_by_Layer = NeuN_by_Layer_struct.mean;
    NeuN_by_Layer = NeuN_by_Layer + D5R_by_Layer;
    D5R_Prop = D5R_by_Layer ./ NeuN_by_Layer;
    subplot(1,2,2);
    b = barh( D5R_Prop' ); b.FaceColor = [0.8 0.8 0.8]; set(gca,'Ydir','reverse');
    set(gca,'YTickLabel',{'I', 'II-III' 'IV' 'V' 'VI'}, 'FontSize', TickLabel_FontSize, 'XTick', [0 0.25 0.5 0.75 1], ...
    'FontWeight', 'bold'  ); box( gca, 'off' );
    xlabel( {'Proportion of NeuN+ Neurons', 'Expressing D5R'}, 'FontSize', AxisLabel_FontSize, 'FontWeight', 'bold' );
    ylabel( 'Cortical Layer', 'FontSize', AxisLabel_FontSize, 'FontWeight', 'bold' );
    
    SubFigLabelBox_B = uicontrol('style','text');
    set(SubFigLabelBox_B,'String','B', 'FontSize', SubFigureLabel_FontSize, 'BackgroundColor', 'white', ...
        'Position', [530, 440, 30, 30]);
    
    tightfig( gcf );
    resize_paper_for_pdf( gcf );
    
    save_out_fig( gcf, 'Fig1_D5R_Density_Proportion' );
    
    %% REMAINING FIGS FOR D5R PAPER
    
    % Do general chi sq here with multiple rows.
    
    % D5R density by cell type and layer ( and FEF/dlPFC by cell type and
    % layer comparison
    
    d5r_by_cell_and_layer_mark2( immuno_struct )
    
    d5r_by_cell_and_layer( immuno_struct )

    % D5R_fef_and_dlPFC_Mark2( immuno_struct )

    
    % D5R across different cell types (irrespective of layer)
    immuno_struct = add_combinedInhibs( immuno_struct ); %%% ADDING INHIB COUNTS %%%
    d5r_plot( immuno_struct );
    
    
    %%
    %d5r_plot( immuno_struct );
    %fef_and_dlPFC( immuno_struct );
    
    
    immuno_struct = add_combinedInhibs( immuno_struct );
    d1r_d2r_comparison_Mark2 ( immuno_struct );
