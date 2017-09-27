function sectionstruct = gen_celldensities( sectionstruct )

    win_width = 100;

%%%% Assumes stain 1 = receptors; stain 2 = celltypes; stain 3 = both
    for i = 1:length(sectionstruct)

        receptordepths = sectionstruct(i).positions(1).y;
        celldepths = sectionstruct(i).positions(2).y;
        bothdepths = sectionstruct(i).positions(3).y;

        celldepths = horzcat(celldepths, bothdepths);
        receptordepths = horzcat(receptordepths, bothdepths);

        pixelWidth = sectionstruct(i).img_x;
        pixelDepth = sectionstruct(i).img_y;

        micronsPerPixel = 465/512;

        mindepth = min( min(celldepths), min(receptordepths) );
        maxdepth = max( max(celldepths), max(receptordepths) );

        [cells, X] = distribution( celldepths, mindepth, maxdepth );
        receptors = distribution( receptordepths, mindepth, maxdepth );
        both = distribution( bothdepths, mindepth, maxdepth );

        window = gausswin(win_width);
        window = window ./ sum(window);

        smoothed_cells = conv( cells, window, 'same' );
        smoothed_receptors = conv( receptors, window, 'same' );
        smoothed_both = conv( both, window, 'same' );

        % Rescale from cells per row of pixels to cells per micron^2
        sectionstruct(i).smoothed_celltypes = smoothed_cells ./ pixelWidth ./ (micronsPerPixel.^2);
        sectionstruct(i).smoothed_receptors = smoothed_receptors ./ pixelWidth ./ (micronsPerPixel.^2);
        sectionstruct(i).smoothed_both = smoothed_both ./ pixelWidth ./ (micronsPerPixel.^2);
        sectionstruct(i).X = X;
        

    end
end


function [d, X] = distribution(points, mindepth, maxdepth)
    d = zeros(ceil(maxdepth - mindepth) + 1, 1);
    X = mindepth + (0:1:ceil(maxdepth - mindepth))';
    for i = 1:length(points)
        depth = floor(points(i) - mindepth) + 1;
        d(depth) = d(depth) + 1;
    end
end

