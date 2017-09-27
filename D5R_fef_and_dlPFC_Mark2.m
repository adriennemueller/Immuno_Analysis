% FEF and dlPFC side-by-side bar plot

% D5R plot - show bar plot of D5R on different cell types, NeuN and others.
% D1R, D2R Quantificaton
% Four subplots, Top Left = D1R on pyr; Top Right = D2R on pyr; Bottom Left D1R on Inhbitory Neurons; Bottom Right: D2R on inhibitory neurons 

function rslt = D5R_fef_and_dlPFC_Mark2( immuno_struct )

    ReceptorList = {'D5R'};
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
            %chisqstat = chi_sq_test( CMH_cell_mat )
            ChSq_pval = general_chi_sq_test( CMH_cell_mat );
            
            %xpos1 = [b(1).XData(1)];
            %xpos2 = [b(1).XData(2)];
            sigstar( [1,2], ChSq_pval);    
    
            
            subplot_num = subplot_num + 1;
        end
        
    end
    
    % Plot Somatostatin bar chart in final panel?
    
end
