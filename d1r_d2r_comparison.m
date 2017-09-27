% D1R, D2R Quantificaton
% Two plots 1 Left = D1R on pyr; 1 Right = D2R on pyr; 2 Left D1R on Inhbitory Neurons; 2 Right: D2R on inhibitory neurons 

function rslt = d1r_d2r_comparison( immuno_struct )

    % Extract averages for each element across animals

    rslt.D1R_SMI32 = avg_X_animals( immuno_struct, 'D1R', 'SMI-32', 'FEF' );
    rslt.D1R_NRG   = avg_X_animals( immuno_struct, 'D1R', 'Neurogranin', 'FEF' );
    
    rslt.D2R_SMI32 = avg_X_animals( immuno_struct, 'D2R', 'SMI-32', 'FEF' );
    rslt.D2R_NRG   = avg_X_animals( immuno_struct, 'D2R', 'Neurogranin', 'FEF' );
    
    rslt.D1R_Parv  = avg_X_animals( immuno_struct, 'D1R', 'Parvalbumin', 'FEF' );
    rslt.D1R_Calb  = avg_X_animals( immuno_struct, 'D1R', 'Calbindin', 'FEF' );
    rslt.D1R_Calr  = avg_X_animals( immuno_struct, 'D1R', 'Calretinin', 'FEF' );
    rslt.D1R_Som   = avg_X_animals( immuno_struct, 'D1R', 'Somatostatin', 'FEF' );
    rslt.D1R_Inhib = avg_X_animals( immuno_struct, 'D1R', 'Inhibitory', 'FEF' );
    
    rslt.D2R_Parv  = avg_X_animals( immuno_struct, 'D2R', 'Parvalbumin', 'FEF' );
    rslt.D2R_Calb  = avg_X_animals( immuno_struct, 'D2R', 'Calbindin', 'FEF' );
    rslt.D2R_Calr  = avg_X_animals( immuno_struct, 'D2R', 'Calretinin', 'FEF' );
    rslt.D2R_Som   = avg_X_animals( immuno_struct, 'D2R', 'Somatostatin', 'FEF' );
    rslt.D2R_Inhib = avg_X_animals( immuno_struct, 'D2R', 'Inhibitory', 'FEF' );
    
    
    
    
    % Plot
    figure();
    subplot(1,2,1);
    bar( [rslt.D1R_SMI32 rslt.D1R_NRG], 'k' );
    ylim( [0 100] ); set(gca, 'ytick', [0:20:100]);
    set(gca,'XTickLabel',{'SMI-32','Neurogranin'});
    ylabel( '% of Neurons with D1R', 'FontSize', 16, 'FontWeight', 'bold' );
    set(gca,'FontSize',14, 'FontWeight', 'bold');
    
    subplot(1,2,2);
    bar( [rslt.D2R_SMI32 rslt.D2R_NRG], 'k' );
    ylim( [0 100] ); set(gca, 'ytick', [0:20:100]);
    set(gca,'XTickLabel',{'SMI-32','Neurogranin'});
    ylabel( '% of Neurons with D2R', 'FontSize', 16, 'FontWeight', 'bold' );
    set(gca,'FontSize',14, 'FontWeight', 'bold');
    
    
    figure();
    
    subplot(1,2,1);
    bar( [rslt.D1R_Parv rslt.D1R_Calb rslt.D1R_Calr rslt.D1R_Som rslt.D1R_Inhib], 'k' );
    ylim( [0 100] ); set(gca, 'ytick', [0:20:100]);
    set(gca,'XTickLabel',{'Parvalbumin','Calbindin', 'Calretinin', 'Somatostatin', 'Inhibitory'});
    ylabel( '% of Neurons with D1R', 'FontSize', 16, 'FontWeight', 'bold' );
    set(gca,'XTickLabelRotation',45);
    set(gca,'FontSize',14, 'FontWeight', 'bold');

    subplot(1,2,2);
    bar( [rslt.D2R_Parv rslt.D2R_Calb rslt.D2R_Calr rslt.D2R_Som rslt.D2R_Inhib], 'k' );
    ylim( [0 100] ); set(gca, 'ytick', [0:20:100]);
    set(gca,'XTickLabel',{'Parvalbumin','Calbindin', 'Calretinin', 'Somatostatin', 'Inhibitory'});
    ylabel( '% of Neurons with D2R','FontSize', 16, 'FontWeight', 'bold' );
    set(gca,'XTickLabelRotation',45);
    set(gca,'FontSize',14, 'FontWeight', 'bold');
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