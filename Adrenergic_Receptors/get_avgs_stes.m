function rslt = get_avgs_stes( immunostruct )
    rslt.A1AR_NeuN   = avg_X_animals( immunostruct, 'Alpha1AR', 'NeuN', 'FEF' );
    rslt.A1AR_Nrg    = avg_X_animals( immunostruct, 'Alpha1AR', 'Neurogranin', 'FEF' );
    rslt.A1AR_SMI32  = avg_X_animals( immunostruct, 'Alpha1AR', 'SMI-32', 'FEF' );
    rslt.A1AR_RatPyr = avg_X_animals( immunostruct, 'Alpha1AR', 'Rat-Pyramidal', 'FEF' );
    rslt.A1AR_Parv   = avg_X_animals( immunostruct, 'Alpha1AR', 'Parvalbumin', 'FEF' );
    rslt.A1AR_Calb   = avg_X_animals( immunostruct, 'Alpha1AR', 'Calbindin', 'FEF' );
    rslt.A1AR_Calr   = avg_X_animals( immunostruct, 'Alpha1AR', 'Calretinin', 'FEF' );
    rslt.A1AR_Som    = avg_X_animals( immunostruct, 'Alpha1AR', 'Somatostatin', 'FEF' );

    rslt.A2AR_NeuN   = avg_X_animals( immunostruct, 'Alpha2AR', 'NeuN', 'FEF' );
    rslt.A2AR_Nrg    = avg_X_animals( immunostruct, 'Alpha2AR', 'Neurogranin', 'FEF' );
    rslt.A2AR_SMI32  = avg_X_animals( immunostruct, 'Alpha2AR', 'SMI-32', 'FEF' );
    rslt.A2AR_RatPyr = avg_X_animals( immunostruct, 'Alpha2AR', 'Rat-Pyramidal', 'FEF' );
    rslt.A2AR_Parv   = avg_X_animals( immunostruct, 'Alpha2AR', 'Parvalbumin', 'FEF' );
    rslt.A2AR_Calb   = avg_X_animals( immunostruct, 'Alpha2AR', 'Calbindin', 'FEF' );
    rslt.A2AR_Calr   = avg_X_animals( immunostruct, 'Alpha2AR', 'Calretinin', 'FEF' );
    rslt.A2AR_Som    = avg_X_animals( immunostruct, 'Alpha2AR', 'Somatostatin', 'FEF' );

    rslt.B1R_NeuN   = avg_X_animals( immunostruct, 'Beta1R', 'NeuN', 'FEF' );
    rslt.B1R_Nrg    = avg_X_animals( immunostruct, 'Beta1R', 'Neurogranin', 'FEF' );
    rslt.B1R_SMI32  = avg_X_animals( immunostruct, 'Beta1R', 'SMI-32', 'FEF' );
    rslt.B1R_RatPyr = avg_X_animals( immunostruct, 'Beta1R', 'Rat-Pyramidal', 'FEF' );
    rslt.B1R_Parv   = avg_X_animals( immunostruct, 'Beta1R', 'Parvalbumin', 'FEF' );
    rslt.B1R_Calb   = avg_X_animals( immunostruct, 'Beta1R', 'Calbindin', 'FEF' );
    rslt.B1R_Calr   = avg_X_animals( immunostruct, 'Beta1R', 'Calretinin', 'FEF' );
    rslt.B1R_Som    = avg_X_animals( immunostruct, 'Beta1R', 'Somatostatin', 'FEF' );

    rslt.B2R_NeuN   = avg_X_animals( immunostruct, 'Beta2R', 'NeuN', 'FEF' );
    rslt.B2R_Nrg    = avg_X_animals( immunostruct, 'Beta2R', 'Neurogranin', 'FEF' );
    rslt.B2R_SMI32  = avg_X_animals( immunostruct, 'Beta2R', 'SMI-32', 'FEF' );
    rslt.B2R_RatPyr = avg_X_animals( immunostruct, 'Beta2R', 'Rat-Pyramidal', 'FEF' );
    rslt.B2R_Parv   = avg_X_animals( immunostruct, 'Beta2R', 'Parvalbumin', 'FEF' );
    rslt.B2R_Calb   = avg_X_animals( immunostruct, 'Beta2R', 'Calbindin', 'FEF' );
    rslt.B2R_Calr   = avg_X_animals( immunostruct, 'Beta2R', 'Calretinin', 'FEF' );
    rslt.B2R_Som    = avg_X_animals( immunostruct, 'Beta2R', 'Somatostatin', 'FEF' );
end