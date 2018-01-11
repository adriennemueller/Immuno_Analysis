%%% D1R CTB vs NRG
function p_val =  gen_CTB_vs_NRG_stats( immuno_struct )
    
    % Get Tracer numbers
    ts = gen_tracer_struct();

    D1RPos_CTB_Total = ts.D1RPos_Total;
    D1RNeg_CTB_Total = ts.D1RNeg_Total;
        
    % Get NRG numbers
    substruct = immuno_struct(strcmp({immuno_struct.Stain1}, 'D1R') & strcmp({immuno_struct.Stain2}, 'Neurogranin') & strcmp({immuno_struct.Region}, 'FEF'));
    D1R_NRG_count   = get_count( substruct, 'B' );
    NRG_Only_count  = get_count( substruct, 'C' );
    NRG_Total_count = get_count( substruct, 'T' );
        
    D1R_NRG_TotalXLayers   = sum( D1R_NRG_count );
    NRG_Only_TotalXLayers  = sum( NRG_Only_count );     
    NRG_Total_TotalXLayers = sum( NRG_Total_count );
    
    comp_mat = [D1RPos_CTB_Total        D1RNeg_CTB_Total;
                D1R_NRG_TotalXLayers    NRG_Only_TotalXLayers];
    
    p_val = general_chi_sq_test(comp_mat);
     
    
    D1R_CTB_Frac =  D1RPos_CTB_Total / ts.D1RCount_Total;
    D1R_NRG_Frac =  D1R_NRG_TotalXLayers / NRG_Total_TotalXLayers;
  
    figure();
    set(gcf, 'Position', [500, 500, 550, 500])
    bar([D1R_CTB_Frac*100, D1R_NRG_Frac*100], 'k' );
    sigstar({[1,2]}, p_val);
    
    TickLabel_FontSize = 14; AxisLabel_FontSize = 16;
        
    set( gca, 'YTick', [0 25 50 75 90 100], 'XTickLabel', {'CTB', 'NRG'}, 'FontSize', TickLabel_FontSize,  ...
            'FontWeight', 'Bold' ); xlim([0.2 2.8]); ylim( [0 100] ); box( gca, 'off');
    ylabel( {'Expression of D1R on Pyramidal Neurons (%)'}, 'FontSize', AxisLabel_FontSize, 'FontWeight', 'bold' );
            
    text( 1.15, 3, strcat( 'N = ', {' '}, num2str(D1RPos_CTB_Total)), 'Color', 'w', 'FontWeight', 'bold', 'FontSize', 11); 
    text( 2.15, 3, strcat( 'N = ', {' '}, num2str(D1R_NRG_TotalXLayers)), 'Color', 'w', 'FontWeight', 'bold', 'FontSize', 11); 
    
    
end
