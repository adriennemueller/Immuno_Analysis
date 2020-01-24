function rslt = extract_xy_vals( fname )
    fname = fname{1};

    fstruct = xml2struct(fname);

    for i = [4,6,8] % Marker groups 1, 2 and 3
        marker_struct = fstruct.Children(4).Children(i).Children;
        m_number = i/2-1; % Could get this from 'Type' more legitimately
        m_idxs = strcmp( {marker_struct.Name}, 'Marker' );
        marker_struct = marker_struct(m_idxs);
        xs = []; ys = [];
        for j = 1:length(marker_struct)
            xs(j) = str2double(marker_struct(j).Children(2).Children.Data);
            ys(j) = str2double(marker_struct(j).Children(4).Children.Data);
        end
    
        [xs, ys] = flip_axes( xs, ys );
        
        rslt(m_number).x = xs;
        rslt(m_number).y = ys;
        
        
    end        


end



function [out_xs, out_ys] = flip_axes( in_xs, in_ys )

    out_xs = in_ys;
    out_ys = in_xs;

end