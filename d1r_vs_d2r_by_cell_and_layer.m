function rslt = d1r_vs_d2r_by_cell_and_layer( immuno_struct )

   
    % Loop through each cell type and get D5R/CT and CT_Total by layer
    celltype_list = {'NeuN', 'Neurogranin', 'SMI-32', 'Parvalbumin', 'Calbindin', 'Calretinin', 'Somatostatin'};
    
    Counts_Struct = struct;
    
    for i = 1:length(celltype_list)
       
        celltype = celltype_list(i);
        Counts_Struct(i).celltype = celltype;
        
        D1R_substruct = immuno_struct(strcmp({immuno_struct.Stain1}, 'D1R') & strcmp({immuno_struct.Stain2}, celltype) & strcmp({immuno_struct.Region}, 'FEF'));
        label_string = strcat( 'D1R', {' '}, 'and', {' '}, celltype  );
        
        Counts_Struct(i).D1R_CT_count   = get_count( D1R_substruct, 'B' );
        Counts_Struct(i).D1R_CT_Only_count  = get_count( D1R_substruct, 'C' );
        Counts_Struct(i).D1R_CT_Total_count = get_count( D1R_substruct, 'T' );
        
        Counts_Struct(i).D1R_CT_TotalXLayers = sum( Counts_Struct(i).D1R_CT_count );
        Counts_Struct(i).D1R_CT_Total_TotalXLayers = sum( Counts_Struct(i).D1R_CT_Total_count ); 

        D2R_substruct = immuno_struct(strcmp({immuno_struct.Stain1}, 'D2R') & strcmp({immuno_struct.Stain2}, celltype) & strcmp({immuno_struct.Region}, 'FEF'));
        Counts_Struct(i).D2R_CT_count   = get_count( D2R_substruct, 'B' );
        Counts_Struct(i).D2R_CT_Only_count  = get_count( D2R_substruct, 'C' );
        Counts_Struct(i).D2R_CT_Total_count = get_count( D2R_substruct, 'T' );
        
        Counts_Struct(i).D2R_CT_TotalXLayers = sum( Counts_Struct(i).D2R_CT_count );
        Counts_Struct(i).D2R_CT_Total_TotalXLayers = sum( Counts_Struct(i).D2R_CT_Total_count ); 

        
    end
  
    % Calculate stats compared to SMI-32 values
    NRG_pvals = calc_NRG_pvals( Counts_Struct );
    %Counts_Struct = calc_SMI32_pvals( Counts_Struct );
    
    % Calculate stats compared to (average? across all layers?) values
    %Counts_Struct = calc_vs_CTXLayer_pvals( Counts_Struct );
    
    % Calculate stats of chi sq comparing D5R expression across layers for
    % a given cell type
    %Counts_Struct = calc_X_CTXLayer_pvals( Counts_Struct );

        % NRG vs D1R or vs D2R - ACROSS LAYERS
    D1R_ctx_pvals = [];
    D1R_l2_D1R = Counts_Struct(2).D1R_CT_count(2)';
    D1R_l2_CT  = Counts_Struct(2).D1R_CT_Only_count(2)';

    D2R_ctx_pvals = [];
    D2R_l2_D2R = Counts_Struct(2).D2R_CT_count(2)';
    D2R_l2_CT  = Counts_Struct(2).D2R_CT_Only_count(2)';

    for i = 3:5 % For comparing layer 2 to layers 4, 5 and 6
        D1R_lx_D1R = Counts_Struct(2).D1R_CT_count(i)';
        D1R_lx_CT  = Counts_Struct(2).D1R_CT_Only_count(i)';
        D1R_comp_mat = [ D1R_l2_D1R D1R_l2_CT; ...
                         D1R_lx_D1R D1R_lx_CT];
        D1R_ctx_pvals(i) = general_chi_sq_test(D1R_comp_mat);
        
        D2R_lx_D2R = Counts_Struct(2).D2R_CT_count(i)';
        D2R_lx_CT  = Counts_Struct(2).D2R_CT_Only_count(i)';
        D2R_comp_mat = [ D2R_l2_D2R D2R_l2_CT; ...
                         D2R_lx_D2R D2R_lx_CT];
        D2R_ctx_pvals(i) = general_chi_sq_test(D2R_comp_mat);
    end
    
    
    figure();
    set(gcf, 'Position', [100, 100, 650, 1000])
    
    D1R_NRG_Props = Counts_Struct(2).D1R_CT_count ./ Counts_Struct(2).D1R_CT_Total_count;
    D2R_NRG_Props = Counts_Struct(2).D2R_CT_count ./ Counts_Struct(2).D2R_CT_Total_count;
    %SMI32_Props = Counts_Struct(3).D5R_CT_count ./ Counts_Struct(3).CT_Total_count;

    green_col = [0 0.8 0];
    b = bar( [D1R_NRG_Props' D2R_NRG_Props'] ); b(1).FaceColor = green_col; b(2).FaceColor = 'b';
    
    %%% DR/NRG - Across cortical layers:
    %D1R_l2_D1R = Counts_Struct(2).D1R_CT_count(2:5)';
    %D1R_l2_D1R = Counts_Struct(2).D1R_CT_Only_count(2:5)';
    %D1R_comp_mat = horzcat( Col1, Col2 );
    %D1R_layer_p_val = general_chi_sq_test(D1R_comp_mat);
   
    % Place Lines above Plot
    curr_fig = add_sig_lines( gcf, D1R_NRG_Props, D2R_NRG_Props, NRG_pvals, D1R_ctx_pvals, D2R_ctx_pvals );
    
    % Other Plot Prettiness
    set(gca,'XTickLabel',{'I', 'II-III' 'IV' 'V' 'VI'});
    ylabel( 'Proportion of NRG+ Neurons Expressing Receptor)', 'FontSize', 16, 'FontWeight', 'bold' );
    set(gca,'FontSize',14, 'FontWeight', 'bold');
    legend( 'D1R', 'D2R');
    
% %    ax = subplot(4,2, [7,8]);
% %    set( ax, 'Units', 'pixels' );
%     
% %    hsp1 = get(ax, 'OuterPosition')
% %    hsp1(4) = 5;
% %    set( ax, 'OuterPosition', hsp1 );
%     
% %     set(gca, 'visible', 'off')
% %     get( ax, 'PlotBoxAspectRatio' )
% %     set( ax, 'PlotBoxAspectRatio', [1 1 0.1] );
% %     xlabel( 'Proportion of Neurons Expressing D5R' );
% %     set(findall(gca, 'type', 'text'), 'visible', 'on')
%      
%     %tightfig( gcf );
% 
%     % Fix so saving as pdf will be the right side.
%     resize_paper_for_pdf( gcf );
%     save_out_fig( gcf, 'Fig3_D5R_By_CellType_and_Layer' );

end

function fig = add_sig_lines( fig, D1R_NRG_Props, D2R_NRG_Props, NRG_pvals, D1R_ctx_pvals, D2R_ctx_pvals
    
    pval_strings = get_pval_string(NRG_pvals, 0.05/5);
    text( 1:5, D1R_NRG_Props + 3, pval_strings, 'FontWeight', 'bold', 'FontSize', 11); 
    
end


function rslt = calc_NRG_pvals( Counts_Struct )

    % For each Cell type
    D1R_NRG_counts      = Counts_Struct(2).D1R_CT_count;
    D1R_NRG_Only_counts = Counts_Struct(2).D1R_CT_Only_count; 

    D2R_NRG_counts      = Counts_Struct(2).D2R_CT_count;
    D2R_NRG_Only_counts = Counts_Struct(2).D2R_CT_Only_count; 
        
    p_vals = [];
        
    % Go through each layer
    for j = 1:length( D1R_NRG_counts )
        comp_mat = [ D1R_NRG_counts(j) D1R_NRG_Only_counts(j);
                     D2R_NRG_counts(j) D2R_NRG_Only_counts(j) ];
        % ChiSq vs NeuN
        p_vals(j) = general_chi_sq_test(comp_mat);
    end

    rslt = p_vals;
end        