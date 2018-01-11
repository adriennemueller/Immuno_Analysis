% Small function just to make figure for Tirin's SfN Talk.

function gen_tracer_barplot()

    ts = gen_tracer_struct(); %Tracer_struct
    
    D1RPos_Total = ts.D1RPos_Total;
    D1RNeg_Total = ts.D1RNeg_Total;
    D2RPos_Total = ts.D2RPos_Total;
    D2RNeg_Total = ts.D2RNeg_Total;
    
    Expression_Mat = [ D1RPos_Total D1RNeg_Total;
                       D2RPos_Total D2RNeg_Total ];
                    

    pval = general_chi_sq_test( Expression_Mat );
    
    D1R_Frac =  D1RPos_Total / D1RCount_Total;
    D2R_Frac =  D2RPos_Total / D2RCount_Total;
    
        
    figure();
    set(gcf, 'Position', [500, 500, 550, 500])
    bar([D1R_Frac*100, D2R_Frac*100], 'k' );
    sigstar({[1,2]}, pval);
    
    TickLabel_FontSize = 14; AxisLabel_FontSize = 16;
        
    set( gca, 'YTick', [0 25 50 75 90 100], 'XTickLabel', {'D1R', 'D2R'}, 'FontSize', TickLabel_FontSize,  ...
            'FontWeight', 'Bold' ); xlim([0.2 2.8]); ylim( [0 100] ); box( gca, 'off');
    ylabel( {'Expression on Retrogradely-Labeled FEF Neurons (%)'}, 'FontSize', AxisLabel_FontSize, 'FontWeight', 'bold' );
            
    text( 2.5, 97, 'p < 1e^{-10} ', 'FontWeight', 'bold', 'FontSize', 11); % Change if p changes.
    text( 1.15, 3, strcat( 'N = ', {' '}, num2str(D1RCount_Total)), 'Color', 'w', 'FontWeight', 'bold', 'FontSize', 11); 
    text( 2.15, 3, strcat( 'N = ', {' '}, num2str(D2RCount_Total)), 'Color', 'w', 'FontWeight', 'bold', 'FontSize', 11); 
    
    
end