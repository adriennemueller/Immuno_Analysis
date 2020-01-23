function fname = find_file_in_dir( directory, stringToBeFound )

    % directory Full path of the directory to be searched in
    % stringToBeFound = '<Specify the string you would like to be searched for>';
    
    filesAndFolders = dir(directory);     % Returns all the files and folders in the directory
    filesInDir = filesAndFolders(~([filesAndFolders.isdir]));  % Returns only the files in the directory                    
    
    numOfFiles = length(filesInDir);
    
    fname = '';
    
    % Decompose String to Be Found - may not be needed eventually.
    
    idx = strfind(stringToBeFound, 'STD_');
    pattern = stringToBeFound(idx(1):end);
    
    for i = 1:numOfFiles
          filename = filesInDir(i).name;                              % Store the name of the file
          
          %if ~isempty(findstr(filename, stringToBeFound))
          if ~isempty(strfind(filename, pattern))
              fname = filename;
          end
    end
    
end