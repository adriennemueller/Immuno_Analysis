function receptor_by_layer( immunostruct )
    
    celltype_list = {'NeuN', 'Neurogranin', 'Rat-Pyramidal', 'SMI-32', 'Parvalbumin', 'Calbindin', 'Calretinin', 'Somatostatin'};
    receptor_list = {'Alpha1AR', 'Alpha2AR', 'Beta1R', 'Beta2R'};
    
    Counts_Struct = struct;
    
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
        
        fig = figure();
        b = bar( Props' *100 );
       
        ylim( [0 120] ); set(gca, 'ytick', [0:20:100]);
        %set(gca,'XTickLabel',{'SMI-32','Neurogranin'});
        set(gca,'XTickLabel',{'I', 'II-III', 'IV', 'V', 'VI'});
        title( celltype, 'FontSize', 14, 'FontWeight', 'bold' );
        ylabel( {'% of Neurons with'; 'Receptor Type'}, 'FontSize', 12, 'FontWeight', 'bold' );
        set(gca,'FontSize',10, 'FontWeight', 'bold');
        legend( 'Alpha1AR', 'Alpha2AR', 'Beta1R', 'Beta2R');
    
        saveas( gcf, strcat(celltype{1}, '_by_layer'), 'png' );

         
    end
    

end    
   
