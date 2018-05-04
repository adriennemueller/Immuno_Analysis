% Small function just to make figure for Tirin's SfN Talk.

function gen_tracer_barplot()

    ts = gen_tracer_struct(); %Tracer_struct
    
    D1RPos_Total = ts.D1RPos_Total;
    D1RNeg_Total = ts.D1RNeg_Total;
    D2RPos_Total = ts.D2RPos_Total;
    D2RNeg_Total = ts.D2RNeg_Total;
    D1RCount_Total = ts.D1RCount_Total;
    D2RCount_Total = ts.D2RCount_Total;
    
    Expression_Mat = [ D1RPos_Total D1RNeg_Total;
                       D2RPos_Total D2RNeg_Total ];
                    

    pval = general_chi_sq_test( Expression_Mat );
    
    D1R_Frac =  D1RPos_Total / D1RCount_Total;
    D2R_Frac =  D2RPos_Total / D2RCount_Total;
    
        
    figure();
    gray_col = [0.8 0.8 0.8];
    set(gcf, 'Position', [500, 500, 550, 500])
    bar(1, D1R_Frac*100, 'k' );
    hold on;
    bar(2, D2R_Frac*100,'FaceColor', gray_col );
    sigstar({[1,2]}, pval);
    
     
    
    TickLabel_FontSize = 10; AxisLabel_FontSize = 12;
        
    set( gca, 'YTick', [0 25 50 75 90 100], 'XTick', [1, 2], 'XTickLabel', {'D1R', 'D2R'}, 'FontSize', TickLabel_FontSize,  ...
            'FontWeight', 'Bold' ); xlim([0.2 2.8]); ylim( [0 100] ); box( gca, 'off');
    ylabel( {'Expression on', 'Retrogradely-Labeled', 'FEF Neurons (%)'}, 'FontSize', AxisLabel_FontSize, 'FontWeight', 'bold' );
            
    text( 2.2, 97, 'p < 1e^{-10} ', 'FontWeight', 'bold', 'FontSize', 8); % Change if p changes.
    text( 0.86, 3, strcat( 'N = ', {' '}, num2str(D1RCount_Total)), 'Color', 'w', 'FontWeight', 'bold', 'FontSize', 8); 
    text( 1.86, 3, strcat( 'N = ', {' '}, num2str(D2RCount_Total)), 'Color', 'w', 'FontWeight', 'bold', 'FontSize', 8); 
    
    set(gcf, 'Units', 'centimeters' );
    set(gcf, 'Position', [30, 30, 8.6, 7.2])
    set(gca, 'box', 'off' );
    tightfig( gcf );
    resize_paper_for_pdf( gcf );
    save_out_fig( gcf, strcat('Fig10_D1R_D2R_Tracer_Proportions') );
end