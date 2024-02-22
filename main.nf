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
// SUBWORKFLOW: Consisting of a mix of local and nf-core/modules
//
include { CREATE_INPUT_CHANNEL } from './subworkflows/create_input_channel'


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
    CREATE_INPUT_CHANNEL (
        params.input_files
    )
    //
    // WORKFLOW: Run SHIFTS analysis pipeline
    //
    SHIFTS(CREATE_INPUT_CHANNEL.out.input_file)
}

workflow SOLVER_WORKFLOW {
    //
    // SUBWORKFLOW: Create input channel
    //
    CREATE_INPUT_CHANNEL (
        params.input_files
    )
    //
    // WORKFLOW: Run SHIFTS analysis pipeline
    //
    SOLVER(CREATE_INPUT_CHANNEL.out.input_file)
}

workflow PTM_COMPASS {
    //
    // SUBWORKFLOW: Read in samplesheet, validate and stage input files
    //
    //
    // SUBWORKFLOW: Create input channel
    //
    CREATE_INPUT_CHANNEL (
        params.input_files
    )
    //
    // SUBWORKFLOW: File preparation
    //
    // // Create output dirs
    // if ( 'output_dir' in params ) {
    //     output_dir = "$params.output_dir"
    //     r = file(output_dir).mkdirs()
    //     println r ? "OK creating the directory: $output_dir" : "Cannot create directory: $output_dir"
    // }
    //
    // WORKFLOW: Run SHIFTS analysis pipeline
    //
    SHIFTS(CREATE_INPUT_CHANNEL.out.input_file)
    //
    // WORKFLOW: Run SOLVER analysis pipeline
    //
    SOLVER(CREATE_INPUT_CHANNEL.out.input_file)
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
    } elif ( 'shifts' == params.wkf ) {
        SHIFTS()
    } elif ( 'solver' == params.wkf ) {
        SOLVER()
    } else {
        println "Define a correctly workflow: [ptm_compass,shifts,solver]"
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
