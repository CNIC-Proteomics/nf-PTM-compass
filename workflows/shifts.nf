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

include { ADAPTER }              from '../modules/shifts/adapter/main'
include { DUPLICATE_REMOVER }    from '../modules/shifts/duplicateremover/main'
include { DM_CALIBRATOR }     from '../modules/shifts/dmcalibrator/main'
include { PEAK_MODELLER }     from '../modules/shifts/peakmodeller/main'
include { PEAK_INSPECTOR }     from '../modules/shifts/peakinspector/main'
include { PEAK_SELECTOR }     from '../modules/shifts/peakselector/main'
include { RECOM_FILTERER }     from '../modules/shifts/recomfilterer/main'
include { PEAK_ASSIGNATOR }     from '../modules/shifts/peakassignator/main'
include { PEAK_FDRER }     from '../modules/shifts/peakfdrer/main'


/*
========================================================================================
    RUN MAIN WORKFLOW
========================================================================================
*/

workflow SHIFTS {

    take:
    re_files
    exp_table
    params_file

    main:
    //
    // SUBMODULE: adapter the input files
    //
    ADAPTER(re_files)
    //
    // SUBMODULE: remove duplicates
    //
    DUPLICATE_REMOVER(ADAPTER.out.ofile)
    //
    // SUBMODULE: DM calibrator
    //
    DM_CALIBRATOR(DUPLICATE_REMOVER.out.ofile, params_file)
    //
    // SUBMODULE: Peak modelller
    //
    PEAK_MODELLER(DM_CALIBRATOR.out.ofile.collect(), params_file)
    //
    // SUBMODULE: Peak inspector
    //
    // PEAK_INSPECTOR(PEAK_MODELLER.out.oDMtable, params_file)
    //
    // SUBMODULE: Peak selector
    //
    PEAK_SELECTOR(PEAK_MODELLER.out.oHistogram, params_file)
    //
    // SUBMODULE: Recom filterer
    //
    RECOM_FILTERER(PEAK_MODELLER.out.oDMtable, params_file)
    //
    // SUBMODULE: Peak assignator
    //
    PEAK_ASSIGNATOR(RECOM_FILTERER.out.oRecomfiltered, PEAK_SELECTOR.out.oApexlist, params_file, 'PeakAssignator')
    //
    // SUBMODULE: Peak fdrer
    //
    PEAK_FDRER(PEAK_ASSIGNATOR.out.oPeakassign, exp_table, params_file)

    // return channels
    ch_DMtable         = PEAK_MODELLER.out.oDMtable
    ch_Histogram       = PEAK_MODELLER.out.oHistogram
    ch_Apexlist        = PEAK_SELECTOR.out.oApexlist
    ch_Recomfiltered   = RECOM_FILTERER.out.oRecomfiltered
    ch_Peakassign      = PEAK_ASSIGNATOR.out.oPeakassign
    ch_FDRfiltered     = PEAK_FDRER.out.oFDRfiltered

    emit:
    DMtable         = ch_DMtable
    Histogram       = ch_Histogram
    Apexlist        = ch_Apexlist
    Recomfiltered   = ch_Recomfiltered
    Peakassign      = ch_Peakassign
    FDRfiltered     = ch_FDRfiltered
}

/*
========================================================================================
    THE END
========================================================================================
*/
