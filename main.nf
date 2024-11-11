#!/usr/bin/env nextflow

nextflow.enable.dsl = 2


/*
========================================================================================
    VALIDATE & PRINT PARAMETER SUMMARY
========================================================================================
*/

// TODO!! Try to change the path "Groovy" libs and locate in the nf-modules
WorkflowMain.initialise(workflow, params, log)

/*
========================================================================================
    IMPORT MAIN LOCAL MODULES/SUBWORKFLOWS
========================================================================================
*/

include {
    PTM_COMPASS_WORKFLOW;
    PTM_COMPASS_WORKFLOW_REFMOD;
    PTM_COMPASS_WORKFLOW_RECOM;
    REFMOD_WORKFLOW;
    SHIFTS_WORKFLOW;
    SOLVER_WORKFLOW
} from './workflows/main'


/*
========================================================================================
    RUN MAIN WORKFLOW
========================================================================================
*/

// Info required for completion email and summary
def multiqc_report = []

//
// WORKFLOW: Execute the named workflow for the pipeline
//
workflow {

    // Execute main workflow based on the given input
    if ( params.containsKey('search_engine') && params.search_engine == 'comet' ) {
        PTM_COMPASS_WORKFLOW_RECOM()
    } else {
        PTM_COMPASS_WORKFLOW()
        // PTM_COMPASS_WORKFLOW_REFMOD()  
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
