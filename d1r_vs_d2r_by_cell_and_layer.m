function rslt = d1r_vs_d2r_by_cell_and_layer( immuno_struct, sel_celltype )

   
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
    
    celltype_idx = find(strcmp(sel_celltype, celltype_list));
  
    % Calculate stats compared to SMI-32 values
    CT_pvals = calc_CT_pvals( Counts_Struct, celltype_idx );
    assignin( 'base', 'CT_pvals', CT_pvals );

    %Counts_Struct = calc_SMI32_pvals( Counts_Struct );
    
    % Calculate stats compared to (average? across all layers?) values
    %Counts_Struct = calc_vs_CTXLayer_pvals( Counts_Struct );
    
    % Calculate stats of chi sq comparing D5R expression across layers for
    % a given cell type
    %Counts_Struct = calc_X_CTXLayer_pvals( Counts_Struct );

        % NRG vs D1R or vs D2R - ACROSS LAYERS
    D1R_ctx_pvals = [];
%     D1R_l2_D1R = Counts_Struct(celltype_idx).D1R_CT_count(2)';
%     D1R_l2_CT  = Counts_Struct(celltype_idx).D1R_CT_Only_count(2)';

    D2R_ctx_pvals = [];
%     D2R_l2_D2R = Counts_Struct(celltype_idx).D2R_CT_count(2)';
%     D2R_l2_CT  = Counts_Struct(celltype_idx).D2R_CT_Only_count(2)';

    for i = 2:4 % For comparing layer 2 to layers 4, 5 and 6, and other layers
        for j = i+1:5
        D1R_lfirst_D1R = Counts_Struct(celltype_idx).D1R_CT_count(i)';
        D1R_lfirst_CT  = Counts_Struct(celltype_idx).D1R_CT_Only_count(i)';
        D1R_lsecond_D1R = Counts_Struct(celltype_idx).D1R_CT_count(j)';
        D1R_lsecond_CT  = Counts_Struct(celltype_idx).D1R_CT_Only_count(j)';
        
        D1R_comp_mat = [ D1R_lfirst_D1R D1R_lfirst_CT; ...
                         D1R_lsecond_D1R D1R_lsecond_CT];
        D1R_ctx_pvals = [D1R_ctx_pvals general_chi_sq_test(D1R_comp_mat)];
        
        D2R_lfirst_D2R = Counts_Struct(celltype_idx).D2R_CT_count(i)';
        D2R_lfirst_CT  = Counts_Struct(celltype_idx).D2R_CT_Only_count(i)';
        D2R_lsecond_D2R = Counts_Struct(celltype_idx).D2R_CT_count(j)';
        D2R_lsecond_CT  = Counts_Struct(celltype_idx).D2R_CT_Only_count(j)';
        D2R_comp_mat = [ D2R_lfirst_D2R D2R_lfirst_CT; ...
                         D2R_lsecond_D2R D2R_lsecond_CT];
        D2R_ctx_pvals = [D2R_ctx_pvals general_chi_sq_test(D2R_comp_mat)];
        end
    end

    assignin( 'base', 'D1R_ctx_pvals', D1R_ctx_pvals );
    assignin( 'base', 'D2R_ctx_pvals', D2R_ctx_pvals );
    fig = figure();
    
    D1R_CT_Props = Counts_Struct(celltype_idx).D1R_CT_count ./ Counts_Struct(celltype_idx).D1R_CT_Total_count;
    D2R_CT_Props = Counts_Struct(celltype_idx).D2R_CT_count ./ Counts_Struct(celltype_idx).D2R_CT_Total_count;
    %SMI32_Props = Counts_Struct(3).D5R_CT_count ./ Counts_Struct(3).CT_Total_count;

    gray_col = [0.8 0.8 0.8];
    if strcmp( sel_celltype, 'Neurogranin' )
        left_color = [0 0 0];
        right_color = [0.4 0.4 0.4];
        set(fig,'defaultAxesColorOrder',[left_color; right_color]);
        
        yyaxis left;
        b = bar( [D1R_CT_Props' D2R_CT_Props'] ); b(1).FaceColor = 'k'; b(2).FaceColor = gray_col;
        d1r_d2r_ratio = D1R_CT_Props' ./ D2R_CT_Props';
        assignin( 'base', 'd1r_d2r_ratio', d1r_d2r_ratio  );
        hold on
        yyaxis right;
        plot(1:5, d1r_d2r_ratio, 'LineWidth', 2);
        set(gca, 'YLim', [0 2.75]); yticks( 0:0.5:2);
        ylabel( {'Ratio of D1R+ / D2R+ Neurons'} );
        hold off
    else
        b = bar( [D1R_CT_Props' D2R_CT_Props'] ); b(1).FaceColor = 'k'; b(2).FaceColor = gray_col;
    end
    
    
    %%% DR/NRG - Across cortical layers:
    %D1R_l2_D1R = Counts_Struct(2).D1R_CT_count(2:5)';
    %D1R_l2_D1R = Counts_Struct(2).D1R_CT_Only_count(2:5)';
    %D1R_comp_mat = horzcat( Col1, Col2 );
    %D1R_layer_p_val = general_chi_sq_test(D1R_comp_mat);
   
    % Place Lines above Plot
    % Add D1R/D2R Comp lines
    bwidth = get(b, 'BarWidth');
    vertspace = 0.03;
    higher_props = max( [D1R_CT_Props; D2R_CT_Props] );
    
    yyaxis left;

    for i = 2:5
        leftx  = i - bwidth{1}/4;
        rightx = i + bwidth{1}/4;
        line( [leftx rightx], [ higher_props(i) higher_props(i) ] + vertspace, 'LineWidth', 1, 'Color', 'black' );
    end
    pval_strings = get_pval_string(CT_pvals, 5);
    text( 1:5, higher_props + vertspace + vertspace/2.5, pval_strings, 'FontWeight', 'bold', 'FontSize', 8, 'HorizontalAlignment', 'Center');
  
    %%% Add Green D1R Lines
%     d1_leftx = 2 - bwidth{1}/4;
%     d2_leftx = 2 + bwidth{1}/4;
%     top_of_bar = max( [D1R_CT_Props, D2R_CT_Props] );
%     for i = 3:5
%         d1_rightx = i - bwidth{1}/4;
%         line( [d1_leftx d1_rightx], [ top_of_bar top_of_bar ] + i * vertspace, ...
%               'LineWidth', 3, 'Color', green_col );
%         d1r_pval_string = get_pval_string( D1R_ctx_pvals(i), 3);
%         text( ((d1_leftx + d1_rightx) / 2), (top_of_bar + i * vertspace + vertspace/2.5), d1r_pval_string, 'FontWeight', 'bold', 'FontSize', 11, 'HorizontalAlignment', 'Center', 'Color', green_col);
%           
%           
%         d2_rightx = i + bwidth{1}/4;
%         line( [d2_leftx d2_rightx], [ top_of_bar top_of_bar ] + (i+3) * vertspace, ...
%               'LineWidth', 3, 'Color', 'blue' );
%         d2r_pval_string = get_pval_string( D2R_ctx_pvals(i), 3);
%         text( ((d2_leftx + d2_rightx) / 2), (top_of_bar + (i+3) * vertspace + vertspace/2.5), d2r_pval_string, 'FontWeight', 'bold', 'FontSize', 11, 'HorizontalAlignment', 'Center', 'Color', 'blue');
%         
%     end     
    

    yyaxis left;
    % Other Plot Prettiness
    set(gcf, 'Units', 'centimeters' );
    set(gcf, 'Position', [30, 30, 8.6, 7.2])
    set(gca, 'box', 'off' );
    
    set(gca,'XTickLabel',{'I', 'II-III' 'IV' 'V' 'VI'});
    ylab_topline = strcat( 'Proportion of', {' '}, sel_celltype, {'+ '});
    ylabel( {ylab_topline{1}; 'Neurons Expressing Receptor'}, 'FontSize', 12, 'FontWeight', 'bold' );
    set(gca,'FontSize',10, 'FontWeight', 'bold');
    legend( 'D1R', 'D2R', 'Location', 'northwest');
    ylim(gca,[ 0 1.4]); yticks( [0.2, 0.4, 0.6, 0.8, 1]);
    xlabel( 'Layer' );
 
    tightfig( gcf );

    % Fix so saving as pdf will be the right size.
    resize_paper_for_pdf( gcf );
    save_out_fig( gcf, strcat('Fig1_D1R_D2R_', sel_celltype, '_Proportions_By_Layer') );

end

function rslt = calc_CT_pvals( Counts_Struct, ct_idx )

    % For each Cell type
    D1R_CT_counts      = Counts_Struct(ct_idx).D1R_CT_count;
    D1R_CT_Only_counts = Counts_Struct(ct_idx).D1R_CT_Only_count; 

    D2R_CT_counts      = Counts_Struct(ct_idx).D2R_CT_count;
    D2R_CT_Only_counts = Counts_Struct(ct_idx).D2R_CT_Only_count; 
        
    p_vals = [];
        
    % Go through each layer
    for j = 1:length( D1R_CT_counts )
        comp_mat = [ D1R_CT_counts(j) D1R_CT_Only_counts(j);
                     D2R_CT_counts(j) D2R_CT_Only_counts(j) ];
        % ChiSq vs NeuN
        p_vals(j) = general_chi_sq_test(comp_mat);
    end

    rslt = p_vals;
end        