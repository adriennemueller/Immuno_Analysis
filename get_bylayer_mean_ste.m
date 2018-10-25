function rslt = get_bylayer_mean_ste( substruct, type, total_type )

    val_list = [];
    total_list = [];

    for i = 1:length(substruct)
        if ~ isempty( substruct(i).CountsByLayer )
            if strcmp(type, 'R')
                animal_val = substruct(i).CountsByLayer(1,:);
            elseif strcmp( type, 'C')
                animal_val = substruct(i).CountsByLayer(2,:);
            elseif strcmp( type, 'B')
                animal_val = substruct(i).CountsByLayer(3,:);
            else
                disp( 'Unrecognized type.' );
            end
            
            val_list = vertcat(val_list, animal_val);
            
        end

        if ~ isempty( substruct(i).CountsByLayer )
            if strcmp( total_type, 'T')
                animal_total = substruct(i).CountsByLayer(3,:) + substruct(i).CountsByLayer(2,:);
            elseif strcmp( type, 'TR' )
                animal_total = substruct(i).CountsByLayer(3,:) + substruct(i).CountsByLayer(1,:);
            else
                disp( 'Unrecognized type.' );
            end
            
            total_list = vertcat(total_list, animal_total);
        end
        
    end 
    
    prop_list = val_list ./ total_list;
    
    rslt.bylayer_avg = mean( prop_list, 1 );
    rslt.bylayer_ste = std(  prop_list, 1 ) ./ sqrt( size( prop_list, 1 ) );
     
end