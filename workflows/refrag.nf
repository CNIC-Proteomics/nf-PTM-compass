/*
========================================================================================
    IMPORT LOCAL MODULES/SUBWORKFLOWS
========================================================================================
*/

include { RE_FRAG }               from '../nf-modules/refrag/main'

/*
========================================================================================
    RUN MAIN WORKFLOW
========================================================================================
*/

workflow REFRAG {

    take:
    raw_msf_files
    dm_file
    params_file

    main:
    //
    // SUBMODULE: execute ReFrag
    //
    RE_FRAG('01', raw_msf_files, dm_file, params_file)

    // return channels
    ch_ofile         = RE_FRAG.out.ofile

    emit:
    ofile       = ch_ofile
}

/*
========================================================================================
    THE END
========================================================================================
*/
