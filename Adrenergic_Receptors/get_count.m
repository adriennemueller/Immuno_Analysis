% Get Counts by layer for Receptor/CT or CT_Total.
% Receptor/CT type = 'B';
% CT_Only = 'C'
% Receptor_Only = 'R'
% CT_Total type = 'T'
function rslt = get_count( substruct, type )

    rslt = [0 0 0 0 0];

    for i = 1:length(substruct)
        if ~ isempty( substruct(i).CountsByLayer )
            if strcmp(type, 'R')
                tmp = substruct(i).CountsByLayer(1,:);
            elseif strcmp( type, 'C')
                tmp = substruct(i).CountsByLayer(2,:);
            elseif strcmp( type, 'B')
                tmp = substruct(i).CountsByLayer(3,:);
            elseif strcmp( type, 'T')
                tmp = substruct(i).CountsByLayer(3,:) + substruct(i).CountsByLayer(2,:);
            elseif strcmp( type, 'TR' )
                tmp = substruct(i).CountsByLayer(3,:) + substruct(i).CountsByLayer(1,:);
            else
                disp( 'Unrecognized type.' );
            end
            
            rslt = rslt + tmp;
        end
        
    end
end
