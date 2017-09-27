%%% Add new rows to struct for combined inhibiory information.
function cellpos_struct = add_combinedInhibs( cellpos_struct )
    
    animals = unique({cellpos_struct.Animal});
    region_list = {'FEF', 'dlPFC'};
    receptor_list = {'D1R', 'D2R', 'D5R'};
    inhib_list = {'Calbindin', 'Calretinin', 'Parvalbumin'};
       
    for i = 1:length(animals)
        substruct1 = cellpos_struct(strcmp({cellpos_struct.Animal}, animals(i)));
        
        % For each region Get a region substruct
        for j = 1:length( region_list )
            substruct2 = substruct1(strcmp({substruct1.Region}, region_list(j)));
        
            % For each receptor Get a Receptor substruct
            for k = 1:length( receptor_list )
                substruct3 = substruct2(strcmp({substruct2.Stain1}, receptor_list(k)));
                 
                % Within that substruct, get the first of each interneuron
                % subtype positions and concatenate them with the rest.  If
                % not all three exist, NAN.
                
                for l = 1:length( inhib_list )
                    s3_firstIndex = find(strcmp( {substruct3.Stain2}, inhib_list(l)),1);
                    
                    if isempty(s3_firstIndex)
                        continue
                    end
                    
                    if l == 1
                        positions = substruct3(s3_firstIndex).positions;
                    else
                        positions = [positions; substruct3(s3_firstIndex).positions];
                    end
                end
                
                [m,n] = size( positions );
                if m < length( inhib_list )
                    continue
                else
                    % Concatenate inhib positions.
                    new_pos(1).x = horzcat(positions(:,1).x);  new_pos(1).y = horzcat(positions(:,1).y);    
                    new_pos(2).x = horzcat(positions(:,2).x);  new_pos(2).y = horzcat(positions(:,2).y);    
                    new_pos(3).x = horzcat(positions(:,3).x);  new_pos(3).y = horzcat(positions(:,3).y);    
                    
                    idx = length(cellpos_struct) +1;
                    
                    cellpos_struct(idx).Animal = char(animals(i));
                    cellpos_struct(idx).Region = char(region_list(j));
                    cellpos_struct(idx).Stain1 = char(receptor_list(k));
                    cellpos_struct(idx).Stain2 = 'Inhibitory';
                    cellpos_struct(idx).positions = new_pos;
                end                
            end
        end
    end
end