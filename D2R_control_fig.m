
function D2R_control_fig( immuno_struct )

    D2R_by_Layer_struct = celldensity_by_layer( immuno_struct, 'D2R', 'all', 'FEF', 'TR' );
    D2R_by_Layer = D2R_by_Layer_struct.mean;
    D2R_by_Layer_STD = D2R_by_Layer_struct.std;

    D2Rnew_by_Layer_struct = celldensity_by_layer( immuno_struct, 'D2Rnew', 'all', 'FEF', 'TR' );
    D2Rnew_by_Layer = D2Rnew_by_Layer_struct.mean;
    D2Rnew_by_Layer_STD = D2Rnew_by_Layer_struct.std;

    
    mm_factor = 1000000;
    
    p_vals = get_pvals( D2R_by_Layer_struct.vals, D2Rnew_by_Layer_struct.vals );
    
    disp( num2str( p_vals ) );
    
    figure();
    hold on;
    gray_col = [0.8 0.8 0.8];
    a = bar( [D2R_by_Layer'; D2Rnew_by_Layer']' .* mm_factor ); a(1).FaceColor = 'k'; a(2).FaceColor = gray_col;
    
    pause(0.5);
    err_x1 = a(1).XData + a(1).XOffset;
    pause(0.5);
    err_x2 = a(2).XData + a(2).XOffset;
    pause(0.5);
    errorbar( err_x1, D2R_by_Layer .* mm_factor, D2R_by_Layer_STD .* mm_factor, 'k', 'linestyle', 'none', 'HandleVisibility','off' );
    errorbar( err_x2, D2Rnew_by_Layer .* mm_factor, D2Rnew_by_Layer_STD .* mm_factor, 'k', 'linestyle', 'none', 'HandleVisibility','off' );
    
    ylim( [0 300] ); set(gca, 'ytick', [0:50:300]);
    set(gca,'XTickLabel',{'I', '', 'II-III', '', 'IV', '', 'V', '', 'VI'});
    ylabel( 'Neurons / mm^{2}', 'FontSize', 14, 'FontWeight', 'bold' );
    xlabel( 'Layer' );
    %set(gca,'XTickLabelRotation',45);
    set(gca,'FontSize',12, 'FontWeight', 'bold');
    legend( 'D2R - Santa Cruz', 'D2R - Alomone', 'Location', 'northwest');
    hold off;
     
     
    set(gcf, 'Units', 'centimeters' );
    set(gcf, 'Position', [30, 30, 15, 13])
    set(gca, 'box', 'off' );
    tightfig( gcf );
    resize_paper_for_pdf( gcf );
    save_out_fig( gcf, strcat('FigS2_D2R_Control_By_Layer') );
    hold off;

    %title( 'Cell Density by Layer' );
    




end


function pvals = get_pvals( D2R_mat, D2Rnew_mat )

    num_layers = 5;
    
    for i = 1:num_layers
        [h,p] = ttest2( D2R_mat(i,:), D2Rnew_mat(i,:) );
        pvals(i) = p;
    end
       
end



% D2Rn_R = 2; D2Rn_CT = 336; D2Rn_RCT = 260;
% D2Ro_R = [2,2,3,20,2,8,11]; D2Ro_CT = [370 882 202 908 662 217 972]; D2Ro_RCT = [61, 22, 313, 238, 47, 346, 144];
% 
% 
% D2Ro_Total = sum( [D2Ro_CT; D2Ro_RCT], 1 );
% 
% 
% D2Ro_Props = D2Ro_RCT ./ D2Ro_Total;
% D2Ro_Props_avg = mean(D2Ro_Props);
% D2Ro_Prop_STD = std( D2Ro_Props );
% 
% D2Rn_Prop = D2Rn_CT / (D2Rn_CT + D2Rn_RCT);
% 
% figure(); bar(D2Ro_Props_avg);
% hold on; errorbar( 1, D2Ro_Props_avg, D2Ro_Prop_STD );
% bar( 2, D2Rn_Prop );
% ylim( [0, 1] );
% hold off;

