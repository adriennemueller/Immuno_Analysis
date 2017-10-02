function rslt = d5r_by_cell_and_layer( immuno_struct )
    
    D5R_NeuN_by_Layer  = celldensity_by_layer( immuno_struct, 'D5R', 'NeuN', 'FEF', 'B' ); 
    D5R_SMI32_by_Layer = celldensity_by_layer( immuno_struct, 'D5R', 'SMI-32', 'FEF', 'B' );
    D5R_NRG_by_Layer   = celldensity_by_layer( immuno_struct, 'D5R', 'Neurogranin', 'FEF', 'B' );
    D5R_Parv_by_Layer  = celldensity_by_layer( immuno_struct, 'D5R', 'Parvalbumin', 'FEF', 'B' );
    D5R_CalB_by_Layer  = celldensity_by_layer( immuno_struct, 'D5R', 'Calbindin', 'FEF', 'B' );
    D5R_CalR_by_Layer  = celldensity_by_layer( immuno_struct, 'D5R', 'Calretinin', 'FEF', 'B' );
    D5R_Som_by_Layer   = celldensity_by_layer( immuno_struct, 'D5R', 'Somatostatin', 'FEF', 'B' );

    % Rows = Layers, Columns = Cell types
    D5R_cellmat = horzcat( D5R_NeuN_by_Layer.mean, D5R_SMI32_by_Layer.mean, D5R_NRG_by_Layer.mean, D5R_Parv_by_Layer.mean, ...
                           D5R_CalB_by_Layer.mean, D5R_CalR_by_Layer.mean, D5R_Som_by_Layer.mean ); 
    
    figure();
    [layercount celltypecount] = size( D5R_cellmat );
    LayerStrings = {'I', 'II-III', 'IV', 'V', 'VI'};
    CellTypeStrings = {'NeuN', 'SMI-32', 'Neurogranin', 'Parvalbumin', 'Calbindin', 'Calretinin', 'Somatostatin'};
    for i = 1:celltypecount
        subplot( celltypecount, 1, i ); 
        barh( D5R_cellmat( :, i ) );
        ylabel( CellTypeStrings(i) );
        set(gca,'YTickLabel', LayerStrings);
        set(gca,'Ydir','reverse')
        ylim( [1,6] );
    end
    xlabel( 'Density of D5R-positive Neuronal Subtypes Across Cortical Layers' );

    
    CT_D5R_NeuN_by_Layer  = celldensity_by_layer( immuno_struct, 'D5R', 'NeuN', 'FEF', 'C' ); 
    CT_D5R_SMI32_by_Layer = celldensity_by_layer( immuno_struct, 'D5R', 'SMI-32', 'FEF', 'C' );
    CT_D5R_NRG_by_Layer   = celldensity_by_layer( immuno_struct, 'D5R', 'Neurogranin', 'FEF', 'C' );
    CT_D5R_Parv_by_Layer  = celldensity_by_layer( immuno_struct, 'D5R', 'Parvalbumin', 'FEF', 'C' );
    CT_D5R_CalB_by_Layer  = celldensity_by_layer( immuno_struct, 'D5R', 'Calbindin', 'FEF', 'C' );
    CT_D5R_CalR_by_Layer  = celldensity_by_layer( immuno_struct, 'D5R', 'Calretinin', 'FEF', 'C' );
    CT_D5R_Som_by_Layer   = celldensity_by_layer( immuno_struct, 'D5R', 'Somatostatin', 'FEF', 'C' );
    
    PROP_D5R_NeuN_by_Layer  = D5R_NeuN_by_Layer.mean  ./ ( D5R_NeuN_by_Layer.mean  + CT_D5R_NeuN_by_Layer.mean);
    PROP_D5R_SMI32_by_Layer = D5R_SMI32_by_Layer.mean ./ ( D5R_SMI32_by_Layer.mean + CT_D5R_SMI32_by_Layer.mean);
    PROP_D5R_NRG_by_Layer   = D5R_NRG_by_Layer.mean   ./ ( D5R_NRG_by_Layer.mean   + CT_D5R_NRG_by_Layer.mean);
    PROP_D5R_Parv_by_Layer  = D5R_Parv_by_Layer.mean  ./ ( D5R_Parv_by_Layer.mean  + CT_D5R_Parv_by_Layer.mean);
    PROP_D5R_CalB_by_Layer  = D5R_CalB_by_Layer.mean  ./ ( D5R_CalB_by_Layer.mean  + CT_D5R_CalB_by_Layer.mean);
    PROP_D5R_CalR_by_Layer  = D5R_CalR_by_Layer.mean  ./ ( D5R_CalR_by_Layer.mean  + CT_D5R_CalR_by_Layer.mean);
    PROP_D5R_Som_by_Layer   = D5R_Som_by_Layer.mean   ./ ( D5R_Som_by_Layer.mean   + CT_D5R_Som_by_Layer.mean);
    
    PROP_D5R_cellmat = horzcat( PROP_D5R_NeuN_by_Layer, PROP_D5R_SMI32_by_Layer, PROP_D5R_NRG_by_Layer, PROP_D5R_Parv_by_Layer, ...
                           PROP_D5R_CalB_by_Layer, PROP_D5R_CalR_by_Layer, PROP_D5R_Som_by_Layer ); 
   
    figure();
    [layercount celltypecount] = size( PROP_D5R_cellmat );
    for i = 1:celltypecount
        subplot( celltypecount, 1, i ); 
        barh( PROP_D5R_cellmat( :, i ) );
        ylabel( CellTypeStrings(i) );
        set(gca,'YTickLabel', LayerStrings);
        set(gca,'Ydir','reverse')
    end
    xlabel( 'Proportion of D5R-positive Neurons Across Cortical Layers for a Given Neuronal Subtype' );

    % Change in ratio of D5R neurons that are a particular cell type?
    R_D5R_NeuN_by_Layer  = celldensity_by_layer( immuno_struct, 'D5R', 'NeuN', 'FEF', 'R' ); 
    R_D5R_SMI32_by_Layer = celldensity_by_layer( immuno_struct, 'D5R', 'SMI-32', 'FEF', 'R' );
    R_D5R_NRG_by_Layer   = celldensity_by_layer( immuno_struct, 'D5R', 'Neurogranin', 'FEF', 'R' );
    R_D5R_Parv_by_Layer  = celldensity_by_layer( immuno_struct, 'D5R', 'Parvalbumin', 'FEF', 'R' );
    R_D5R_CalB_by_Layer  = celldensity_by_layer( immuno_struct, 'D5R', 'Calbindin', 'FEF', 'R' );
    R_D5R_CalR_by_Layer  = celldensity_by_layer( immuno_struct, 'D5R', 'Calretinin', 'FEF', 'R' );
    R_D5R_Som_by_Layer   = celldensity_by_layer( immuno_struct, 'D5R', 'Somatostatin', 'FEF', 'R' );
    
    PROP_R_D5R_NeuN_by_Layer  = D5R_NeuN_by_Layer.mean  ./ ( D5R_NeuN_by_Layer.mean  + R_D5R_NeuN_by_Layer.mean);
    PROP_R_D5R_SMI32_by_Layer = D5R_SMI32_by_Layer.mean ./ ( D5R_SMI32_by_Layer.mean + R_D5R_SMI32_by_Layer.mean);
    PROP_R_D5R_NRG_by_Layer   = D5R_NRG_by_Layer.mean   ./ ( D5R_NRG_by_Layer.mean   + R_D5R_NRG_by_Layer.mean);
    PROP_R_D5R_Parv_by_Layer  = D5R_Parv_by_Layer.mean  ./ ( D5R_Parv_by_Layer.mean  + R_D5R_Parv_by_Layer.mean);
    PROP_R_D5R_CalB_by_Layer  = D5R_CalB_by_Layer.mean  ./ ( D5R_CalB_by_Layer.mean  + R_D5R_CalB_by_Layer.mean);
    PROP_R_D5R_CalR_by_Layer  = D5R_CalR_by_Layer.mean  ./ ( D5R_CalR_by_Layer.mean  + R_D5R_CalR_by_Layer.mean);
    PROP_R_D5R_Som_by_Layer   = D5R_Som_by_Layer.mean   ./ ( D5R_Som_by_Layer.mean   + R_D5R_Som_by_Layer.mean);
    
    % REMOVED SMI-32 Because would be double counted. Removed NeuN.
    PROP_R_D5R_cellmat = horzcat( PROP_R_D5R_NRG_by_Layer, [0 0 0 0 0]', PROP_R_D5R_Parv_by_Layer, ...
                           PROP_R_D5R_CalB_by_Layer, PROP_R_D5R_CalR_by_Layer, PROP_R_D5R_Som_by_Layer ); 
   
    % Change NANs to 0                   
    PROP_R_D5R_cellmat(isnan(PROP_R_D5R_cellmat)) = 0 ;
                       
    figure();
    set(gcf, 'Position', [100, 100, 300, 1200])
    TickLabel_FontSize = 12; AxisLabel_FontSize = 14;
    CellLabels = {'Neurogranin', '', 'Parvalbumin', 'Calbindin', 'Calretinin', 'Somatostatin'};
    [layercount celltypecount] = size( PROP_R_D5R_cellmat );
    for i = 1:layercount
        subplot( layercount, 1, i ); 
        %vlineHandle = vline( 10, '-' ); set( vlineHandle, 'Color', [0.8 0.8 0.8] ); hold all;
        barh( (PROP_R_D5R_cellmat( i, : ) .* 100), 'k' ); 
        %legend( CellLabels, 'Location','southoutside','Orientation','horizontal' );
        disp(num2str(sum(PROP_R_D5R_cellmat( i, : ))));
        ylabel( LayerStrings(i) );
        set(gca,'YTickLabel', CellLabels, 'Ydir','reverse', 'FontSize', TickLabel_FontSize, 'FontWeight', 'bold', ...
            'XTick', [0 10 25 50 75 100]);
        box( gca, 'off');
        xlim( [0,100] ); ylim( [0.5, 6.5] );
    end
    xlabel( {'Percentage of D5R+ Neurons', 'by Cell Type'}, 'FontSize', AxisLabel_FontSize, 'FontWeight', 'bold');
    tightfig( gcf );
    %hold off;
    
    %%%% FEF vs dlPFC BY LAYER
    d_D5R_NeuN_by_Layer  = celldensity_by_layer( immuno_struct, 'D5R', 'NeuN', 'dlPFC', 'B' ); 
    d_D5R_SMI32_by_Layer = celldensity_by_layer( immuno_struct, 'D5R', 'SMI-32', 'dlPFC', 'B' );
    d_D5R_NRG_by_Layer   = celldensity_by_layer( immuno_struct, 'D5R', 'Neurogranin', 'dlPFC', 'B' );
    d_D5R_Parv_by_Layer  = celldensity_by_layer( immuno_struct, 'D5R', 'Parvalbumin', 'dlPFC', 'B' );
    d_D5R_CalB_by_Layer  = celldensity_by_layer( immuno_struct, 'D5R', 'Calbindin', 'dlPFC', 'B' );
    d_D5R_CalR_by_Layer  = celldensity_by_layer( immuno_struct, 'D5R', 'Calretinin', 'dlPFC', 'B' );
    d_D5R_Som_by_Layer   = celldensity_by_layer( immuno_struct, 'D5R', 'Somatostatin', 'dlPFC', 'B' );
    
    d_CT_D5R_NeuN_by_Layer  = celldensity_by_layer( immuno_struct, 'D5R', 'NeuN', 'dlPFC', 'C' ); 
    d_CT_D5R_SMI32_by_Layer = celldensity_by_layer( immuno_struct, 'D5R', 'SMI-32', 'dlPFC', 'C' );
    d_CT_D5R_NRG_by_Layer   = celldensity_by_layer( immuno_struct, 'D5R', 'Neurogranin', 'dlPFC', 'C' );
    d_CT_D5R_Parv_by_Layer  = celldensity_by_layer( immuno_struct, 'D5R', 'Parvalbumin', 'dlPFC', 'C' );
    d_CT_D5R_CalB_by_Layer  = celldensity_by_layer( immuno_struct, 'D5R', 'Calbindin', 'dlPFC', 'C' );
    d_CT_D5R_CalR_by_Layer  = celldensity_by_layer( immuno_struct, 'D5R', 'Calretinin', 'dlPFC', 'C' );
    d_CT_D5R_Som_by_Layer   = celldensity_by_layer( immuno_struct, 'D5R', 'Somatostatin', 'dlPFC', 'C' );
    
    d_PROP_D5R_NeuN_by_Layer  = d_D5R_NeuN_by_Layer.mean  ./ ( d_D5R_NeuN_by_Layer.mean  + d_CT_D5R_NeuN_by_Layer.mean);
    d_PROP_D5R_SMI32_by_Layer = d_D5R_SMI32_by_Layer.mean ./ ( d_D5R_SMI32_by_Layer.mean + d_CT_D5R_SMI32_by_Layer.mean);
    d_PROP_D5R_NRG_by_Layer   = d_D5R_NRG_by_Layer.mean   ./ ( d_D5R_NRG_by_Layer.mean   + d_CT_D5R_NRG_by_Layer.mean);
    d_PROP_D5R_Parv_by_Layer  = d_D5R_Parv_by_Layer.mean  ./ ( d_D5R_Parv_by_Layer.mean  + d_CT_D5R_Parv_by_Layer.mean);
    d_PROP_D5R_CalB_by_Layer  = d_D5R_CalB_by_Layer.mean  ./ ( d_D5R_CalB_by_Layer.mean  + d_CT_D5R_CalB_by_Layer.mean);
    d_PROP_D5R_CalR_by_Layer  = d_D5R_CalR_by_Layer.mean  ./ ( d_D5R_CalR_by_Layer.mean  + d_CT_D5R_CalR_by_Layer.mean);
    d_PROP_D5R_Som_by_Layer   = d_D5R_Som_by_Layer.mean   ./ ( d_D5R_Som_by_Layer.mean   + d_CT_D5R_Som_by_Layer.mean);
    
    d_PROP_D5R_cellmat = horzcat( d_PROP_D5R_NeuN_by_Layer, d_PROP_D5R_SMI32_by_Layer, d_PROP_D5R_NRG_by_Layer, d_PROP_D5R_Parv_by_Layer, ...
                           d_PROP_D5R_CalB_by_Layer, d_PROP_D5R_CalR_by_Layer, d_PROP_D5R_Som_by_Layer ); 
       
    figure();
    [layercount celltypecount] = size( d_PROP_D5R_cellmat );
    LayerStrings = {'I', 'II-III', 'IV', 'V', 'VI'};
    CellTypeStrings = {'NeuN', 'SMI-32', 'Neurogranin', 'Parvalbumin', 'Calbindin', 'Calretinin', 'Somatostatin'};
    for i = 1:celltypecount
        
        FEF_dlPFC_CT = horzcat( (PROP_D5R_cellmat( :, i ) .* 100), (d_PROP_D5R_cellmat( :, i ) .* 100));
        
        subplot( celltypecount, 1, i ); 
        barh( FEF_dlPFC_CT );
        ylabel( CellTypeStrings(i) );
        set(gca,'YTickLabel', LayerStrings);
        set(gca,'Ydir','reverse')
    end
    
    
    
end