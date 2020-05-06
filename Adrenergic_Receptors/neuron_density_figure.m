

function neuron_density_figure( immuno_struct )


    A1AR_by_Layer_struct = celldensity_by_layer( immuno_struct, 'Alpha1AR', 'all', 'FEF', 'TR' );
    A1AR_by_Layer = A1AR_by_Layer_struct.mean;
    A1AR_by_Layer_STE = A1AR_by_Layer_struct.ste;

    A2AR_by_Layer_struct = celldensity_by_layer( immuno_struct, 'Alpha2AR', 'all', 'FEF', 'TR' );
    A2AR_by_Layer = A2AR_by_Layer_struct.mean;
    A2AR_by_Layer_STE = A2AR_by_Layer_struct.ste;

    B1R_by_Layer_struct = celldensity_by_layer( immuno_struct, 'Beta1R', 'all', 'FEF', 'TR' );
    B1R_by_Layer = B1R_by_Layer_struct.mean;
    B1R_by_Layer_STE = B1R_by_Layer_struct.ste;

    B2R_by_Layer_struct = celldensity_by_layer( immuno_struct, 'Beta2R', 'all', 'FEF', 'TR' );
    B2R_by_Layer = B2R_by_Layer_struct.mean;
    B2R_by_Layer_STE = B2R_by_Layer_struct.ste;


    NRG_by_Layer_struct = celldensity_by_layer( immuno_struct, 'all', 'Neurogranin', 'FEF', 'TC' );
    NRG_by_Layer = NRG_by_Layer_struct.mean;
    NRG_by_Layer_STE = NRG_by_Layer_struct.ste;
    RatPyr_by_Layer_struct = celldensity_by_layer( immuno_struct, 'all', 'Rat-Pyramidal', 'FEF', 'TC' );
    RatPyr_by_Layer = RatPyr_by_Layer_struct.mean;
    RatPyr_by_Layer_STE = RatPyr_by_Layer_struct.ste;
    SMI32_by_Layer_struct = celldensity_by_layer( immuno_struct, 'all', 'SMI-32', 'FEF', 'TC' );
    SMI32_by_Layer = SMI32_by_Layer_struct.mean;
    SMI32_by_Layer_STE = SMI32_by_Layer_struct.ste;
    Parv_by_Layer_struct = celldensity_by_layer( immuno_struct, 'all', 'Parvalbumin', 'FEF', 'TC' );
    Parv_by_Layer = Parv_by_Layer_struct.mean;
    Parv_by_Layer_STE = Parv_by_Layer_struct.ste;
    Calb_by_Layer_struct = celldensity_by_layer( immuno_struct, 'all', 'Calbindin', 'FEF', 'TC' );
    Calb_by_Layer = Calb_by_Layer_struct.mean;
    Calb_by_Layer_STE = Calb_by_Layer_struct.ste;
    Calr_by_Layer_struct = celldensity_by_layer( immuno_struct, 'all', 'Calretinin', 'FEF', 'TC' );
    Calr_by_Layer = Calr_by_Layer_struct.mean;
    Calr_by_Layer_STE = Calr_by_Layer_struct.ste;
    Som_by_Layer_struct = celldensity_by_layer( immuno_struct, 'all', 'Somatostatin', 'FEF', 'TC' );
    Som_by_Layer = Som_by_Layer_struct.mean;
    Som_by_Layer_STE = Som_by_Layer_struct.ste;
    
    mm_factor = 1000000;
    
    %%% Anova %%%
    A1AR_mat = A1AR_by_Layer_struct.vals;
    A2AR_mat = A2AR_by_Layer_struct.vals;
    B1R_mat  = B1R_by_Layer_struct.vals;
    B2R_mat  = B2R_by_Layer_struct.vals;
    receptor_mat = horzcat( A1AR_mat, A2AR_mat, B1R_mat, B2R_mat);
    
    A1AR_receptor_label = ones( size(A1AR_mat ) );
    A2AR_receptor_label = ones( size(A2AR_mat ) ) .* 2;
    B1R_receptor_label  = ones( size(B1R_mat ) )  .* 3;
    B2R_receptor_label  = ones( size(B2R_mat ) )  .* 4;
    receptor_label = horzcat(A1AR_receptor_label, A2AR_receptor_label, B1R_receptor_label, B2R_receptor_label );
    
    layer_label = ones(size(receptor_mat));
    layer_label(2,:) = layer_label(2,:) .*2;
    layer_label(3,:) = layer_label(3,:) .*4;
    layer_label(4,:) = layer_label(4,:) .*5;
    layer_label(5,:) = layer_label(5,:) .*6;

    receptor_vec    = receptor_mat(:)';
    r_label_vec     = receptor_label(:)';
    layer_label_vec = layer_label(:)';
    
    [p, tbl] = anovan(receptor_vec, {r_label_vec, layer_label_vec}, 'varnames', {'Receptor', 'Layer'} );
    
    %[p, tbl] = anovan(receptor_vec, {r_label_vec, layer_label_vec}, 'varnames', {'Receptor', 'Layer'}, 'model', 'interaction' );
    
    
    figure();
    subplot(2,1,1);
    hold on;

    R_by_Layer_Means = [A1AR_by_Layer'; A2AR_by_Layer'; B1R_by_Layer'; B2R_by_Layer']';
    R_by_Layer_STEs  = [A1AR_by_Layer_STE'; A2AR_by_Layer_STE'; B1R_by_Layer_STE'; B2R_by_Layer_STE']';

    a = bar( R_by_Layer_Means .* mm_factor ); %a(1).FaceColor = 'k'; a(2).FaceColor = gray_col;
          
    ylim( [0 1300] ); set(gca, 'ytick', [0:200:1300]);
    set(gca, 'xtick', 1:5 );
    set(gca,'XTickLabel',{'I', 'II-III' 'IV' 'V' 'VI'});
    ylabel( 'Neurons / mm^{2}', 'FontSize', 12, 'FontWeight', 'bold' );
    xlabel( 'Layer' );
    %set(gca,'XTickLabelRotation',45);
    set(gca,'FontSize',10, 'FontWeight', 'bold');
    legend( 'A1AR', 'A2AR', 'Beta1R', 'Beta2R', 'Location', 'northwest');
    
    for i  = 1:length( a )
        err_x = a(i).XData + a(i).XOffset;
        err_y = R_by_Layer_Means(:,i);
        errorbar( err_x, err_y .* mm_factor, R_by_Layer_STEs(:,i) .* mm_factor, 'k', 'linestyle', 'none', 'HandleVisibility','off' );
    end 
    
    for i = 1:4
        a(i).FaceColor = get_bar_facecolor( 'greyscale', i );
    end
    
    
    hold off;

    
    subplot(2,1,2);
    
    CT_by_Layer_Means = [NRG_by_Layer'; RatPyr_by_Layer'; SMI32_by_Layer'; Parv_by_Layer'; Calr_by_Layer'; Calb_by_Layer'; Som_by_Layer']';
    CT_by_Layer_STEs = [NRG_by_Layer_STE'; RatPyr_by_Layer_STE'; SMI32_by_Layer_STE'; Parv_by_Layer_STE'; Calr_by_Layer_STE'; Calb_by_Layer_STE'; Som_by_Layer_STE']';
    
    hold on;
    b = bar( CT_by_Layer_Means .* mm_factor, 'BarWidth', 1);
    ylim( [0 1300] ); set(gca, 'ytick', [0:200:1300]);
    set(gca, 'xtick', 1:5 );
    set(gca,'XTickLabel',{'I', 'II-III', 'IV', 'V', 'VI'});
    ylabel( 'Neurons / mm^{2}', 'FontSize', 12, 'FontWeight', 'bold' );
    xlabel( 'Layer' );
    %set(gca,'XTickLabelRotation',45);
    set(gca,'FontSize',10, 'FontWeight', 'bold');
    legend( 'Neurogranin', 'R. Pyramidal', 'SMI-32','Parvalbumin', 'Calbindin', 'Calretinin', 'Somatostatin', 'Location', 'northeast');

    for i  = 1:length( b )
        err_x = b(i).XData + b(i).XOffset;
        err_y = CT_by_Layer_Means(:,i);
        errorbar( err_x, err_y .* mm_factor, CT_by_Layer_STEs(:,i) .* mm_factor, 'k', 'linestyle', 'none', 'HandleVisibility','off' );
    end
    
%     for j = 1:6
%         if j < 4 % First three plots are excitatory
%             b(j).FaceColor = get_bar_facecolor( 'excit', j );
%         else
%             b(j).FaceColor = get_bar_facecolor( 'inhib', j - 3 );
%         end
%     end

    celltype_bar_color_list = {'Neurogranin', 'RatPyramidal', 'SMI32', 'Parvalbumin', 'Calbindin', 'Calretinin'};
    for j = 1:6
        b(j).FaceColor = get_bar_facecolor( celltype_bar_color_list{j}, 5 );
    end
    
    set(gcf, 'Units', 'centimeters' );
    set(gcf, 'Position', [30, 30, 15, 30])
    set(gca, 'box', 'off' );
    tightfig( gcf );
    resize_paper_for_pdf( gcf );
    save_out_fig( gcf, strcat('Figure3_A_Cell_Densities_by_Layer') );
    hold off;


end