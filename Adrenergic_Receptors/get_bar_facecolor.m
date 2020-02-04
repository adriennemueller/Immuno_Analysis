function rslt = get_bar_facecolor( type, num )

    excit_map = [1 0.463 0
                 1 0.655 0.361
                 1 0.561 0.18
                 0.867 0.40 0];
  
   inhib_map = [0.071 0.267 0.757
                0.349 0.478 0.808
                0.208 0.369 0.773
                0.047 0.20 0.58];

    if strcmp(type, 'excit')
        rslt = excit_map( num, : );
    elseif strcmp(type, 'inhib')
        rslt = inhib_map( num, : );
    else
        disp( 'Unknown neuron plot type.' )
    end

end
    