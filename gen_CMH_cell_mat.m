% I'm concerned this is illegal because row1 and row 2 were collected
% separaely and this doesn't account for double-positive cells.

% Will only use one section from each animal, and the first one that find
% because it's safer?

function cell_mat = gen_CMH_cell_mat( immuno_struct, axis1, axis2 )

    [substruct1 substruct2] = gen_substructs( immuno_struct, axis1, axis2 );
    
    cell_mat = substruct_by_animal( substruct1, substruct2 );  

end


function [substruct1, substruct2] = gen_substructs( immuno_struct, axis1, axis2 )

    if strcmp(axis1, 'D1RD2R')
        region = 'FEF';
        celltype = axis2;
        substruct1 = immuno_struct(strcmp({immuno_struct.Stain1}, 'D1R') & strcmp({immuno_struct.Region}, region) & strcmp({immuno_struct.Stain2}, celltype));
        substruct2 = immuno_struct(strcmp({immuno_struct.Stain1}, 'D2R') & strcmp({immuno_struct.Region}, region) & strcmp({immuno_struct.Stain2}, celltype)); 
    elseif strcmp( axis1, 'D1R_Region' )
        receptor = 'D1R';
        celltype = axis2;
        substruct1 = immuno_struct(strcmp({immuno_struct.Stain1}, receptor) & strcmp({immuno_struct.Region}, 'FEF') & strcmp({immuno_struct.Stain2}, celltype));
        substruct2 = immuno_struct(strcmp({immuno_struct.Stain1}, receptor) & strcmp({immuno_struct.Region}, 'dlPFC') & strcmp({immuno_struct.Stain2}, celltype)); 
    elseif strcmp( axis1, 'D2R_Region' )
        receptor = 'D2R';
        celltype = axis2;
        substruct1 = immuno_struct(strcmp({immuno_struct.Stain1}, receptor) & strcmp({immuno_struct.Region}, 'FEF') & strcmp({immuno_struct.Stain2}, celltype));
        substruct2 = immuno_struct(strcmp({immuno_struct.Stain1}, receptor) & strcmp({immuno_struct.Region}, 'dlPFC') & strcmp({immuno_struct.Stain2}, celltype)); 
    elseif strcmp( axis1, 'D5R_Region' )
        receptor = 'D5R';
        celltype = axis2;
        substruct1 = immuno_struct(strcmp({immuno_struct.Stain1}, receptor) & strcmp({immuno_struct.Region}, 'FEF') & strcmp({immuno_struct.Stain2}, celltype));
        substruct2 = immuno_struct(strcmp({immuno_struct.Stain1}, receptor) & strcmp({immuno_struct.Region}, 'dlPFC') & strcmp({immuno_struct.Stain2}, celltype)); 
    elseif strcmp( axis2, 'PYR' )
        substruct1 = immuno_struct( strcmp({immuno_struct.Stain1}, axis1) & strcmp({immuno_struct.Region}, 'FEF') & strcmp({immuno_struct.Stain2}, 'SMI-32'));
        substruct2 = immuno_struct( strcmp({immuno_struct.Stain1}, axis1) & strcmp({immuno_struct.Region}, 'FEF') & strcmp({immuno_struct.Stain2}, 'Neurogranin')); 
    elseif strcmp( axis2, 'ParvCalb' )
        substruct1 = immuno_struct( strcmp({immuno_struct.Stain1}, axis1) & strcmp({immuno_struct.Region}, 'FEF') & strcmp({immuno_struct.Stain2}, 'Parvalbumin'));
        substruct2 = immuno_struct( strcmp({immuno_struct.Stain1}, axis1) & strcmp({immuno_struct.Region}, 'FEF') & strcmp({immuno_struct.Stain2}, 'Calbindin'));
    elseif strcmp( axis2, 'CalbCalr' )
        substruct1 = immuno_struct( strcmp({immuno_struct.Stain1}, axis1) & strcmp({immuno_struct.Region}, 'FEF') & strcmp({immuno_struct.Stain2}, 'Calbindin'));
        substruct2 = immuno_struct( strcmp({immuno_struct.Stain1}, axis1) & strcmp({immuno_struct.Region}, 'FEF') & strcmp({immuno_struct.Stain2}, 'Calretinin'));
    elseif strcmp( axis2, 'CalrParv' )
        substruct1 = immuno_struct( strcmp({immuno_struct.Stain1}, axis1) & strcmp({immuno_struct.Region}, 'FEF') & strcmp({immuno_struct.Stain2}, 'Calretinin'));
        substruct2 = immuno_struct( strcmp({immuno_struct.Stain1}, axis1) & strcmp({immuno_struct.Region}, 'FEF') & strcmp({immuno_struct.Stain2}, 'Parvalbumin'));
    elseif strcmp( axis2, 'NRGInhib' )
        substruct1 = immuno_struct( strcmp({immuno_struct.Stain1}, axis1) & strcmp({immuno_struct.Region}, 'FEF') & strcmp({immuno_struct.Stain2}, 'Neurogranin'));
        substruct2 = immuno_struct( strcmp({immuno_struct.Stain1}, axis1) & strcmp({immuno_struct.Region}, 'FEF') & strcmp({immuno_struct.Stain2}, 'Inhibitory'));
    elseif strcmp( axis2, 'NRGParv' )
        substruct1 = immuno_struct( strcmp({immuno_struct.Stain1}, axis1) & strcmp({immuno_struct.Region}, 'FEF') & strcmp({immuno_struct.Stain2}, 'Neurogranin'));
        substruct2 = immuno_struct( strcmp({immuno_struct.Stain1}, axis1) & strcmp({immuno_struct.Region}, 'FEF') & strcmp({immuno_struct.Stain2}, 'Parvalbumin'));
    elseif strcmp( axis2, 'NRGCalb' )
        substruct1 = immuno_struct( strcmp({immuno_struct.Stain1}, axis1) & strcmp({immuno_struct.Region}, 'FEF') & strcmp({immuno_struct.Stain2}, 'Neurogranin'));
        substruct2 = immuno_struct( strcmp({immuno_struct.Stain1}, axis1) & strcmp({immuno_struct.Region}, 'FEF') & strcmp({immuno_struct.Stain2}, 'Calbindin'));
    elseif strcmp( axis2, 'NRGCalr' )
        substruct1 = immuno_struct( strcmp({immuno_struct.Stain1}, axis1) & strcmp({immuno_struct.Region}, 'FEF') & strcmp({immuno_struct.Stain2}, 'Neurogranin'));
        substruct2 = immuno_struct( strcmp({immuno_struct.Stain1}, axis1) & strcmp({immuno_struct.Region}, 'FEF') & strcmp({immuno_struct.Stain2}, 'Calretinin'));
    elseif strcmp( axis2, 'NRGSom' )
        substruct1 = immuno_struct( strcmp({immuno_struct.Stain1}, axis1) & strcmp({immuno_struct.Region}, 'FEF') & strcmp({immuno_struct.Stain2}, 'Neurogranin'));
        substruct2 = immuno_struct( strcmp({immuno_struct.Stain1}, axis1) & strcmp({immuno_struct.Region}, 'FEF') & strcmp({immuno_struct.Stain2}, 'Somatostatin'));
    elseif strcmp( axis2, 'SMI32Inhib' )
        substruct1 = immuno_struct( strcmp({immuno_struct.Stain1}, axis1) & strcmp({immuno_struct.Region}, 'FEF') & strcmp({immuno_struct.Stain2}, 'SMI-32'));
        substruct2 = immuno_struct( strcmp({immuno_struct.Stain1}, axis1) & strcmp({immuno_struct.Region}, 'FEF') & strcmp({immuno_struct.Stain2}, 'Inhibitory'));
    elseif strcmp( axis2, 'SMI32Parv' )
        substruct1 = immuno_struct( strcmp({immuno_struct.Stain1}, axis1) & strcmp({immuno_struct.Region}, 'FEF') & strcmp({immuno_struct.Stain2}, 'SMI-32'));
        substruct2 = immuno_struct( strcmp({immuno_struct.Stain1}, axis1) & strcmp({immuno_struct.Region}, 'FEF') & strcmp({immuno_struct.Stain2}, 'Parvalbumin'));
    elseif strcmp( axis2, 'SMI32Calb' )
        substruct1 = immuno_struct( strcmp({immuno_struct.Stain1}, axis1) & strcmp({immuno_struct.Region}, 'FEF') & strcmp({immuno_struct.Stain2}, 'SMI-32'));
        substruct2 = immuno_struct( strcmp({immuno_struct.Stain1}, axis1) & strcmp({immuno_struct.Region}, 'FEF') & strcmp({immuno_struct.Stain2}, 'Calbindin'));
    elseif strcmp( axis2, 'SMI32Calr' )
        substruct1 = immuno_struct( strcmp({immuno_struct.Stain1}, axis1) & strcmp({immuno_struct.Region}, 'FEF') & strcmp({immuno_struct.Stain2}, 'SMI-32'));
        substruct2 = immuno_struct( strcmp({immuno_struct.Stain1}, axis1) & strcmp({immuno_struct.Region}, 'FEF') & strcmp({immuno_struct.Stain2}, 'Calretinin'));
    elseif strcmp( axis2, 'SMI32Som' )
        substruct1 = immuno_struct( strcmp({immuno_struct.Stain1}, axis1) & strcmp({immuno_struct.Region}, 'FEF') & strcmp({immuno_struct.Stain2}, 'SMI-32'));
        substruct2 = immuno_struct( strcmp({immuno_struct.Stain1}, axis1) & strcmp({immuno_struct.Region}, 'FEF') & strcmp({immuno_struct.Stain2}, 'Somatostatin'));
    else
        disp( 'Do not recognize first axis.' );
    end
  

end

function rslt =  substruct_by_animal( substruct1, substruct2 )

    animals = unique({substruct1.Animal});
    
    % Remove lines if don't have same animal complement in both sets.
    keep_idxs = [];
    for i = 1:length(animals)
        test = find(strcmp( {substruct2.Animal}, animals(i)),1);
        if ~isempty(test)
            keep_idxs = [keep_idxs i];
        end
    end
    animals = animals(keep_idxs);
    
    %rslt = struct;
    rslt = [];
    
    for i = 1:length(animals)
%         % Go through both substructs, find the first animal = animals(i), get
%         % counts for each substruct and pop it into a 2x2 matrix
% 
%         s1_firstIndex = find(strcmp( {substruct1.Animal}, animals(i)),1);
%         a = length( substruct1(s1_firstIndex).positions(3).x);  %  3 = combined;
%         b = length( substruct1(s1_firstIndex).positions(2).x);  %  2 = cell only;
%         
%         s2_firstIndex = find(strcmp( {substruct2.Animal}, animals(i)),1);
%         c = length( substruct2(s2_firstIndex).positions(3).x);  %  3 = combined;
%         d = length( substruct2(s2_firstIndex).positions(2).x);  %  2 = cell only;
%         
%         %rslt(i).Animal = animals(i);
%         %rslt(i).CMH_mat = [a b; c d];
%         rslt(:,:,i) = [a b; c d];
        
        % Using within animal average instead of first section of animal -
        % hopefully legal
        
        s1_indeces = find(strcmp( {substruct1.Animal}, animals(i))); 
        a = []; b = []; c = []; d = [];
        for j = 1:length( s1_indeces )
            tmp_a = length( substruct1(s1_indeces(j)).positions(3).x);  %  3 = combined;
            tmp_b = length( substruct1(s1_indeces(j)).positions(2).x);  %  2 = cell only;
            a = [a tmp_a]; b = [b, tmp_b]; 
        end
        a = mean(a); b = mean(b);
                
        s2_indeces = find(strcmp( {substruct2.Animal}, animals(i)));
        for j = 1:length( s2_indeces )
            tmp_c = length( substruct2(s2_indeces(j)).positions(3).x);  %  3 = combined;
            tmp_d = length( substruct2(s2_indeces(j)).positions(2).x);  %  2 = cell only;
            c = [c tmp_c]; d = [d tmp_d];
        end
        c = mean(c); d = mean(d);

        
        %rslt(i).Animal = animals(i);
        %rslt(i).CMH_mat = [a b; c d];
        rslt(:,:,i) = [a b; c d];
        
    end

end