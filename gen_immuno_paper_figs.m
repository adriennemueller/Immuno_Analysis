function gen_immuno_paper_figs()

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
    
    
    %% D1R vs D2R, By Layer

    
    D1R_by_Layer = celldensity_by_layer( immuno_struct, 'D1R', 'all', 'FEF', 'R' );
    D2R_by_Layer = celldensity_by_layer( immuno_struct, 'D2R', 'all', 'FEF', 'R' ); %%% Was D2R
    D5R_by_Layer = celldensity_by_layer( immuno_struct, 'D5R', 'all', 'FEF', 'R' ); %%% Was D2R
    
    % Norm by NeuN
    NeuN_by_Layer = celldensity_by_layer( immuno_struct, 'all', 'NeuN', 'FEF', 'C' );
    D1R_by_Layer = D1R_by_Layer ./ NeuN_by_Layer;
    D2R_by_Layer = D2R_by_Layer ./ NeuN_by_Layer;
    
    figure();
    green_col = [0 0.8 0];
    b = bar( [D1R_by_Layer; D2R_by_Layer]' ); b(1).FaceColor = green_col; b(2).FaceColor = 'b';
    %ylim( [0 100] ); set(gca, 'ytick', [0:20:100]);
    set(gca,'XTickLabel',{'I', 'II-III' 'IV' 'V' 'VI'});
    ylabel( 'Receptor Density (um^{-2})', 'FontSize', 16, 'FontWeight', 'bold' );
    %set(gca,'XTickLabelRotation',45);
    set(gca,'FontSize',14, 'FontWeight', 'bold');
    legend( 'D1R', 'D2R');
    title( 'Cell Density by Layer / Normalized by NeuN ' );
    
    %% FIG1 FOR D5R PAPER
    
    TickLabel_FontSize = 14;
    AxisLabel_FontSize = 18;
    
    % D5R by layer, irrespective of cell type: NeuN Stains Only
    D5R_by_Layer_struct = celldensity_by_layer( immuno_struct, 'D5R', 'NeuN', 'FEF', 'B' ); %%% Was D2`R
    D5R_by_Layer = D5R_by_Layer_struct.mean;
    figure();
    set(gcf, 'Position', [100, 100, 1800, 750])
    subplot(1,2,1);
    b = barh( D5R_by_Layer' ); b.FaceColor = 'k'; set(gca,'Ydir','reverse');
    set(gca,'YTickLabel',{'I', 'II-III' 'IV' 'V' 'VI'}, 'FontSize', TickLabel_FontSize, 'XTick', [0 50000 100000 150000], ...
        'FontWeight', 'bold' ); box( gca, 'off');
    xlabel( 'D5R Receptor Density on NeuN+ Neurons (um^{2})', 'FontSize', AxisLabel_FontSize, 'FontWeight', 'bold' );
    ylabel( 'Cortical Layer', 'FontSize', AxisLabel_FontSize, 'FontWeight', 'bold' );
    
    ylim = get(gca,'ylim'); xlim = get(gca,'xlim');
    text(xlim(2)*0.95, ylim(2)*0.95, strcat( 'n = ', num2str(D5R_by_Layer_struct.n_cells), ', ', {' '}, num2str(D5R_by_Layer_struct.n_sections) ), 'FontWeight', 'bold', 'FontSize', 12, 'HorizontalAlignment', 'right');
    
    NeuN_by_Layer_struct = celldensity_by_layer( immuno_struct, 'D5R', 'NeuN', 'FEF', 'C' );
    NeuN_by_Layer = NeuN_by_Layer_struct.mean;
    NeuN_by_Layer = NeuN_by_Layer + D5R_by_Layer;
    D5R_Prop = D5R_by_Layer ./ NeuN_by_Layer;
    subplot(1,2,2);
    b = barh( D5R_Prop' ); b.FaceColor = 'k'; set(gca,'Ydir','reverse');
    set(gca,'YTickLabel',{'I', 'II-III' 'IV' 'V' 'VI'}, 'FontSize', TickLabel_FontSize, 'XTick', [0 0.25 0.5 0.75 1], ...
    'FontWeight', 'bold'  ); box( gca, 'off' );
    xlabel( 'Proportion of NeuN+ Neurons Expressing D5R', 'FontSize', AxisLabel_FontSize, 'FontWeight', 'bold' );
    
    tightfig( gcf );
    
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
    
end