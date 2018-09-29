
function calc_injection_volumes()

    %%% Benny V4
    list_num_sections = [24, 24, 24, 24, 24, 24, 24, 24, 24, 24];
    section_width = 20;
    list_areas = [0, 292773.186, 3829129.801, 2919005.187, 2514542.649, 5535948.162, 4958130.568, 1470306.148, ...
                  1008527.863, 618117.473, 74743.169];
    Benny_V4_Volume = calc_injection_volume( list_num_sections, section_width, list_areas );
    
    %%% BJ23 Right V4
    list_num_sections = [12, 12, 12, 12, 11, 13, 12, 12, 10, 14, 10, 14, 12, 11, 13, 11, 13, 12, 10];
    section_width = 20;
    list_areas = [0, 2110964.54, 2811204.05, 2854874.59, 2837796.51, 2919020.69, 1629276.68, 464907.429, 2644835.29, 2793866.25, ...
                  5039935.46, 5676469.48, 7056924.36, 4919637.18, 8549776.13, 7673201.58, 5711112.69, 5167688.69, 6654900.44, 9786477.29];
    BJ23_Right_V4_Volume = calc_injection_volume( list_num_sections, section_width, list_areas );
          
    %%% BJ23 Right MT
    list_num_sections = [12, 12, 12, 12, 12, 11, 13];
    section_width = 20;
    list_areas = [0, 4868969.25, 5462509.85, 3985510.03, 4141355.34, 3402009.26, 2047198.45, 1065352.53, 0];
    BJ23_Right_MT_Volume = calc_injection_volume( list_num_sections, section_width, list_areas );

    %%% BJ23 Left V4

    %%% BJ28 Right V4
    list_num_sections = [14, 12, 12, 12, 12, 12, 24];
    section_width = 40;
    list_areas = [0, 709893.37, 2899732.43, 3743628.33, 2451345.64, 3893968.91, 3332994.86, 0];
    BJ28_Right_V4_Volume = calc_injection_volume( list_num_sections, section_width, list_areas );

    %%% BJ28 Right MT
    list_num_sections = [14, 12, 12, 12, 12, 12, 24, 12, 8, 16, 12];
    section_width = 40;
    list_areas = [2024018.21, 1235242.32, 2723871.33, 4278000.78, 5624476.65, 7334647.79, 7099687.93, 44847484.51, ...
                  17931544.98, 24978451.38, 21249405.29, 0];
    BJ28_Right_MT_Volume = calc_injection_volume( list_num_sections, section_width, list_areas );

    %%% BJ28 Left V4

    %%% BJ28 Left MT


    % Diplay Volumes in mm^3
    disp( ['Benny_V4_Volume: ',      num2str(Benny_V4_Volume)]);
    disp( ['BJ23_Right_V4_Volume: ', num2str(BJ23_Right_V4_Volume)]);
    disp( ['BJ23_Right_MT_Volume: ', num2str(BJ23_Right_MT_Volume)]);
    disp( ['BJ28_Right_V4_Volume: ', num2str(BJ28_Right_V4_Volume)]);
    disp( ['BJ28_Right_MT_Volume: ', num2str(BJ28_Right_MT_Volume)]);

end


function total_volume_mm = calc_injection_volume( list_num_sections, section_width, list_areas )

    for i = 1:length(list_num_sections)

        area_1 = list_areas(i);
        area_2 = list_areas(i+1);

        num_sections = list_num_sections(i);

        volumes = [];

        for j = 1:(num_sections)
            incremental_area = (area_2 - area_1) / num_sections;
            section_volume = (area_1 + incremental_area) * j * section_width;
            volumes(j) = section_volume;
        end

        total_volume = sum( volumes );
        total_volume_mm = total_volume * 10^-9;
    end
end