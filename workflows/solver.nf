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
include { SITELIST_MAKER }              from '../modules/solver/sitelistmaker/main'


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
    DM0SOLVER('01', peakfdrer, apexlist, params_file)
    //
    // SUBMODULE: protein assigner
    //
    PROTEIN_ASSIGNER('02', DM0SOLVER.out.ofile, database, params_file)
    //
    // SUBMODULE: Peak assignator
    //
    def params_sections = Channel.value(['PeakAssignator_in_Solver','Logging','General'])
    PEAK_ASSIGNATOR('03', PROTEIN_ASSIGNER.out.ofile, apexlist, params_file, params_sections)
    //
    // SUBMODULE: Site list maker
    //
    SITELIST_MAKER('04', PEAK_ASSIGNATOR.out.oPeakassign, apexlist, params_file, params_sections)

    // return channels
    ch_DM0solver       = DM0SOLVER.out.ofile
    ch_MProtein        = PROTEIN_ASSIGNER.out.ofile
    ch_Peakassign      = PEAK_ASSIGNATOR.out.oPeakassign

    emit:
    DM0solver       = ch_DM0solver
    MProtein        = ch_MProtein
    Peakassign      = ch_Peakassign
}

/*
========================================================================================
    THE END
========================================================================================
*/
