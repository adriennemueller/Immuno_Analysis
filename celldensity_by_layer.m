function rslt = celldensity_by_layer( sectionstruct, receptor, celltype, region, type )

    if strcmp( celltype, 'all' )
        substruct = sectionstruct(strcmp({sectionstruct.Stain1}, receptor) & strcmp({sectionstruct.Region}, region));
        label_string = receptor;
    elseif strcmp( receptor, 'all' )
        substruct = sectionstruct(strcmp({sectionstruct.Stain2}, celltype) & strcmp({sectionstruct.Region}, region));
        label_string = celltype;
    else
        substruct = sectionstruct(strcmp({sectionstruct.Stain1}, receptor) & strcmp({sectionstruct.Stain2}, celltype) & strcmp({sectionstruct.Region}, region));
        label_string = strcat( receptor, {' '}, 'and', {' '}, celltype  );
    end
    
    cellden_mat = []; n_cells = 0; n_sections = 0;

    for i = 1:length(substruct) % Should be a better way
        if strcmp(type, 'R')
            if ~ isempty( substruct(i).CountsByLayer )
                counts = substruct(i).CountsByLayer(1,:);
                micronsPerLayer = calc_um_per_layer( substruct(i).LayerDepths, substruct(i).img_x, substruct(i).img_y );
                curr_cell_den = counts' ./ micronsPerLayer;
                cellden_mat = horzcat( cellden_mat, curr_cell_den );
                n_cells = n_cells + sum(counts); n_sections = n_sections +1; 
            end
        elseif strcmp(type, 'C')
            if ~ isempty( substruct(i).CountsByLayer )
                counts = substruct(i).CountsByLayer(2,:);
                micronsPerLayer = calc_um_per_layer( substruct(i).LayerDepths, substruct(i).img_x, substruct(i).img_y );
                curr_cell_den = counts' ./ micronsPerLayer;
                cellden_mat = horzcat( cellden_mat, curr_cell_den );
                n_cells = n_cells + sum(counts); n_sections = n_sections +1; 
            end
        elseif strcmp( type, 'B')
            if ~ isempty( substruct(i).CountsByLayer )
                counts = substruct(i).CountsByLayer(3,:);
                micronsPerLayer = calc_um_per_layer( substruct(i).LayerDepths, substruct(i).img_x, substruct(i).img_y );
                curr_cell_den = counts' ./ micronsPerLayer;
                cellden_mat = horzcat( cellden_mat, curr_cell_den );
                n_cells = n_cells + sum(counts); n_sections = n_sections +1; 
            end
        elseif strcmp( type, 'TC')
            if ~ isempty( substruct(i).CountsByLayer )
                counts = substruct(i).CountsByLayer(3,:) + substruct(i).CountsByLayer(2,:);
                micronsPerLayer = calc_um_per_layer( substruct(i).LayerDepths, substruct(i).img_x, substruct(i).img_y );
                curr_cell_den = counts' ./ micronsPerLayer;
                cellden_mat = horzcat( cellden_mat, curr_cell_den );
                n_cells = n_cells + sum(counts); n_sections = n_sections +1; 
            end
         elseif strcmp( type, 'TR')
            if ~ isempty( substruct(i).CountsByLayer )
                counts = substruct(i).CountsByLayer(3,:) + substruct(i).CountsByLayer(1,:);
                micronsPerLayer = calc_um_per_layer( substruct(i).LayerDepths, substruct(i).img_x, substruct(i).img_y );
                curr_cell_den = counts' ./ micronsPerLayer;
                cellden_mat = horzcat( cellden_mat, curr_cell_den );
                n_cells = n_cells + sum(counts); n_sections = n_sections +1; 
            end           
        else
            disp( 'Unrecognized type.' );
        end
    end
    
    
    rslt.mean = mean( cellden_mat, 2 );
    rslt.n_cells = n_cells;
    rslt.n_sections = n_sections;
    
end


function rslt = calc_um_per_layer( LayerDepths, Width, MaxY )

%    MaxY = MaxY * (512/465);

    micronsPerPixel = 465/512;  %%% FACTOR THIS IN %%%

    ranges = [ 0              LayerDepths(1); 
               LayerDepths(1) LayerDepths(2);
               LayerDepths(2) LayerDepths(3);
               LayerDepths(3) LayerDepths(4)];
    if length(LayerDepths) == 5
        ranges(5,:) = [LayerDepths(4) LayerDepths(5)];
    else
        ranges(5,:) = [LayerDepths(4) MaxY];
    end
    
    layerYs = ranges(:,2) - ranges(:,1);
    layerYs = micronsPerPixel .* layerYs;
    
    Width = micronsPerPixel .* Width;
    
    rslt = Width .* layerYs;
    
end
