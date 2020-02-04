function fig = receptor_by_layer_singlefig( immunostruct )
    
    celltype_list = { 'Neurogranin', 'Rat-Pyramidal', 'SMI-32', 'Parvalbumin', 'Calbindin', 'Calretinin'};
    receptor_list = {'Alpha1AR', 'Alpha2AR', 'Beta1R', 'Beta2R'};
    
    Counts_Struct = struct;
    
    fig = figure();
    
    for i = 1:length(celltype_list)
       
        celltype = celltype_list(i);
        %Counts_Struct(i).celltype = celltype;
        
        for j = 1:length(receptor_list)
            
            receptor = receptor_list(j);
            R_substruct = immunostruct(strcmp({immunostruct.Stain1}, receptor) & strcmp({immunostruct.Stain2}, celltype) & strcmp({immunostruct.Region}, 'FEF'));
            label_string = strcat( receptor, {' '}, 'and', {' '}, celltype  );
        
            Counts_Struct(i,j).R_CT_count       = get_count( R_substruct, 'B' );
            Counts_Struct(i,j).R_CT_Only_count  = get_count( R_substruct, 'C' );
            Counts_Struct(i,j).R_CT_Total_count = get_count( R_substruct, 'T' );
        
            Counts_Struct(i,j).R_CT_TotalXLayers       = sum( Counts_Struct(i).R_CT_count );
            Counts_Struct(i,j).R_CT_Total_TotalXLayers = sum( Counts_Struct(i).R_CT_Total_count ); 
        
            Counts_Struct(i,j).R_CT_mean_ste      = get_bylayer_mean_ste( R_substruct, 'B', 'T' );
            Counts_Struct(i,j).R_CT_Only_mean_ste = get_bylayer_mean_ste( R_substruct, 'C', 'T' );
        
            Counts_Struct(i,j).R_CT_Props = Counts_Struct(i,j).R_CT_count ./ Counts_Struct(i,j).R_CT_Total_count;

            % Set proportion to 0 if total count less than 2.
            R_low_count_idxs = find(Counts_Struct(i,j).R_CT_Total_count <= 2);
            Counts_Struct(i,j).R_CT_Props(R_low_count_idxs) = 0;

        end
        
        Props = vertcat(Counts_Struct(i,:).R_CT_Props);
        
        subplot( 6, 1, i )
        b = bar( Props' *100 );
       
        for j = 1:4
            if i < 4 % First three plots are excitatory
                b(j).FaceColor = get_bar_facecolor( 'excit', j );
            else
                b(j).FaceColor = get_bar_facecolor( 'inhib', j );
            end
        end

        ylim( [0 120] ); set(gca, 'ytick', [0:20:100]);
        title( celltype, 'FontSize', 16, 'FontWeight', 'bold' );
        set(gca,'FontSize',10, 'FontWeight', 'bold');
        set(gca, 'box', 'off' );
       
        if i < 6, set(gca,'XTickLabel',{});
        else, set(gca,'XTickLabel',{'I', 'II-III', 'IV', 'V', 'VI'});
        end
    end
    
    [ax1, h1] = suplabel( { '% of Neurons with Receptor Type'}, 'y');%
    set( h1, 'FontSize', 14, 'FontWeight', 'bold' );
    
    [ax2, h2] = suplabel( 'Layer', 'x');
    set( h2, 'FontSize', 14, 'FontWeight', 'bold' );
    
    legend( 'Alpha1AR', 'Alpha2AR', 'Beta1R', 'Beta2R');
    
    set(gcf, 'Units', 'centimeters' );
    set(gcf, 'Position', [5, 5, 16.6, 30.2]);
    tightfig( gcf );
    resize_paper_for_pdf( gcf );
    save_out_fig( gcf, strcat('Proportions_by_Layer') );


end    



   
