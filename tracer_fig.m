function rslt = tracer_fig( immuno_struct )

    CTB_Only_1 = 40;  D1R_CTB  = 448; D1R_CTB_Total = CTB_Only_1 + D1R_CTB;
    CTB_Only_2 = 233; D2R_CTB = 200;  D2R_CTB_Total = CTB_Only_2 + D2R_CTB;
    CTB_Only_5 = 2;   D5R_CTB = 89;   D5R_CTB_Total = CTB_Only_5 + D5R_CTB;
    
    % Receptor / Pyramidals
    NRG_Only_1 = celldensity_by_layer( immuno_struct, 'D1R', 'Neurogranin', 'FEF', 'C' ); NRG_Only_1 = NRG_Only_1.n_cells;
    D1R_NRG = celldensity_by_layer( immuno_struct, 'D1R', 'Neurogranin', 'FEF', 'B' ); D1R_NRG = D1R_NRG.n_cells;
    D1R_NRG_Total = NRG_Only_1 + D1R_NRG;
    
    NRG_Only_2 = celldensity_by_layer( immuno_struct, 'D2R', 'Neurogranin', 'FEF', 'C' );  NRG_Only_2 = NRG_Only_2.n_cells;
    D2R_NRG = celldensity_by_layer( immuno_struct, 'D2R', 'Neurogranin', 'FEF', 'B' ); D2R_NRG = D2R_NRG.n_cells;
    D2R_NRG_Total = NRG_Only_2 + D2R_NRG;
    
    NRG_Only_5 = celldensity_by_layer( immuno_struct, 'D5R', 'Neurogranin', 'FEF', 'C' ); NRG_Only_5 = NRG_Only_5.n_cells;
    D5R_NRG = celldensity_by_layer( immuno_struct, 'D5R', 'Neurogranin', 'FEF', 'B' ); D5R_NRG = D5R_NRG.n_cells;
    D5R_NRG_Total = NRG_Only_5 + D5R_NRG;
    
    
    % Receptor / SMI-32s
    SMI32_Only_1 = celldensity_by_layer( immuno_struct, 'D1R', 'SMI-32', 'FEF', 'C' ); SMI32_Only_1 = SMI32_Only_1.n_cells;
    D1R_SMI32 = celldensity_by_layer( immuno_struct, 'D1R', 'SMI-32', 'FEF', 'B' ); D1R_SMI32 = D1R_SMI32.n_cells;
    D1R_SMI32_Total = SMI32_Only_1 + D1R_SMI32;
    
    SMI32_Only_2 = celldensity_by_layer( immuno_struct, 'D2R', 'SMI-32', 'FEF', 'C' ); SMI32_Only_2 = SMI32_Only_2.n_cells;
    D2R_SMI32 = celldensity_by_layer( immuno_struct, 'D2R', 'SMI-32', 'FEF', 'B' ); D2R_SMI32 = D2R_SMI32.n_cells;
    D2R_SMI32_Total = SMI32_Only_2 + D2R_SMI32;
    
    SMI32_Only_5 = celldensity_by_layer( immuno_struct, 'D5R', 'SMI-32', 'FEF', 'C' ); SMI32_Only_5 = SMI32_Only_5.n_cells;
    D5R_SMI32 = celldensity_by_layer( immuno_struct, 'D5R', 'SMI-32', 'FEF', 'B' ); D5R_SMI32 = D5R_SMI32.n_cells;
    D5R_SMI32_Total = SMI32_Only_5 + D5R_SMI32;
    
    
    % Chi-Sq
    D1R_Pyr_table = [CTB_Only_1 D1R_CTB; NRG_Only_1 D1R_NRG];
    D1R_Pyr_pval = general_chi_sq_test( D1R_Pyr_table );
    
    D1R_SMI_table = [CTB_Only_1 D1R_CTB; SMI32_Only_1 D1R_SMI32];
    D1R_SMI32_pval = general_chi_sq_test( D1R_SMI_table );
    

    D2R_Pyr_table = [CTB_Only_2 D2R_CTB; NRG_Only_2 D2R_NRG];
    D2R_Pyr_pval = general_chi_sq_test( D2R_Pyr_table );
    
    D2R_SMI_table = [CTB_Only_2 D2R_CTB; SMI32_Only_2 D2R_SMI32];
    D2R_SMI32_pval = general_chi_sq_test( D2R_SMI_table );

    
    D5R_Pyr_table = [CTB_Only_5 D5R_CTB; NRG_Only_5 D5R_NRG];
    D5R_Pyr_pval = general_chi_sq_test( D5R_Pyr_table );
    
    D5R_SMI_table = [CTB_Only_5 D5R_CTB; SMI32_Only_5 D5R_SMI32];
    D5R_SMI32_pval = general_chi_sq_test( D5R_SMI_table );

    
    % Bar-Plot w. Signif
    D1R_bars = [D1R_CTB / D1R_CTB_Total, D1R_NRG / D1R_NRG_Total, D1R_SMI32 / D1R_SMI32_Total ];    
    figure(); bar( D1R_bars );
    sigstar({[1,2],[1,3]},[ D1R_Pyr_pval, D1R_SMI32_pval ]);
    
    D2R_bars = [D2R_CTB / D2R_CTB_Total, D2R_NRG / D2R_NRG_Total, D2R_SMI32 / D2R_SMI32_Total ];
    figure(); bar( D2R_bars );
    sigstar({[1,2],[1,3]},[ D2R_Pyr_pval, D2R_SMI32_pval ]);
    
    D5R_bars = [D5R_CTB / D5R_CTB_Total, D5R_NRG / D5R_NRG_Total, D5R_SMI32 / D5R_SMI32_Total ];
    figure(); bar( D5R_bars );
    sigstar({[1,2],[1,3]},[ D5R_Pyr_pval, D5R_SMI32_pval ]);

end