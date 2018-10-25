% Matrix of values manually added from spreadsheet.
% Will keep. Will fill in values manually.

function tracer_struct = gen_tracer_struct()

    tracer_struct.CTB488_D1RNeg = 4;
    tracer_struct.CTB488_D1RPos = 63;
    tracer_struct.CTB488_D2RNeg = 18;
    tracer_struct.CTB488_D2RPos = 44;
    
    tracer_struct.CTB555_D1RNeg = 36;
    tracer_struct.CTB555_D1RPos = 401;
    tracer_struct.CTB555_D2RNeg = 252;
    tracer_struct.CTB555_D2RPos = 198;
    
    tracer_struct.D1RPos_Total = tracer_struct.CTB488_D1RPos + tracer_struct.CTB555_D1RPos;
    tracer_struct.D1RNeg_Total = tracer_struct.CTB488_D1RNeg + tracer_struct.CTB555_D1RNeg;
    tracer_struct.D2RPos_Total = tracer_struct.CTB488_D2RPos + tracer_struct.CTB555_D2RPos;
    tracer_struct.D2RNeg_Total = tracer_struct.CTB488_D2RNeg + tracer_struct.CTB555_D2RNeg;
    
    tracer_struct.D1RCount_Total = tracer_struct.D1RPos_Total + tracer_struct.D1RNeg_Total;
    tracer_struct.D2RCount_Total = tracer_struct.D2RPos_Total + tracer_struct.D2RNeg_Total;
    
    tracer_struct.V4_D1R_AcrossAnimal_Mean = 0.9607843137;
    tracer_struct.V4_D1R_AcrossAnimal_STE  = 0.03921568627;
    tracer_struct.V4_D2R_AcrossAnimal_Mean = 0.6829545455;
    tracer_struct.V4_D2R_AcrossAnimal_STE  = 0.09204545455;
    
    tracer_struct.MT_D1R_AcrossAnimal_Mean = 0.9181442824;
    tracer_struct.MT_D1R_AcrossAnimal_STE  = 0.02082285379;
    tracer_struct.MT_D2R_AcrossAnimal_Mean = 0.4345373577;
    tracer_struct.MT_D2R_AcrossAnimal_STE  = 0.1229094508;

    tracer_struct.COMBINED_D1R_AcrossAnimal_Mean = 0.9215674768;
    tracer_struct.COMBINED_D1R_AcrossAnimal_STE  = 0.01004603023;
    tracer_struct.COMBINED_D2R_AcrossAnimal_Mean = 0.556666517;
    tracer_struct.COMBINED_D2R_AcrossAnimal_STE  = 0.1262807486;

end


