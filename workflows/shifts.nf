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
include { SHIFTS_PEAK_FDRER }     from '../modules/shifts/peakfdrer/main'


/*
========================================================================================
    RUN MAIN WORKFLOW
========================================================================================
*/

workflow SHIFTS {

    take:
    re_files
    exp_table

    main:
    //
    // SUBMODULE: adapter the input files
    //
    SHIFTS_ADAPTER(re_files)
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
    // SHIFTS_PEAK_INSPECTOR(SHIFTS_PEAK_MODELLER.out.oDMtable)
    //
    // SUBMODULE: Peak selector
    //
    SHIFTS_PEAK_SELECTOR(SHIFTS_PEAK_MODELLER.out.oHistogram)
    //
    // SUBMODULE: Recom filterer
    //
    SHIFTS_RECOM_FILTERER(SHIFTS_PEAK_MODELLER.out.oDMtable)
    //
    // SUBMODULE: Peak assignator
    //
    SHIFTS_PEAK_ASSIGNATOR(SHIFTS_RECOM_FILTERER.out.oRecomfiltered,SHIFTS_PEAK_SELECTOR.out.oApexlist)
    //
    // SUBMODULE: Peak fdrer
    //
    SHIFTS_PEAK_FDRER(SHIFTS_PEAK_ASSIGNATOR.out.oPeakassign,exp_table)

    // return channels
    ch_DMtable         = SHIFTS_PEAK_MODELLER.out.oDMtable
    ch_Histogram       = SHIFTS_PEAK_MODELLER.out.oHistogram
    ch_Apexlist        = SHIFTS_PEAK_SELECTOR.out.oApexlist
    ch_Recomfiltered   = SHIFTS_RECOM_FILTERER.out.oRecomfiltered
    ch_Peakassign      = SHIFTS_PEAK_ASSIGNATOR.out.oPeakassign
    ch_FDRfiltered     = SHIFTS_PEAK_FDRER.out.oFDRfiltered

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
