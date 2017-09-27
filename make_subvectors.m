function countsstruct = make_subvectors( type, x, y )


countsstruct.celltype.x = [];
countsstruct.celltype.y = [];
countsstruct.receptor.x = [];
countsstruct.receptor.y = [];
countsstruct.both.x = [];
countsstruct.both.y = [];

for i = 1:length(type)
    if type(i) == 1
        countsstruct.both.x = [countsstruct.both.x x(i)];
        countsstruct.both.y = [countsstruct.both.y y(i)];

        countsstruct.celltype.x = [countsstruct.celltype.x x(i)];
        countsstruct.celltype.y = [countsstruct.celltype.y y(i)];
        
        countsstruct.receptor.x = [countsstruct.receptor.x x(i)];
        countsstruct.receptor.y = [countsstruct.receptor.y y(i)];
        
    elseif type(i) == 2
        countsstruct.celltype.x = [countsstruct.celltype.x x(i)];
        countsstruct.celltype.y = [countsstruct.celltype.y y(i)];
        
    elseif type(i) == 3
        countsstruct.receptor.x = [countsstruct.receptor.x x(i)];
        countsstruct.receptor.y = [countsstruct.receptor.y y(i)];
        
    end
end
        

    

end