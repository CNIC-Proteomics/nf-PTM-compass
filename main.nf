#!/usr/bin/env nextflow
/*
========================================================================================
    PTM-compass
========================================================================================
    Github : https://github.com/CNIC-Proteomics/ptm-compass
----------------------------------------------------------------------------------------
*/

nextflow.enable.dsl = 2


/*
========================================================================================
    VALIDATE & PRINT PARAMETER SUMMARY
========================================================================================
*/

// WorkflowMain.initialise(workflow, params, log)
// a = Utils.getBaseName("/mnt/tierr.txt")
// println "TRYE: ${a}"

/*
========================================================================================
    IMPORT LOCAL MODULES/SUBWORKFLOWS
========================================================================================
*/

// include { PTM_COMPASS } from './workflows/ptmcompass'
include { SHIFTS } from './workflows/shifts'
include { SOLVER } from './workflows/solver'


//
// SUBWORKFLOW: Consisting of a mix of local
//
include { CREATE_INPUT_CHANNEL_SHIFTS } from './subworkflows/create_input_channel'
include { CREATE_INPUT_CHANNEL_SOLVER } from './subworkflows/create_input_channel'


//
// WORKFLOW: Run main ptm-compass analysis pipeline
//

// workflow CNIC_WORKFLOW {
//     PTM_COMPASS()
// }

workflow SHIFTS_WORKFLOW {
    //
    // SUBWORKFLOW: Create input channel
    //
    CREATE_INPUT_CHANNEL_SHIFTS (
        params.inputs
    )
    //
    // WORKFLOW: Run SHIFTS analysis pipeline
    //
    SHIFTS(CREATE_INPUT_CHANNEL_SHIFTS.out.ch_re_files, CREATE_INPUT_CHANNEL_SHIFTS.out.ch_exp_table)
}

workflow SOLVER_WORKFLOW {
    //
    // SUBWORKFLOW: Create input channel
    //
    CREATE_INPUT_CHANNEL_SOLVER (
        params.inputs
    )
    //
    // WORKFLOW: Run SOLVER analysis pipeline
    //
    SOLVER(INPUT_CHANNEL_SOLVER.out.ch_FDRfiltered, INPUT_CHANNEL_SOLVER.out.ch_Apexlist)
}

workflow PTM_COMPASS {
    //
    // SUBWORKFLOW: Create input channel
    //
    CREATE_INPUT_CHANNEL_SHIFTS (
        params.inputs
    )
    // WORKFLOW: Run SHIFTS analysis pipeline
    //
    println "CHANNEL: $CREATE_INPUT_CHANNEL_SHIFTS.out.ch_exp_table"
    SHIFTS(CREATE_INPUT_CHANNEL_SHIFTS.out.ch_re_files, CREATE_INPUT_CHANNEL_SHIFTS.out.ch_exp_table)
    //
    // WORKFLOW: Run SOLVER analysis pipeline
    //
    SOLVER(SHIFTS.out.FDRfiltered, SHIFTS.out.Apexlist)
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

    // Select the type of workflow
    if ( 'ptm_compass' == params.wkf ) {
        // CNIC_WORKFLOW()
        PTM_COMPASS()
    } else if ( 'shifts' == params.wkf ) {
        SHIFTS()
    } else if ( 'solver' == params.wkf ) {
        SOLVER()
    } else {
        println "Define a correct workflow: [ptm_compass,shifts,solver]"
    }

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
