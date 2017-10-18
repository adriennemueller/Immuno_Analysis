function rslt = d5r_by_cell_and_layer_mark2( immuno_struct )

   
    % Loop through each cell type and get D5R/CT and CT_Total by layer
    celltype_list = {'NeuN', 'Neurogranin', 'SMI-32', 'Parvalbumin', 'Calbindin', 'Calretinin', 'Somatostatin'};
    
    Counts_Struct = struct;
    
    for i = 1:length(celltype_list)
       
        celltype = celltype_list(i);
        Counts_Struct(i).celltype = celltype;
        
        substruct = immuno_struct(strcmp({immuno_struct.Stain1}, 'D5R') & strcmp({immuno_struct.Stain2}, celltype) & strcmp({immuno_struct.Region}, 'FEF'));
        label_string = strcat( 'D5R', {' '}, 'and', {' '}, celltype  );
        
        Counts_Struct(i).D5R_CT_count   = get_count( substruct, 'B' );
        Counts_Struct(i).CT_Only_count  = get_count( substruct, 'C' );
        Counts_Struct(i).CT_Total_count = get_count( substruct, 'T' );
        
        Counts_Struct(i).D5R_CT_TotalXLayers   = sum( Counts_Struct(i).D5R_CT_count );
        Counts_Struct(i).CT_Total_TotalXLayers = sum( Counts_Struct(i).CT_Total_count ); 
        
    end
  
    % Calculate stats compared to SMI-32 values
    Counts_Struct = calc_vs_NRG_pvals( Counts_Struct );
    Counts_Struct = calc_vs_SMI32_pvals( Counts_Struct );
    
    % Calculate stats compared to (average? across all layers?) values
    Counts_Struct = calc_vs_CTXLayer_pvals( Counts_Struct );
    
    % Calculate stats of chi sq comparing D5R expression across layers for
    % a given cell type
    Counts_Struct = calc_X_CTXLayer_pvals( Counts_Struct );

    
    figure();
    set(gcf, 'Position', [100, 100, 650, 1000])
    
    NRG_Props = Counts_Struct(2).D5R_CT_count ./ Counts_Struct(2).CT_Total_count;
    SMI32_Props = Counts_Struct(3).D5R_CT_count ./ Counts_Struct(3).CT_Total_count;


    % Plot indivdually, for each cell type - 
    for i = 1:length( Counts_Struct )
        % Skip NeuN Plot
        if i == 1
            continue
        end
        
        Props = Counts_Struct(i).D5R_CT_count ./ Counts_Struct(i).CT_Total_count;
        LayerStrings = {'I', 'II-III', 'IV', 'V', 'VI'};
        
        subplot(3,2,i-1)
        if i ~= 3 % SKIP NRG Plot
            barh( ([1:5] - 0.1), (SMI32_Props), 'FaceColor', [0.93 0.93 0.93], 'Edgecolor', 'none' );
        end
        hold on;
        barh( (Props), 'FaceColor', get_bar_col(i) );
        hold off;
        
        pval_string_SMI32 = get_pval_string( Counts_Struct(i).VsSMI32_pVals, 50 );
        text( Props +0.05, 1:5, pval_string_SMI32, 'FontWeight', 'bold', 'FontSize', 11); 
        
        TickLabel_FontSize = 12; AxisLabel_FontSize = 14;
        set( gca, 'YTick', [1 2 3 4 5], 'YTickLabel', LayerStrings, 'Ydir','reverse', 'FontSize', TickLabel_FontSize, 'XTick', [0 0.25 0.5 0.75 1], ...
            'FontWeight', 'Bold' ); xlim( [0 1] );
        box( gca, 'off');
        
        xlabel(  strcat( Counts_Struct(i).celltype, '+' ), 'FontSize', AxisLabel_FontSize, 'FontWeight', 'bold' );
        if mod(i,2) == 0
            ylabel( 'Cortical Layer', 'FontSize', AxisLabel_FontSize, 'FontWeight', 'bold' );
        end
        
%         subplot(1,2,2)
%         barh( (Props( i, : ) .* 100) );
%         title( strcat( Counts_Struct(i).celltype, {' '}, 'vs Layer-Agnostic' ) );
%         ylabel( LayerStrings(i) );
%         set(gca,'Ydir','reverse')
%         pval_string_CTSum = get_pval_string( Counts_Struct(i).VsCTSum_pVals );
%         text( Props .* 100 +5, 1:5, pval_string_CTSum, 'FontWeight', 'bold', 'FontSize', 11);


        % Add pval for Across Layer Comparison
        %sigstar( {[2, 5]}, Counts_Struct(i).X_CTXLayer_pval / 6); % Bonferonni Corrected
        text( 0.97, 3.5, get_pval_string( Counts_Struct(i).X_CTXLayer_pval, 4));
        if i == 6
            hold on;
                plot( [0.96 0.96], [1.5, 5.5], '-k', 'LineWidth', 1.5 );
            hold off;
        end

    end
        
%    ax = subplot(4,2, [7,8]);
%    set( ax, 'Units', 'pixels' );
    
%    hsp1 = get(ax, 'OuterPosition')
%    hsp1(4) = 5;
%    set( ax, 'OuterPosition', hsp1 );
    
%     set(gca, 'visible', 'off')
%     get( ax, 'PlotBoxAspectRatio' )
%     set( ax, 'PlotBoxAspectRatio', [1 1 0.1] );
%     xlabel( 'Proportion of Neurons Expressing D5R' );
%     set(findall(gca, 'type', 'text'), 'visible', 'on')
     
    %tightfig( gcf );

    SubFigureLabel_FontSize = 24;
    SubFigLabelBox_A = uicontrol('style','text');
    set(SubFigLabelBox_A,'String','A', 'FontSize', SubFigureLabel_FontSize, 'BackgroundColor', 'white', ...
        'Position', [2, 910, 30, 30]);
    SubFigLabelBox_B = uicontrol('style','text');
    set(SubFigLabelBox_B,'String','B', 'FontSize', SubFigureLabel_FontSize, 'BackgroundColor', 'white', ...
        'Position', [2, 610, 30, 30]);

    X_suplabel_A = uicontrol('style','text');
    set(X_suplabel_A, 'String', 'Proportion of Neurons Expressing D5R', 'FontSize', AxisLabel_FontSize+1, ...
        'FontWeight', 'Bold', 'BackgroundColor', 'white', 'Position', [130, 640, 400, 30]);
    X_suplabel_B = uicontrol('style','text');
    set(X_suplabel_B, 'String', 'Proportion of Neurons Expressing D5R', 'FontSize', AxisLabel_FontSize +1, ...
       'FontWeight', 'Bold', 'BackgroundColor', 'white', 'Position', [130, 35, 400, 30]);
    
    % Fix so saving as pdf will be the right side.
    resize_paper_for_pdf( gcf );
    save_out_fig( gcf, 'Fig3_D5R_By_CellType_and_Layer' );

end

function rslt = get_bar_col( idx )
    if (idx == 2)
        rslt = 'w';
    elseif (idx == 3)
        rslt = [0.93 0.93 0.93];
    else
        rslt = 'k';
    end
end

function rslt = get_pval_string( pvals, bonf_val )
    rslt = {};
    for i = 1:length( pvals )
       if pvals(i) <= 0.001/bonf_val;
           rslt{i} = '***';
       elseif pvals(i) <= 0.01/bonf_val;
           rslt{i} = '**';
       elseif pvals(i) <= 0.05/bonf_val; 
           rslt{i} = '*';
       else
           rslt{i} = []; 
       end        
    end
end

% Make sure rows are layers and columns are D5R_CT and CT_Tot
function rslt = calc_X_CTXLayer_pvals( Counts_Struct )
 
    for i = 1:length(Counts_Struct)
        
        Col1 = Counts_Struct(i).D5R_CT_count(2:5)';
        Col2 = Counts_Struct(i).CT_Only_count(2:5)';
        
        comp_mat = horzcat( Col1, Col2 );

        p_val = general_chi_sq_test(comp_mat);

        Counts_Struct(i).X_CTXLayer_pval = p_val;

    end
    
    rslt = Counts_Struct;

end

function rslt = calc_vs_CTXLayer_pvals( Counts_Struct )
    for i = 1:length(Counts_Struct)
        
        D5R_CT_Sum = Counts_Struct(i).D5R_CT_TotalXLayers;
        CT_Tot_Sum = Counts_Struct(i).CT_Total_TotalXLayers; 

        D5R_CT_counts = Counts_Struct(i).D5R_CT_count;
        CT_Tot_counts = Counts_Struct(i).CT_Total_count;
        
        p_vals = [];
        
        % Go through each layer
        for j = 1:length( D5R_CT_counts )
            comp_mat = [ D5R_CT_Sum CT_Tot_Sum;
                         D5R_CT_counts(j)   CT_Tot_counts(j) ];
            % ChiSq vs NeuN
            p_val(j) = chi_sq_test(comp_mat);
        end

        Counts_Struct(i).VsCTSum_pVals = p_val;
    end
    rslt = Counts_Struct;

end

function rslt = calc_vs_NRG_pvals( Counts_Struct )

    % For each Cell type
    for i = 2:length(Counts_Struct)
        
        D5R_NRG_counts = Counts_Struct(2).D5R_CT_count;
        NRG_Only_counts = Counts_Struct(2).CT_Only_count; 

        D5R_CT_counts = Counts_Struct(i).D5R_CT_count;
        CT_Only_counts = Counts_Struct(i).CT_Only_count;
        
        p_vals = [];
        
    % Go through each layer
        for j = 1:length( D5R_CT_counts )
            comp_mat = [ D5R_NRG_counts(j) NRG_Only_counts(j);
                         D5R_CT_counts(j)   CT_Only_counts(j) ];
            % ChiSq vs NeuN
            p_val(j) = general_chi_sq_test(comp_mat);
        end

        Counts_Struct(i).VsNRG_pVals = p_val;
    end
    rslt = Counts_Struct;
end

function rslt = calc_vs_SMI32_pvals( Counts_Struct )

    ct_compare_list = [2 4 5 6 7];

    % For each Cell type
    for i = 2:length(Counts_Struct)
        
        D5R_SMI32_counts = Counts_Struct(3).D5R_CT_count;
        SMI32_Only_counts = Counts_Struct(3).CT_Only_count; 

        D5R_CT_counts = Counts_Struct(i).D5R_CT_count;
        CT_Only_counts = Counts_Struct(i).CT_Only_count;
        
        p_vals = [];
        
    % Go through each layer
        for j = 1:length( D5R_CT_counts )
            comp_mat = [ D5R_SMI32_counts(j) SMI32_Only_counts(j);
                         D5R_CT_counts(j)   CT_Only_counts(j) ];
            % ChiSq vs NeuN
            p_val(j) = general_chi_sq_test(comp_mat);
        end

        Counts_Struct(i).VsSMI32_pVals = p_val;
    end
    rslt = Counts_Struct;
end


% Get Counts by layer for Receptor/CT or CT_Total.
% Receptor/CT type = 'B';
% CT_Only = 'C'
% Receptor_Only = 'R'
% CT_Total type = 'T'
function rslt = get_count( substruct, type )

    rslt = [0 0 0 0 0];

    for i = 1:length(substruct)
        if ~ isempty( substruct(i).CountsByLayer )
            if strcmp(type, 'R')
                rslt = rslt + substruct(i).CountsByLayer(1,:);
            elseif strcmp( type, 'C')
                rslt = rslt + substruct(i).CountsByLayer(2,:);
            elseif strcmp( type, 'B')
                rslt = rslt + substruct(i).CountsByLayer(3,:);
            elseif strcmp( type, 'T')
                tmp = substruct(i).CountsByLayer(3,:) + substruct(i).CountsByLayer(2,:);
                rslt = rslt + tmp;
            else
                disp( 'Unrecognized type.' );
            end
        end
    end
end

        