%%% Either receptor or celltype can be all - which will collapse across
%%% sections for that dimension. The 'type' input says what will actually
%%% be plotted; the receptor line 'R', the celltype line 'C', or the line
%%% combined from both 'B'.

function [ avg_R, ste_R ] = plot_celldensity_overlay( sectionstruct, receptor, celltype, region, type, normalized )

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
    
    figure();
    hold on;

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
            faux_area( (1:length(normalizedX))', norm_smoothed_cells', [0,1,0] );
            empty_vec = nan(1,x_length);
            empty_vec(1:length(norm_smoothed_cells)) = norm_smoothed_cells;
            adjusted_R = empty_vec;
            if isnan(sum(adjusted_R))
                continue;
            end
            averages_mat = vertcat( averages_mat, adjusted_R);
        else
            faux_area( non_normalizedX, smoothed_cells, [0,1,0] );
        end
        alpha(0.02);
    end
    
    %    xlim([min([0,mindepth]), ceil(max([maxdepth, pixelDepth]))]);
    xlabel('Depth (um)', 'FontSize', 24, 'FontWeight', 'bold');
    ylabel(strcat( label_string, ' Cell Density (um^{-2})'), 'FontSize', 24, 'FontWeight', 'bold');
    set(gca,'FontSize',18)
     
    hold off;

    
    figure();
     
    [m n] = size( averages_mat );
    avg_R = mean( averages_mat );
    ste_R = std( averages_mat ) ./ sqrt( m );
    shadedErrorBar( [], avg_R, ste_R);
     
    xlabel('Normalized Distance from Pial Surface', 'FontSize', 24, 'FontWeight', 'bold');
    ylabel(strcat( label_string, ' Cell Density (um^{-2})'), 'FontSize', 24, 'FontWeight', 'bold');
    set(gca,'XTick',[0:500:1000]);
    set(gca,'XTickLabel', {'0', '0.5', '1'})
    set(gca,'FontSize',18)
    
end



function handle = faux_area( X, Y, C )
    % area draws the area between a line and the Y=0 axis. Patch draws an
    % arbitrary shape, so we have to complete the line of the axis
    % ourselves
    completedX = [ X; X(end); X(1) ];
    completedY = [ Y; 0; 0 ];
    handle = patch( completedX, completedY, C, 'EdgeColor', 'none' );
    %plot( X, Y, 'k' );
end

function [d, X] = distribution(points, mindepth, maxdepth)
    d = zeros(ceil(maxdepth - mindepth) + 1, 1);
    X = mindepth + (0:1:ceil(maxdepth - mindepth))';
    for i = 1:length(points)
        depth = floor(points(i) - mindepth) + 1;
        d(depth) = d(depth) + 1;
    end
end