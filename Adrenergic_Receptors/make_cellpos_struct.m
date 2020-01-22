function rslt = make_cellpos_struct()

    rslt = struct;    
    
    folder = '/Volumes/Hnoss/Papers/Adrenergic Paper/Cell Counts/';
    % Get a list of all files in the folder with the desired file name pattern.
    filelist_struct = findfiles( folder, '*.xml' );
    filelist = {filelist_struct.name};
    
    %%% Loop through xml files in folder
    for i = 1:length(filelist)
        fname = filelist(i);
        
        [pathstr, short_name, ext] = fileparts(char(fname));
        disp( strcat( 'Processing:', {' '}, short_name ));
        
        %%% parse name and append to sruct
        rslt = parse_fnames(rslt, i, fname);
        
        %%% get image xs and ys
        rslt(i).positions = extract_xy_vals( fname );
        img_dims = get_img_dimensions( fname );
        rslt(i).img_x = img_dims(1); rslt(i).img_y = img_dims(2);
        
        % add layerdepth info to struct, if exists
        Ydepths = add_layerdepths( fname );
        rslt(i).LayerDepths = Ydepths;
        
        % add cells for layerdepths
        CountsByLayer = count_cells_by_layer( rslt(i) );
        rslt(i).CountsByLayer = CountsByLayer;
    end
    
end


function rslt = count_cells_by_layer( substruct )
    LayerDepths = substruct.LayerDepths;
    MaxImgDepth = substruct.img_y; % Confirm
    MaxImgDepth = MaxImgDepth * (512/465);


    % If Layerdepths is [], return [];
    if isempty(LayerDepths)
        rslt = [];
        return;
    end
    
    % Get ranges
    % From LayerDepths - use 5th layerdepth if available, otherwise use end
    % of img_y.
    ranges = [ 0              LayerDepths(1); 
               LayerDepths(1) LayerDepths(2);
               LayerDepths(2) LayerDepths(3);
               LayerDepths(3) LayerDepths(4)];
    if length(LayerDepths) == 5
        ranges(5,:) = [LayerDepths(4) LayerDepths(5)];
    else
        ranges(5,:) = [LayerDepths(4) MaxImgDepth];
    end
    
    
    % Loop through each range and count cells for R, CT and Both
    for i = 1:5 % Number of 'layers'
        rslt(1,i) = length( find( substruct(1).positions(1).y > ranges(i,1)   & ...
                                  substruct(1).positions(1).y <= ranges(i,2) ) ); % Receptors
        rslt(2,i) = length( find( substruct(1).positions(2).y > ranges(i,1)  & ...
                                  substruct(1).positions(2).y <= ranges(i,2) ) ); % Cell Type
        rslt(3,i) = length( find( substruct(1).positions(3).y > ranges(i,1)  & ...
                                  substruct(1).positions(3).y <= ranges(i,2) ) ); % Both
                        
    end
    
end

% add_layerdepths finds a csv file with a similar name as the xmlfile being processed
% and extracts (returns) the layer depths from that csv file.
function rslt = add_layerdepths( fullfname )
    rslt = NaN(2,'double');
    fullfname = fullfname{1};
    [folder,fname,ext] = fileparts( fullfname );
    folder = strcat( folder, '/');
    
    strToFind = strcat(fname, '.csv');
    curr_csv_file = find_file_in_dir( folder, strToFind);
    if(~isempty(curr_csv_file))
        rslt = load_layerdepthCSV( strcat(folder, curr_csv_file) );
    else
        rslt = [];
    end

end


% parse_fnames loops through a fname and extracts the animal name, region,
% receptor and cell type from the filename
function rslt = parse_fnames( rslt, idx, fname )
    animal_list =  {'Ozzy', 'Quito', 'Prince'};
    region_list = {'FEF'};
    receptor_list = {'Alpha1AR', 'Alpha2AR', 'Beta1R', 'Beta2R'};
    celltype_list = {'NeuN', 'Neurogranin', 'RatPyramidal', 'SMI-32', 'Parvalbumin', 'Calbindin', 'Calretinin', 'Somatostatin', };     

    rslt(idx).Animal = find_fname_element( animal_list, fname );
    rslt(idx).Region = find_fname_region( region_list, fname ); %%% FIX FOR DLPFC AND FEF IN SAME NAME
    rslt(idx).Stain1 = find_fname_element( receptor_list, fname );
    rslt(idx).Stain2 = find_fname_element( celltype_list, fname );
    
    rslt(idx).FileName = fname;
end

% find_fname_element idenifies whether an element in a list (of e.g.
% receptor names) is present in a filename
function element = find_fname_element( list, fname )
    element = {};
    
    fname = fname{1};
    
    for i = 1:length(list)
        rslt = strfind( fname, list{i} );
        if rslt
            element = list{i};
        end
    end
    if isempty( element )
        disp(strcat('Missing element in: ', fname )); 
    end
end

% find_fname_region idenifies whether an element in a list region nams is
% present in a filename; Needs to be different than find_fname_element
% because the region could be present twice - once to identify the box the
% secion was taken from and once to idntify the actual region photographed
function element = find_fname_region( list, fname )
    fname = fname{1};

    for i = 1:length(list)
        rslt(i).indexes = strfind( fname, list{i});
    end
    
    curr_max_idx = 0;
    for i = 1:length(rslt)
        
        if isempty(rslt(i).indexes),  continue,  end
        
        if rslt(i).indexes(end) > curr_max_idx;
            curr_max_idx = rslt(i).indexes(end);
            element = list{i};
        end
    end
    
    if curr_max_idx == 0;
        disp(strcat('Missing element in: ', fname )); 
    end
    
end

% get_img_dimensions gets the x and y dimensions for an immuno tif file. 
% Tif file is assumed to be oriented vertically with superfical cortx at
% the top and deep cortex at the bottom
function rslt = get_img_dimensions( fullfname )
    rslt = NaN(2,'double');
    fullfname = fullfname{1};
    [folder,fname,ext] = fileparts( fullfname );
    folder = strcat( folder, '/');
    
    %strToFind = strcat(fname(1:end-4), '.tif');
    strToFind = strcat(fname, '.tif');
    curr_im_file = find_file_in_dir( folder, strToFind);
    if(~isempty(curr_im_file))
        curr_im = imread(strcat(folder,curr_im_file));
        [img_y img_x] = size(curr_im);
        rslt = [img_x img_y];
    end
end