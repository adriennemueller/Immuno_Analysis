%%% Either receptor or celltype can be all - which will collapse across
%%% sections for that dimension. The 'type' input says what will actually
%%% be plotted; the receptor line 'R', the celltype line 'C', or the line
%%% combined from both 'B'.

function [ avg_R, ste_R, reshuffled_avg, reshuffled_ste ] = celldensity_by_depth( sectionstruct, receptor, celltype, region, type, normalized )

    micronsPerPixel = 465/512;
    
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
    
    averages_mat = [];

    for i = 1:length( substruct )

        if strcmp(type, 'R')
            smoothed_cells = substruct(i).smoothed_receptors;
        elseif strcmp(type, 'C')
            smoothed_cells = substruct(i).smoothed_celltypes;
        elseif strcmp( type, 'B')
            smoothed_cells = substruct(i).smoothed_both;
        else
            disp( 'Unrecognized type.' );
        end
        
        X = substruct(i).X;
        non_normalizedX = X * micronsPerPixel;

        if normalized
            x_length = 1000;
            normalizedX = 1:(length(smoothed_cells)/x_length):length(smoothed_cells);
            norm_smoothed_cells = interp1(1:length(smoothed_cells), smoothed_cells, normalizedX);
            empty_vec = nan(1,x_length);
            empty_vec(1:length(norm_smoothed_cells)) = norm_smoothed_cells;
            adjusted_R = empty_vec;
            if isnan(sum(adjusted_R))
                continue;
            end
            averages_mat = vertcat( averages_mat, adjusted_R);
        else
        end

    end

    [m n] = size( averages_mat );
    avg_R = mean( averages_mat );
    ste_R = std( averages_mat ) ./ sqrt( m );
  
    [reshuffled_avg, reshuffled_ste] = pseudoboot( averages_mat, 500 );
end


function [reshuffled_avg, reshuffled_ste] = pseudoboot( averages_mat, numTimes )

    avg_list = [];
    ste_list = [];
    
    [m n] = size( averages_mat );

    for i = 1:numTimes
        resh_mat = reshuffle(averages_mat);
        
        avg = mean( resh_mat );
        avg_list = vertcat( avg_list, avg);
        
        ste = std( resh_mat ) ./ sqrt( m );        
        ste_list = vertcat( ste_list, ste );
    end
    
    reshuffled_avg = mean(avg_list);
    reshuffled_ste = mean(ste_list);
    
end

function rslt = reshuffle( averages_mat )

    [m n] = size( averages_mat );
    rslt = [];
    
    for i = 1:m
        rslt(i,:) = randsample( averages_mat(i,:), n );
    end
        
end
