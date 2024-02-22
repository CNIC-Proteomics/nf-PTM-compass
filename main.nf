#!/usr/bin/env nextflow
/*
========================================================================================
    PTM-compass
========================================================================================
    Github : https://github.com/CNIC-Proteomics/ptm-compass
----------------------------------------------------------------------------------------
*/

nextflow.enable.dsl = 2

// Define a variable to track process order
process_order = 0



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
    NAMED WORKFLOW FOR PIPELINE
========================================================================================
*/

include { PTM_COMPASS } from './workflows/ptmcompass'


//
// WORKFLOW: Run main ptm-compass analysis pipeline
//

workflow CNIC_WORKFLOW {
    PTM_COMPASS()
}

/*
========================================================================================
    RUN ALL WORKFLOWS
========================================================================================
*/

//
// WORKFLOW: Execute a single named workflow for the pipeline
//
workflow {
    CNIC_WORKFLOW()
}

/*
========================================================================================
    THE END
========================================================================================
*/
