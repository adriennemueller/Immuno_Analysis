function rslt = d5r_by_cell_and_layer_mark2( immuno_struct )

   
    % Loop through each cell type and get D5R/CT and CT_Total by layer
    celltype_list = {'NeuN', 'SMI-32', 'Neurogranin', 'Parvalbumin', 'Calbindin', 'Calretinin', 'Somatostatin'};
    
    Counts_Struct = struct;
    
    for i = 1:length(celltype_list)
       
        celltype = celltype_list(i);
        Counts_Struct(i).celltype = celltype;
        
        substruct = immuno_struct(strcmp({immuno_struct.Stain1}, 'D5R') & strcmp({immuno_struct.Stain2}, celltype) & strcmp({immuno_struct.Region}, 'FEF'));
        label_string = strcat( 'D5R', {' '}, 'and', {' '}, celltype  );
        
        Counts_Struct(i).D5R_CT_count   = get_count( substruct, 'B' );
        Counts_Struct(i).CT_Total_count = get_count( substruct, 'T' );
        
        Counts_Struct(i).D5R_CT_TotalXLayers   = sum( Counts_Struct(i).D5R_CT_count );
        Counts_Struct(i).CT_Total_TotalXLayers = sum( Counts_Struct(i).CT_Total_count ); 
        
    end
  
    % Calculate stats compared to NeuN values
    Counts_Struct = calc_vs_NeuN_pvals( Counts_Struct );
    
    % Calculate stats compared to (average? across all layers?) values
    Counts_Struct = calc_vs_CTXLayer_pvals( Counts_Struct );

    
    figure();
    set(gcf, 'Position', [100, 100, 650, 1000])
    
    NeuN_Props = Counts_Struct(1).D5R_CT_count ./ Counts_Struct(1).CT_Total_count;

    % Plot indivdually, for each cell type - 
    for i = 1:length( Counts_Struct )
        % Skip NeuN Plot
        if i == 1
            continue
        end
        
        Props = Counts_Struct(i).D5R_CT_count ./ Counts_Struct(i).CT_Total_count;
        LayerStrings = {'I', 'II-III', 'IV', 'V', 'VI'};
        
        subplot(3,2,i-1)
        barh( ([1:5] - 0.1), (NeuN_Props .* 100), 'FaceColor', [0.93 0.93 0.93], 'Edgecolor', 'none' );
        hold on;
        barh( (Props .* 100), get_bar_col(i) );
        hold off;
        
        pval_string_NeuN = get_pval_string( Counts_Struct(i).VsNeuN_pVals );
        text( Props .* 100 +5, 1:5, pval_string_NeuN, 'FontWeight', 'bold', 'FontSize', 11); 
        
        TickLabel_FontSize = 12; AxisLabel_FontSize = 14;
        set( gca, 'YTick', [1 2 3 4 5], 'YTickLabel', LayerStrings, 'Ydir','reverse', 'FontSize', TickLabel_FontSize, 'XTick', [0 25 50 75 100], ...
            'FontWeight', 'Bold' ); xlim( [0 100] );
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
        

    end
    
    [ax, h1] = suplabel( 'Proportion of Neurons Expressing D5R', 'x' );
    set(h1, 'FontSize', AxisLabel_FontSize + 2, 'FontWeight', 'Bold' );
    tightfig( gcf );

end

function rslt = get_bar_col( idx )
    if (idx == 2) || (idx == 3)
        rslt = 'w';
    else
        rslt = 'k';
    end
end

function rslt = get_pval_string( pvals )
    rslt = {};
    for i = 1:length( pvals )
       if pvals(i) <= 0.001/50;
           rslt{i} = '***';
       elseif pvals(i) <= 0.01/50;
           rslt{i} = '**';
       elseif pvals(i) <= 0.05/50;  % Opportunity to Bonf. correct
           rslt{i} = '*';
       else
           rslt{i} = []; 
       end        
    end
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

function rslt = calc_vs_NeuN_pvals( Counts_Struct )

    % For each Cell type
    for i = 2:length(Counts_Struct)
        
        D5R_NeuN_counts = Counts_Struct(1).D5R_CT_count;
        NeuN_Tot_counts = Counts_Struct(1).CT_Total_count; 

        D5R_CT_counts = Counts_Struct(i).D5R_CT_count;
        CT_Tot_counts = Counts_Struct(i).CT_Total_count;
        
        p_vals = [];
        
    % Go through each layer
        for j = 1:length( D5R_CT_counts )
            comp_mat = [ D5R_NeuN_counts(j) NeuN_Tot_counts(j);
                         D5R_CT_counts(j)   CT_Tot_counts(j) ];
            % ChiSq vs NeuN
            p_val(j) = chi_sq_test(comp_mat);
        end

        Counts_Struct(i).VsNeuN_pVals = p_val;
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

        