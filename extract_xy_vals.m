function rslt = extract_xy_vals( fname )
    fname = fname{1};

    fstruct = xml2struct(fname);
    
    for i = 1:length(fstruct.CellCounter_Marker_File.Marker_Data.Marker_Type) % Usually 8
        
        if ~ isfield( fstruct.CellCounter_Marker_File.Marker_Data.Marker_Type{1, i}, 'Marker' )
            rslt(i).x = [];
            rslt(i).y = [];
            continue
        end
        
        tmpx1 = [fstruct.CellCounter_Marker_File.Marker_Data.Marker_Type{1, i}.Marker];
        tmpy1 = [fstruct.CellCounter_Marker_File.Marker_Data.Marker_Type{1, i}.Marker];
        if length(tmpx1) > 1
            tmpx2 = arrayfun(@(tmpx1) tmpx1.MarkerX.Text, [tmpx1{:}], 'UniformOutput', false);
            tmpy2 = arrayfun(@(tmpy1) tmpy1.MarkerY.Text, [tmpy1{:}], 'UniformOutput', false);
        else
            tmpx2 = tmpx1.MarkerX.Text;
            tmpy2 = tmpy1.MarkerY.Text;
        end
        rslt(i).x = str2double(tmpx2);
        rslt(i).y = str2double(tmpy2);
        
    end

end