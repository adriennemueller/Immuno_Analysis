% FEF and dlPFC side-by-side bar plot

% D5R plot - show bar plot of D5R on different cell types, NeuN and others.
% D1R, D2R Quantificaton
% Four subplots, Top Left = D1R on pyr; Top Right = D2R on pyr; Bottom Left D1R on Inhbitory Neurons; Bottom Right: D2R on inhibitory neurons 

function rslt = fef_and_dlPFC_Mark2( immuno_struct )

    ReceptorList = {'D1R', 'D2R'};
    CelltypeList = {'SMI-32', 'Parvalbumin', 'Calretinin', 'Neurogranin', 'Calbindin', 'Somatostatin'};
    Regions = {'FEF', 'dlPFC'};
    
    l1 = length(ReceptorList);
    l2 = length(CelltypeList);
    
    FEF_Color   = [ 0 0.8 0; 0 0 1];
    dlPFC_Color = [ 0 0.4 0; 0 0 0.4];
    

    % Loop through D1R and D2R
    for i = 1:length( ReceptorList )
        
        figure(); hold on; subplot_num = 1;
        set(gcf, 'Position', [100, 100, 1400, 800]);
        
        % Loop through Cell types
        for j = 1:length( CelltypeList )
            
            
            % Plot dlPFC vs FEF Density by Depth with Insets
            subplot(2,3,subplot_num);

            [FEF_Data_Avg, FEF_Data_STE] = celldensity_by_depth( immuno_struct, ReceptorList(i), CelltypeList(j), 'FEF', 'B', 1 );    
            [dlPFC_Data_Avg, dlPFC_Data_STE] = celldensity_by_depth( immuno_struct, ReceptorList(i), CelltypeList(j), 'dlPFC', 'B', 1 );
            shadedErrorBar( [], FEF_Data_Avg, FEF_Data_STE, {'Color', FEF_Color(i,:)}, 0.5); hold on;
            shadedErrorBar( [], dlPFC_Data_Avg, dlPFC_Data_STE, {'Color', dlPFC_Color(i,:)}, 0.5); hold off;
            
            xlabel('Normalized Distance from Pial Surface', 'FontSize', 12, 'FontWeight', 'bold');
            ylabel(strcat( ReceptorList(i), {' '}, {'/'}, {' '}, CelltypeList(j), {' '}, 'Cell Density (um^{-2})'), 'FontSize', 12, 'FontWeight', 'bold');
            set(gca,'XTick',[0:500:1000]);
            set(gca,'XTickLabel', {'0', '0.5', '1'})
    
            % create smaller axes in top right, and plot on it
            
            % Position = x y width length
            curr_ax_pos = get( gca, 'Position' );
            inset_width = 0.06; inset_height = 0.08; inset_buff = 0.01;
            inset_x = curr_ax_pos(1) + curr_ax_pos(3) - inset_width - inset_buff;
            inset_y = curr_ax_pos(2) + curr_ax_pos(4) - inset_height - inset_buff;
            
            %axes('Position',[.7 .7 .2 .2])
            axes('Position', [inset_x inset_y inset_width inset_width])
            box on;
            
            % Get Data: Extract averages for each element across animals
            FEF_AVG    = avg_X_animals( immuno_struct, ReceptorList(i), CelltypeList(j), 'FEF' );
            dlPFC_AVG  = avg_X_animals( immuno_struct, ReceptorList(i), CelltypeList(j), 'dlPFC' );
            
            bar(1, FEF_AVG, 'FaceColor', FEF_Color(i,:)); hold on;
            bar(2, dlPFC_AVG, 'FaceColor', dlPFC_Color(i,:)); hold off;

            ylim( [0 100] ); set(gca, 'ytick', [0:20:100]);
            set(gca,'XTick',[1,2]);
            set(gca,'XTickLabel',{'FEF', 'dlPFC'});
            ylabel( '% of Neurons', 'FontSize', 8, 'FontWeight', 'bold' );
            set(gca,'FontSize',8, 'FontWeight', 'bold');
            
            
            % Add signif data:
            CMH_cell_mat = gen_CMH_cell_mat( immuno_struct, strcat(ReceptorList(i),'_Region'), CelltypeList(j) );
            CMH_pval = cochran_mantel_haenszel_test( CMH_cell_mat, 1 );
            
            %xpos1 = [b(1).XData(1)];
            %xpos2 = [b(1).XData(2)];
            sigstar( [1,2], CMH_pval);    
    
            
            subplot_num = subplot_num + 1;
        end
        
    end
    
    % Plot Somatostatin bar chart in final panel?
        
        




    % Extract averages for each element across animals
%     FEF_D1R_NeuN  = avg_X_animals( immuno_struct, 'D1R', 'NeuN', 'FEF' );
%     FEF_D1R_SMI32 = avg_X_animals( immuno_struct, 'D1R', 'SMI-32', 'FEF' );
%     FEF_D1R_NRG   = avg_X_animals( immuno_struct, 'D1R', 'Neurogranin', 'FEF' );
%     FEF_D1R_Parv  = avg_X_animals( immuno_struct, 'D1R', 'Parvalbumin', 'FEF' );
%     FEF_D1R_Calb  = avg_X_animals( immuno_struct, 'D1R', 'Calbindin', 'FEF' );
%     FEF_D1R_Calr  = avg_X_animals( immuno_struct, 'D1R', 'Calretinin', 'FEF' );
%     FEF_D1R_Som   = avg_X_animals( immuno_struct, 'D1R', 'Somatostatin', 'FEF' );
%    
%     FEF_D1R = [FEF_D1R_NeuN FEF_D1R_SMI32 FEF_D1R_NRG FEF_D1R_Parv FEF_D1R_Calb FEF_D1R_Calr FEF_D1R_Som];
%     
%     dlPFC_D1R_NeuN  = avg_X_animals( immuno_struct, 'D1R', 'NeuN', 'dlPFC' );
%     dlPFC_D1R_SMI32 = avg_X_animals( immuno_struct, 'D1R', 'SMI-32', 'dlPFC' );
%     dlPFC_D1R_NRG   = avg_X_animals( immuno_struct, 'D1R', 'Neurogranin', 'dlPFC' );
%     dlPFC_D1R_Parv  = avg_X_animals( immuno_struct, 'D1R', 'Parvalbumin', 'dlPFC' );
%     dlPFC_D1R_Calb  = avg_X_animals( immuno_struct, 'D1R', 'Calbindin', 'dlPFC' );
%     dlPFC_D1R_Calr  = avg_X_animals( immuno_struct, 'D1R', 'Calretinin', 'dlPFC' );
%     dlPFC_D1R_Som   = avg_X_animals( immuno_struct, 'D1R', 'Somatostatin', 'dlPFC' );
%  
%     dlPFC_D1R = [dlPFC_D1R_NeuN dlPFC_D1R_SMI32 dlPFC_D1R_NRG dlPFC_D1R_Parv dlPFC_D1R_Calb dlPFC_D1R_Calr dlPFC_D1R_Som];
%     
%     
%     FEF_D2R_NeuN  = avg_X_animals( immuno_struct, 'D2R', 'NeuN', 'FEF' );
%     FEF_D2R_SMI32 = avg_X_animals( immuno_struct, 'D2R', 'SMI-32', 'FEF' );
%     FEF_D2R_NRG   = avg_X_animals( immuno_struct, 'D2R', 'Neurogranin', 'FEF' );
%     FEF_D2R_Parv  = avg_X_animals( immuno_struct, 'D2R', 'Parvalbumin', 'FEF' );
%     FEF_D2R_Calb  = avg_X_animals( immuno_struct, 'D2R', 'Calbindin', 'FEF' );
%     FEF_D2R_Calr  = avg_X_animals( immuno_struct, 'D2R', 'Calretinin', 'FEF' );
%     FEF_D2R_Som   = avg_X_animals( immuno_struct, 'D2R', 'Somatostatin', 'FEF' );
%    
%     FEF_D2R = [FEF_D2R_NeuN FEF_D2R_SMI32 FEF_D2R_NRG FEF_D2R_Parv FEF_D2R_Calb FEF_D2R_Calr FEF_D2R_Som];
% 
%     dlPFC_D2R_NeuN  = avg_X_animals( immuno_struct, 'D2R', 'NeuN', 'dlPFC' );
%     dlPFC_D2R_SMI32 = avg_X_animals( immuno_struct, 'D2R', 'SMI-32', 'dlPFC' );
%     dlPFC_D2R_NRG   = avg_X_animals( immuno_struct, 'D2R', 'Neurogranin', 'dlPFC' );
%     dlPFC_D2R_Parv  = avg_X_animals( immuno_struct, 'D2R', 'Parvalbumin', 'dlPFC' );
%     dlPFC_D2R_Calb  = avg_X_animals( immuno_struct, 'D2R', 'Calbindin', 'dlPFC' );
%     dlPFC_D2R_Calr  = avg_X_animals( immuno_struct, 'D2R', 'Calretinin', 'dlPFC' );
%     dlPFC_D2R_Som   = avg_X_animals( immuno_struct, 'D2R', 'Somatostatin', 'dlPFC' );
%     
%     dlPFC_D2R = [dlPFC_D2R_NeuN dlPFC_D2R_SMI32 dlPFC_D2R_NRG dlPFC_D2R_Parv dlPFC_D2R_Calb dlPFC_D2R_Calr dlPFC_D2R_Som];
% 
%     
%     % Plot
%     figure();
%     subplot(2,1,1)
%     bar( [FEF_D1R', dlPFC_D1R'] );
%     ylim( [0 100] ); set(gca, 'ytick', [0:20:100]);
%     set(gca,'XTickLabel',{'NeuN', 'SMI-32','Neurogranin','Parvalbumin','Calbindin', 'Calretinin', 'Somatostatin'});
%     ylabel( '% of Neurons with D1R', 'FontSize', 16, 'FontWeight', 'bold' );
%     set(gca,'XTickLabelRotation',45);
%     set(gca,'FontSize',14, 'FontWeight', 'bold');
%     clr = [0 0 0; 0.5 0.5 0.5]; colormap(clr);
%     legend('FEF', 'dlPFC');
%     
%     subplot(2,1,2)
%     bar( [FEF_D2R', dlPFC_D2R'] );
%     ylim( [0 100] ); set(gca, 'ytick', [0:20:100]);
%     set(gca,'XTickLabel',{'NeuN', 'SMI-32','Neurogranin','Parvalbumin','Calbindin', 'Calretinin', 'Somatostatin'});
%     ylabel( '% of Neurons with D2R', 'FontSize', 16, 'FontWeight', 'bold' );
%     set(gca,'XTickLabelRotation',45);
%     set(gca,'FontSize',14, 'FontWeight', 'bold');
%     clr = [0 0 0; 0.5 0.5 0.5]; colormap(clr);
%     legend('FEF', 'dlPFC');
    
end

    
function rslt = avg_X_animals( immuno_struct, receptor, celltype, region )

    % Find all rows in immunostruct with matching receptor and celltype and
    % region
    
    substruct = immuno_struct(strcmp({immuno_struct.Stain1}, receptor) & strcmp({immuno_struct.Region}, region) & strcmp({immuno_struct.Stain2}, celltype));
    
    % Calculate 'combined count' out of 'cell type count + combined count',
    % for each animal separately
    animals = unique({substruct.Animal});
   
    avg_list = [];
    
    for i = 1:length(animals)
        animal = animals(i);
        animal_subindxes = find( strcmp({substruct.Animal}, animal) );
        
        animal_subvals = [];
        for j = 1:length( animal_subindxes )
            idx = animal_subindxes(j);
            num_cellonly = length(substruct(idx).positions(2).x); %  2 = cell only;
            num_combined = length(substruct(idx).positions(3).x); %  3 = combined;
            animal_subval = num_combined / (num_cellonly + num_combined);
            animal_subvals = [animal_subvals animal_subval];
        end
        
        animal_avg = mean(animal_subvals);
        avg_list = [avg_list animal_avg];

    end
    
    % Average across animals
    rslt = mean(avg_list) * 100;
end