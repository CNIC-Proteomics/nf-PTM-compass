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
include { SHIFTS_PEAK_INSPECTOR }     from '../modules/shifts/peakinspector/main'
include { SHIFTS_PEAK_SELECTOR }     from '../modules/shifts/peakselector/main'
include { SHIFTS_RECOM_FILTERER }     from '../modules/shifts/recomfilterer/main'
include { SHIFTS_PEAK_ASSIGNATOR }     from '../modules/shifts/peakassignator/main'





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
    // SHIFTS_PEAK_MODELLER(SHIFTS_DM_CALIBRATOR.out.ofile)
    SHIFTS_PEAK_MODELLER(SHIFTS_DM_CALIBRATOR.out.ofile.collect())
    //
    // SUBMODULE: Peak inspector
    //
    SHIFTS_PEAK_INSPECTOR(SHIFTS_PEAK_MODELLER.out.oDMtable)
    //
    // SUBMODULE: Peak selector
    //
    SHIFTS_PEAK_SELECTOR(SHIFTS_PEAK_MODELLER.out.ohistogram)
    //
    // SUBMODULE: Recom filterer
    //
    SHIFTS_RECOM_FILTERER(SHIFTS_PEAK_MODELLER.out.oDMtable)
    //
    // SUBMODULE: Peak assignator
    //
    SHIFTS_PEAK_ASSIGNATOR(SHIFTS_RECOM_FILTERER.out.ofile,SHIFTS_PEAK_SELECTOR.out.ofile)
    //
    // SUBMODULE: Peak fdrer
    //
    SHIFTS_PEAK_FDRER(SHIFTS_PEAK_ASSIGNATOR.out.ofile)


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
