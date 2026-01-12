/*
========================================================================================
    IMPORT LOCAL MODULES/SUBWORKFLOWS
========================================================================================
*/

include { SHIFTS } from './shifts'
include { SOLVER } from './solver'


//
// SUBWORKFLOW: Create input channels
//
include { CREATE_INPUT_CHANNEL_PTMCOMPASS } from '../nf-modules/subworkflows/ptm_compass'


/*
========================================================================================
    DEFINED WORKFLOWS
========================================================================================
*/

//
// WORKFLOW: Run main analysis pipeline using the MSFragger search engine and/or with the REFMOD adaptor
//

workflow PTM_COMPASS_WORKFLOW {
    //
    // SUBWORKFLOW: Create channels based on the type of input
    //
    CREATE_INPUT_CHANNEL_PTMCOMPASS()
    //
    // WORKFLOW: Run SHIFTS analysis pipeline
    //
    SHIFTS(
        CREATE_INPUT_CHANNEL_PTMCOMPASS.out.ch_sch_files,
        CREATE_INPUT_CHANNEL_PTMCOMPASS.out.ch_exp_table,
        CREATE_INPUT_CHANNEL_PTMCOMPASS.out.ch_peak_file,
        CREATE_INPUT_CHANNEL_PTMCOMPASS.out.ch_params_file
    )
    //
    // WORKFLOW: Run SOLVER analysis pipeline
    //
    SOLVER(
        SHIFTS.out.FDRfiltered,
        SHIFTS.out.Apexlist,
        CREATE_INPUT_CHANNEL_PTMCOMPASS.out.ch_exp_table,
        CREATE_INPUT_CHANNEL_PTMCOMPASS.out.ch_database,
        CREATE_INPUT_CHANNEL_PTMCOMPASS.out.ch_sitelist_file,
        CREATE_INPUT_CHANNEL_PTMCOMPASS.out.ch_groupmaker_file,
        CREATE_INPUT_CHANNEL_PTMCOMPASS.out.ch_params_file
    )
}


/*
========================================================================================
    THE END
========================================================================================
*/
