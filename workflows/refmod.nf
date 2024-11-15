/*
========================================================================================
    IMPORT LOCAL MODULES/SUBWORKFLOWS
========================================================================================
*/

include { REF_MOD }               from '../nf-modules/modules/refmod/main'

/*
========================================================================================
    RUN MAIN WORKFLOW
========================================================================================
*/

workflow REFMOD {

    take:
    raw_msf_files
    dm_file
    params_file

    main:
    //
    // SUBMODULE: execute RefMod
    //
    REF_MOD('01', raw_msf_files, dm_file, params_file)

    // return channels
    ch_ofile         = REF_MOD.out.ofile

    emit:
    ofile       = ch_ofile
}

/*
========================================================================================
    THE END
========================================================================================
*/