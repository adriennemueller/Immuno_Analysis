function countsstruct = make_subvectors2( type, x, y )


countsstruct.celltype.x = [];
countsstruct.celltype.y = [];
countsstruct.receptor.x = [];
countsstruct.receptor.y = [];

for i = 1:length(type)
    if type(i) == 1
        countsstruct.celltype.x = [countsstruct.celltype.x x(i)];
        countsstruct.celltype.y = [countsstruct.celltype.y y(i)];
 
    elseif type(i) == 2
        countsstruct.receptor.x = [countsstruct.receptor.x x(i)];
        countsstruct.receptor.y = [countsstruct.receptor.y y(i)];

        
    end
end
        

    

end