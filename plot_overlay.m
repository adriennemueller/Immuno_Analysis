function plot_overlay( angle, countstruct, pixelDepth, pixelWidth )

micronsPerPixel = 465/512;

celldepths = rotate( angle, countstruct.celltype.x, countstruct.celltype.y );
receptordepths = rotate( angle, countstruct.receptor.x, countstruct.receptor.y );

if isfield(countstruct, 'both')
    bothdepths = rotate( angle, countstruct.both.x, countstruct.both.y );
    %receptordepths = bothdepths; % Change this to receptordepths for alternative plot
    celldepths = bothdepths;
end



% figure();
% hist( celldepths );
% figure();
% hist( receptordepths );

mindepth = min( min(celldepths), min(receptordepths) );
maxdepth = max( max(celldepths), max(receptordepths) );

[cells, X] = distribution( celldepths, mindepth, maxdepth );
receptors = distribution( receptordepths, mindepth, maxdepth );

window = gausswin(160);
window = window ./ sum(window);

smoothed_cells = conv( cells, window, 'same' );
smoothed_receptors = conv( receptors, window, 'same' );

% Rescale from cells per row of pixels to cells per micron^2
smoothed_cells = smoothed_cells ./ pixelWidth ./ (micronsPerPixel.^2);
smoothed_receptors = smoothed_receptors ./ pixelWidth ./ (micronsPerPixel.^2);

figure();
hold on;
area( X * micronsPerPixel, smoothed_cells, 'FaceColor', [1,0,1]  );
area( X * micronsPerPixel, smoothed_receptors, 'FaceColor', [0,1,0] );
alpha(1);
xlim([min([0,mindepth]), ceil(max([maxdepth, pixelDepth]))]);

xlabel('Depth (um)', 'FontSize', 24, 'FontWeight', 'bold');
ylabel('Cell Density (um^{-2})', 'FontSize', 24, 'FontWeight', 'bold');
set(gca,'FontSize',18)
hold off;

end


function [d, X] = distribution(points, mindepth, maxdepth)
    d = zeros(ceil(maxdepth - mindepth) + 1, 1);
    X = mindepth + (0:1:ceil(maxdepth - mindepth))';
    for i = 1:length(points)
        depth = floor(points(i) - mindepth) + 1;
        d(depth) = d(depth) + 1;
    end
end

function z = rotate( degrees, x, y )
     assert(length(x) == length(y));
     radians = deg2rad(degrees);
     R = [ cos(radians), -sin(radians) ; sin(radians), cos(radians) ];
     z = zeros(length(x), 1);
     for i = 1:length(x)
         rotated = R * [ x(i) ; y(i) ];
         z(i) = rotated(1);
     end
end

function r = deg2rad(d)
    r = d * pi / 180;
end