function resample_hist_pyrNeuron( straps )

    %%% CTB VALUES %%%
    CTB_Only_1 = 40;  D1R_CTB  = 448; 
    D1R_CTB_Total = CTB_Only_1 + D1R_CTB;
    D1R_CTB_Frac = D1R_CTB / D1R_CTB_Total;
    
    CTB_Only_2 = 233; D2R_CTB = 200; 
    D2R_CTB_Total = CTB_Only_2 + D2R_CTB;
    D2R_CTB_Frac = D2R_CTB / D2R_CTB_Total;
        
    %%% NEUROGRANIN VALUES %%%
    D1R_NRG_Total = 1259 + 448;
    D1R_NRG_Frac  = 1259 / D1R_NRG_Total;
    D2R_NRG_Total = 735 + 586;
    D2R_NRG_Frac  = 735 / D2R_NRG_Total;
    
    %%% SMI-32 VALUES %%%
    D1R_SMI_Total = 168 + 1;
    D1R_SMI_Frac = 168/D1R_SMI_Total;
    D2R_SMI_Total = 51+5;
    D2R_SMI_Frac = 51/D2R_SMI_Total;

    
    CTB_ratios = zeros(1,straps);
    NRG_ratios = zeros(1,straps);
    SMI_ratios = zeros(1,straps);

    for i = 1:straps

        D1R_CTB_draw = binornd( D1R_CTB_Total, D1R_CTB_Frac );
        D2R_CTB_draw = binornd( D2R_CTB_Total, D2R_CTB_Frac );
        
        D1R_NRG_draw = binornd( D1R_NRG_Total, D1R_NRG_Frac );
        D2R_NRG_draw = binornd( D2R_NRG_Total, D2R_NRG_Frac );
    
        D1R_SMI_draw = binornd( D1R_SMI_Total, D1R_SMI_Frac );
        D2R_SMI_draw = binornd( D2R_SMI_Total, D2R_SMI_Frac );
        
        curr_CTB_ratio = (D1R_CTB_draw/D1R_CTB_Total) / (D2R_CTB_draw/D2R_CTB_Total);
        curr_NRG_ratio = (D1R_NRG_draw/D1R_NRG_Total) / (D2R_NRG_draw/D2R_NRG_Total);
        curr_SMI_ratio = (D1R_SMI_draw/D1R_SMI_Total) / (D2R_SMI_draw/D2R_SMI_Total);

        CTB_ratios(i) = curr_CTB_ratio;
        NRG_ratios(i) = curr_NRG_ratio;
        SMI_ratios(i) = curr_SMI_ratio;
   
    end    


    figure(); hold on;

    bin_width = 0.03;
    
    [n1, x1] = hist( CTB_ratios, min(CTB_ratios):bin_width:max(CTB_ratios) );
    [n2, x2] = hist( NRG_ratios, min(NRG_ratios):bin_width:max(NRG_ratios) );
    [n3, x3] = hist( SMI_ratios, min(SMI_ratios):bin_width:max(SMI_ratios) );
    
    h1 = bar(x1, n1, 'hist' );
    h2 = bar(x2, n2, 'hist' );
    h3 = bar(x3, n3, 'hist' );

    set( h1, 'FaceColor', [0.635, 0.023, 0.435], 'FaceAlpha', 0.5 );
    set( h2, 'FaceColor', [0.023, 0.101, 0.635], 'FaceAlpha', 0.5 );
    set( h3, 'FaceColor', [0.407, 0.023, 0.635], 'FaceAlpha', 0.5 );

    legend('Extrastriate-Projecting', 'Neurogranin+', 'SMI-32+');
    
    xlabel( '% D1R+ : % D2R+', 'FontSize', 16, 'FontWeight', 'Bold' );
    ylabel( 'Bootstrapped Count', 'FontSize', 16, 'FontWeight', 'Bold' );
    set(gca,'FontSize', 14)
    ylim( [0 3200] );

end