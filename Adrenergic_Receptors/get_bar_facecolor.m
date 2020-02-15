function rslt = get_bar_facecolor( type, num )

    color_struct.Neurogranin = hex2rgb(['ffc05c', 'ffae2e', 'dd8700', 'ad6a00', 'ff9c00' ]);
    color_struct.RatPyramidal = hex2rgb(['ffdb5c', 'ffd12e', 'ddad00', 'ad8700', 'ffc700']);
    color_struct.SMI32 = hex2rgb(['ff975c', 'ff7a2e', 'dd5000', 'ad3e00', 'ff5c00']);

    color_struct.Parvalbumin = hex2rgb(['5a75cf', '3758c6','0d2c95', '092275', '133cc2']);
    color_struct.Calbindin = hex2rgb(['7c59d0', '6036c7', '340c97', '280876', '461c24']);
    color_struct.Calretinin = hex2rgb(['4bb3c6', '26a3bb', '027388', '025a6a', '049ab7']);
    color_struct.greyscale = hex2rgb(['c7c7c7', '959595', '5b5b5b', '3a3b3b', '777777']);

%    excit_map = [1 0.463 0
%                  1 0.655 0.361
%                  1 0.561 0.18
%                  0.867 0.40 0];
%   
%    inhib_map = [0.071 0.267 0.757
%                 0.349 0.478 0.808
%                 0.208 0.369 0.773
%                 0.047 0.20 0.58];

    rslt = color_struct.(type)(num,:);


end
    