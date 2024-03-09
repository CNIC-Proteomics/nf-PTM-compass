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
include { PEAK_ASSIGNATOR }     from '../modules/shifts/peakassignator/main'


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
    // SUBMODULE: protein assigner
    //
    PROTEIN_ASSIGNER(DM0SOLVER.out.ofile, database, params_file)
    //
    // SUBMODULE: Peak assignator
    //
    def params_sections = Channel.value(['PeakAssignator_2','Logging'])
    PEAK_ASSIGNATOR(PROTEIN_ASSIGNER.out.ofile, apexlist, params_file, params_sections)

}

/*
========================================================================================
    THE END
========================================================================================
*/
