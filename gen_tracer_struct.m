% Matrix of values manually added from spreadsheet.
% Will keep. Will fill in values manually.

function tracer_struct = gen_tracer_struct()

    tracer_struct.CTB488_D1RNeg = 0;
    tracer_struct.CTB488_D1RPos = 0;
    tracer_struct.CTB488_D2RNeg = 2;
    tracer_struct.CTB488_D2RPos = 0;
    
    tracer_struct.CTB555_D1RNeg = 40;
    tracer_struct.CTB555_D1RPos = 448;
    tracer_struct.CTB555_D2RNeg = 261;
    tracer_struct.CTB555_D2RPos = 229;
    
    tracer_struct.D1RPos_Total = tracer_struct.CTB488_D1RPos + tracer_struct.CTB555_D1RPos;
    tracer_struct.D1RNeg_Total = tracer_struct.CTB488_D1RNeg + tracer_struct.CTB555_D1RNeg;
    tracer_struct.D2RPos_Total = tracer_struct.CTB488_D2RPos + tracer_struct.CTB555_D2RPos;
    tracer_struct.D2RNeg_Total = tracer_struct.CTB488_D2RNeg + tracer_struct.CTB555_D2RNeg;
    
    tracer_struct.D1RCount_Total = tracer_struct.D1RPos_Total + tracer_struct.D1RNeg_Total;
    tracer_struct.D2RCount_Total = tracer_struct.D2RPos_Total + tracer_struct.D2RNeg_Total;

end


