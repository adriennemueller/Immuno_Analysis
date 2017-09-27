% FEF and dlPFC side-by-side bar plot

% D5R plot - show bar plot of D5R on different cell types, NeuN and others.
% D1R, D2R Quantificaton
% Four subplots, Top Left = D1R on pyr; Top Right = D2R on pyr; Bottom Left D1R on Inhbitory Neurons; Bottom Right: D2R on inhibitory neurons 

function rslt = fef_and_dlPFC( immuno_struct )

    % Extract averages for each element across animals
    FEF_D1R_NeuN  = avg_X_animals( immuno_struct, 'D1R', 'NeuN', 'FEF' );
    FEF_D1R_SMI32 = avg_X_animals( immuno_struct, 'D1R', 'SMI-32', 'FEF' );
    FEF_D1R_NRG   = avg_X_animals( immuno_struct, 'D1R', 'Neurogranin', 'FEF' );
    FEF_D1R_Parv  = avg_X_animals( immuno_struct, 'D1R', 'Parvalbumin', 'FEF' );
    FEF_D1R_Calb  = avg_X_animals( immuno_struct, 'D1R', 'Calbindin', 'FEF' );
    FEF_D1R_Calr  = avg_X_animals( immuno_struct, 'D1R', 'Calretinin', 'FEF' );
    FEF_D1R_Som   = avg_X_animals( immuno_struct, 'D1R', 'Somatostatin', 'FEF' );
   
    FEF_D1R = [FEF_D1R_NeuN FEF_D1R_SMI32 FEF_D1R_NRG FEF_D1R_Parv FEF_D1R_Calb FEF_D1R_Calr FEF_D1R_Som];
    
    dlPFC_D1R_NeuN  = avg_X_animals( immuno_struct, 'D1R', 'NeuN', 'dlPFC' );
    dlPFC_D1R_SMI32 = avg_X_animals( immuno_struct, 'D1R', 'SMI-32', 'dlPFC' );
    dlPFC_D1R_NRG   = avg_X_animals( immuno_struct, 'D1R', 'Neurogranin', 'dlPFC' );
    dlPFC_D1R_Parv  = avg_X_animals( immuno_struct, 'D1R', 'Parvalbumin', 'dlPFC' );
    dlPFC_D1R_Calb  = avg_X_animals( immuno_struct, 'D1R', 'Calbindin', 'dlPFC' );
    dlPFC_D1R_Calr  = avg_X_animals( immuno_struct, 'D1R', 'Calretinin', 'dlPFC' );
    dlPFC_D1R_Som   = avg_X_animals( immuno_struct, 'D1R', 'Somatostatin', 'dlPFC' );
 
    dlPFC_D1R = [dlPFC_D1R_NeuN dlPFC_D1R_SMI32 dlPFC_D1R_NRG dlPFC_D1R_Parv dlPFC_D1R_Calb dlPFC_D1R_Calr dlPFC_D1R_Som];
    
    
    FEF_D2R_NeuN  = avg_X_animals( immuno_struct, 'D2R', 'NeuN', 'FEF' );
    FEF_D2R_SMI32 = avg_X_animals( immuno_struct, 'D2R', 'SMI-32', 'FEF' );
    FEF_D2R_NRG   = avg_X_animals( immuno_struct, 'D2R', 'Neurogranin', 'FEF' );
    FEF_D2R_Parv  = avg_X_animals( immuno_struct, 'D2R', 'Parvalbumin', 'FEF' );
    FEF_D2R_Calb  = avg_X_animals( immuno_struct, 'D2R', 'Calbindin', 'FEF' );
    FEF_D2R_Calr  = avg_X_animals( immuno_struct, 'D2R', 'Calretinin', 'FEF' );
    FEF_D2R_Som   = avg_X_animals( immuno_struct, 'D2R', 'Somatostatin', 'FEF' );
   
    FEF_D2R = [FEF_D2R_NeuN FEF_D2R_SMI32 FEF_D2R_NRG FEF_D2R_Parv FEF_D2R_Calb FEF_D2R_Calr FEF_D2R_Som];

    dlPFC_D2R_NeuN  = avg_X_animals( immuno_struct, 'D2R', 'NeuN', 'dlPFC' );
    dlPFC_D2R_SMI32 = avg_X_animals( immuno_struct, 'D2R', 'SMI-32', 'dlPFC' );
    dlPFC_D2R_NRG   = avg_X_animals( immuno_struct, 'D2R', 'Neurogranin', 'dlPFC' );
    dlPFC_D2R_Parv  = avg_X_animals( immuno_struct, 'D2R', 'Parvalbumin', 'dlPFC' );
    dlPFC_D2R_Calb  = avg_X_animals( immuno_struct, 'D2R', 'Calbindin', 'dlPFC' );
    dlPFC_D2R_Calr  = avg_X_animals( immuno_struct, 'D2R', 'Calretinin', 'dlPFC' );
    dlPFC_D2R_Som   = avg_X_animals( immuno_struct, 'D2R', 'Somatostatin', 'dlPFC' );
    
    dlPFC_D2R = [dlPFC_D2R_NeuN dlPFC_D2R_SMI32 dlPFC_D2R_NRG dlPFC_D2R_Parv dlPFC_D2R_Calb dlPFC_D2R_Calr dlPFC_D2R_Som];

    
    % Plot
    figure();
    subplot(2,1,1)
    bar( [FEF_D1R', dlPFC_D1R'] );
    ylim( [0 100] ); set(gca, 'ytick', [0:20:100]);
    set(gca,'XTickLabel',{'NeuN', 'SMI-32','Neurogranin','Parvalbumin','Calbindin', 'Calretinin', 'Somatostatin'});
    ylabel( '% of Neurons with D1R', 'FontSize', 16, 'FontWeight', 'bold' );
    set(gca,'XTickLabelRotation',45);
    set(gca,'FontSize',14, 'FontWeight', 'bold');
    clr = [0 0 0; 0.5 0.5 0.5]; colormap(clr);
    legend('FEF', 'dlPFC');
    
    subplot(2,1,2)
    bar( [FEF_D2R', dlPFC_D2R'] );
    ylim( [0 100] ); set(gca, 'ytick', [0:20:100]);
    set(gca,'XTickLabel',{'NeuN', 'SMI-32','Neurogranin','Parvalbumin','Calbindin', 'Calretinin', 'Somatostatin'});
    ylabel( '% of Neurons with D2R', 'FontSize', 16, 'FontWeight', 'bold' );
    set(gca,'XTickLabelRotation',45);
    set(gca,'FontSize',14, 'FontWeight', 'bold');
    clr = [0 0 0; 0.5 0.5 0.5]; colormap(clr);
    legend('FEF', 'dlPFC');
    
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