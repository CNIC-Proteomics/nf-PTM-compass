/*
========================================================================================
    VALIDATE INPUTS
========================================================================================
*/

/*
========================================================================================
    CONFIG FILES
========================================================================================
*/


/*
========================================================================================
    IMPORT LOCAL MODULES/SUBWORKFLOWS
========================================================================================
*/

include { DM0SOLVER }              from '../modules/solver/dm0solver/main'
include { PROTEIN_ASSIGNER }    from '../modules/proteinassigner/main'


/*
========================================================================================
    RUN MAIN WORKFLOW
========================================================================================
*/

workflow SOLVER {

    take:
    peakfdrer
    apexlist
    database
    params_file

    main:
    //
    // SUBMODULE: DM0 solver
    //
    DM0SOLVER(peakfdrer, apexlist, params_file)
    //
    // SUBMODULE: remove duplicates
    //
    PROTEIN_ASSIGNER(DM0SOLVER.out.ofile, database, params_file)
}

/*
========================================================================================
    THE END
========================================================================================
*/
