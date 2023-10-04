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

include { SHIFTS_ADAPTER }              from '../modules/shifts/adapter/main'
include { SHIFTS_DUPLICATE_REMOVER }    from '../modules/shifts/duplicateremover/main'
include { SHIFTS_DM_CALIBRATOR }     from '../modules/shifts/dmcalibrator/main'
include { SHIFTS_PEAK_MODELLER }     from '../modules/shifts/peakmodeller/main'


//
// SUBWORKFLOW: Consisting of a mix of local and nf-core/modules
//
// include { INPUT_CHECK } from '../subworkflows/input_check'



/*
========================================================================================
    RUN MAIN WORKFLOW
========================================================================================
*/

// Info required for completion email and summary
def multiqc_report = []

workflow SHIFTS {

    take:
    input_file

    main:
    //
    // SUBMODULE: adapter the input files
    //
    SHIFTS_ADAPTER(input_file)
    //
    // SUBMODULE: remove duplicates
    //
    SHIFTS_DUPLICATE_REMOVER(SHIFTS_ADAPTER.out.ofile)
    //
    // SUBMODULE: DM calibrator
    //
    SHIFTS_DM_CALIBRATOR(SHIFTS_DUPLICATE_REMOVER.out.ofile)
    //
    // SUBMODULE: Peak modelller
    //
    SHIFTS_PEAK_MODELLER(SHIFTS_DM_CALIBRATOR.out.ofile)

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
