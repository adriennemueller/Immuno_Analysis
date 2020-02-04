function rslt = avg_X_animals( immuno_struct, receptor, celltype, region )

    % Find all rows in immunostruct with matching receptor and celltype and
    % region
    
    substruct = immuno_struct(strcmp({immuno_struct.Stain1}, receptor) & strcmp({immuno_struct.Region}, region) & strcmp({immuno_struct.Stain2}, celltype));
    
    % Calculate 'combined count' out of 'cell type count + combined count',
    % for each animal separately
    animals = unique({substruct.Animal});
   
    avg_list = [];
    total_n  = [];
    
    for i = 1:length(animals)
        animal = animals(i);
        animal_subindxes = find( strcmp({substruct.Animal}, animal) );
        
        animal_subvals = [];
        for j = 1:length( animal_subindxes )
            idx = animal_subindxes(j);
            num_cellonly = length(substruct(idx).positions(2).x); %  2 = cell only;
            num_combined = length(substruct(idx).positions(3).x); %  3 = combined;
            curr_total_n = num_cellonly + num_combined;
            animal_subval = num_combined / curr_total_n ;
            animal_subvals = [animal_subvals animal_subval];
            total_n = [total_n curr_total_n];
      end
        animal_total_n = sum(total_n);
        animal_avg = mean(animal_subvals);
        avg_list = [avg_list animal_avg];

    end
    
    % Average across animals
    rslt.mean    = mean(avg_list) * 100;
    rslt.ste     = (std(avg_list) / sqrt( length(avg_list) )) * 100;
    rslt.total_n = sum(animal_total_n);
end