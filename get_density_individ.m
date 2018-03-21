% Get Counts by layer for Receptor/CT or CT_Total.
% Receptor/CT type = 'B';
% CT_Only = 'C'
% Receptor_Only = 'R'
% CT_Total type = 'T'
function cellden_mat = get_density_individ( substruct, type )

    rslt = [];
    cellden_mat = [];

    for i = 1:length(substruct)
        if ~ isempty( substruct(i).CountsByLayer )
            if strcmp(type, 'R')
                rslt =  vertcat(rslt, substruct(i).CountsByLayer(1,:));
            elseif strcmp( type, 'C')
                rslt =  vertcat(rslt, substruct(i).CountsByLayer(2,:));
            elseif strcmp( type, 'B')
                rslt =  vertcat(rslt, substruct(i).CountsByLayer(3,:));
            elseif strcmp( type, 'TC')
                tmp = substruct(i).CountsByLayer(3,:) + substruct(i).CountsByLayer(2,:);
                rslt = vertcat(rslt, tmp);
            elseif strcmp( type, 'TR' )
                tmp = substruct(i).CountsByLayer(3,:) + substruct(i).CountsByLayer(1,:);
                rslt = vertcat(rslt, tmp);
            else
                disp( 'Unrecognized type.' );
            end
            
            micronsPerLayer = calc_um_per_layer( substruct(i).LayerDepths, substruct(i).img_x, substruct(i).img_y );
            curr_cell_den = rslt(end,:) ./ micronsPerLayer';
            cellden_mat = vertcat( cellden_mat, curr_cell_den );
            
        end
            
    end
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