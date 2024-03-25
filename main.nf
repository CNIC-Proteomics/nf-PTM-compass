#!/usr/bin/env nextflow

nextflow.enable.dsl = 2


/*
========================================================================================
    VALIDATE & PRINT PARAMETER SUMMARY
========================================================================================
*/

// Under construction
WorkflowMain.initialise(workflow, params, log)

/*
========================================================================================
    IMPORT LOCAL MODULES/SUBWORKFLOWS
========================================================================================
*/

include { REFRAG } from './workflows/refrag'
include { SHIFTS } from './workflows/shifts'
include { SOLVER } from './workflows/solver'


//
// SUBWORKFLOW: Create input channels
//
include {
    CREATE_INPUT_CHANNEL_PTMCOMPASS;
    CREATE_INPUT_CHANNEL_REFRAG;
    CREATE_INPUT_CHANNEL_SHIFTS;
    CREATE_INPUT_CHANNEL_SOLVER
} from './subworkflows/create_input_channel'


/*
========================================================================================
    DEFINED WORKFLOWS
========================================================================================
*/

//
// WORKFLOW: Run main analysis pipeline
//

workflow PTM_COMPASS {
    //
    // SUBWORKFLOW: Create input channel
    //
    CREATE_INPUT_CHANNEL_PTMCOMPASS()
    // WORKFLOW: Run SHIFTS analysis pipeline
    //
    SHIFTS(
        CREATE_INPUT_CHANNEL_PTMCOMPASS.out.ch_re_files,
        CREATE_INPUT_CHANNEL_PTMCOMPASS.out.ch_exp_table,
        CREATE_INPUT_CHANNEL_PTMCOMPASS.out.ch_params_file
    )
    //
    // WORKFLOW: Run SOLVER analysis pipeline
    //
    SOLVER(
        SHIFTS.out.FDRfiltered,
        SHIFTS.out.Apexlist,
        CREATE_INPUT_CHANNEL_PTMCOMPASS.out.ch_database,
        CREATE_INPUT_CHANNEL_PTMCOMPASS.out.ch_sitelist_file,
        CREATE_INPUT_CHANNEL_PTMCOMPASS.out.ch_groupmaker_file,
        CREATE_INPUT_CHANNEL_PTMCOMPASS.out.ch_params_file
    )
}

workflow SHIFTS_WORKFLOW {
    //
    // SUBWORKFLOW: Create input channel
    //
    CREATE_INPUT_CHANNEL_SHIFTS()
    // WORKFLOW: Run SHIFTS analysis pipeline
    //
    SHIFTS(
        CREATE_INPUT_CHANNEL_SHIFTS.out.ch_re_files,
        CREATE_INPUT_CHANNEL_SHIFTS.out.ch_exp_table,
        CREATE_INPUT_CHANNEL_SHIFTS.out.ch_params_file
    )
}

workflow SOLVER_WORKFLOW {
    //
    // SUBWORKFLOW: Create input channel
    //
    CREATE_INPUT_CHANNEL_SOLVER()
    //
    // WORKFLOW: Run SOLVER analysis pipeline
    //
    SOLVER(
        CREATE_INPUT_CHANNEL_SOLVER.out.ch_peakfdr_file,
        CREATE_INPUT_CHANNEL_SOLVER.out.ch_apexlist_file,
        CREATE_INPUT_CHANNEL_SOLVER.out.ch_database,
        CREATE_INPUT_CHANNEL_SOLVER.out.ch_sitelist_file,
        CREATE_INPUT_CHANNEL_SOLVER.out.ch_groupmaker_file,
        CREATE_INPUT_CHANNEL_SOLVER.out.ch_params_file
    )
}

workflow REFRAG_WORKFLOW {
    //
    // SUBWORKFLOW: Create input channels
    //
    CREATE_INPUT_CHANNEL_REFRAG ()
    //
    // WORKFLOW: ReFrag analysis
    //
    REFRAG(
        CREATE_INPUT_CHANNEL_REFRAG.out.ch_msf_raw_files,
        CREATE_INPUT_CHANNEL_REFRAG.out.ch_dm_file,
        CREATE_INPUT_CHANNEL_REFRAG.out.ch_params_file
    )
}


/*
========================================================================================
    RUN ALL WORKFLOWS
========================================================================================
*/

// Info required for completion email and summary
def multiqc_report = []

//
// WORKFLOW: Execute a single named workflow for the pipeline
//
workflow {

    // // Select the type of workflow
    // if ( 'ptm_compass' == params.wkf ) {
    //     PTM_COMPASS()
    // } else if ( 'refrag' == params.wkf ) {
    //     REFRAG_WORKFLOW()
    // } else if ( 'shifts' == params.wkf ) {
    //     SHIFTS_WORKFLOW()
    // } else if ( 'solver' == params.wkf ) {
    //     SOLVER_WORKFLOW()
    // } else {
    //     println "Define a correct workflow: [ptm_compass,refrag,shifts,solver]"
    // }
    // Execute the PTM-compass workflow
    PTM_COMPASS()
}

/*
========================================================================================
    COMPLETION EMAIL AND SUMMARY
========================================================================================
*/

// workflow.onComplete {
//     if (params.email || params.email_on_fail) {
//         NfcoreTemplate.email(workflow, params, summary_params, projectDir, log, multiqc_report)
//     }
//     NfcoreTemplate.summary(workflow, params, log)
//     if (params.hook_url) {
//         NfcoreTemplate.IM_notification(workflow, params, summary_params, projectDir, log)
//     }
// }

/*
========================================================================================
    THE END
========================================================================================
*/
