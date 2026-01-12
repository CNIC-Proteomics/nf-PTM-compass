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

include { PTM_COMPASS_WORKFLOW } from './workflows/main'


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

    PTM_COMPASS_WORKFLOW()

}

/*
========================================================================================
    THE END
========================================================================================
*/
