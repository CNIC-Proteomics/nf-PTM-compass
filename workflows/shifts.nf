/*
========================================================================================
    IMPORT MODULES
========================================================================================
*/

include { createParamStrChannel } from '../nf-modules/lib/Utils'


/*
========================================================================================
    IMPORT LOCAL MODULES/SUBWORKFLOWS
========================================================================================
*/

include { ADAPTER }             from '../nf-modules/modules/shifts/adapter/main'
include { DUPLICATE_REMOVER }   from '../nf-modules/modules/shifts/duplicateremover/main'
include { DM_CALIBRATOR }       from '../nf-modules/modules/shifts/dmcalibrator/main'
include { PEAK_MODELLER }       from '../nf-modules/modules/shifts/peakmodeller/main'
include { PEAK_INSPECTOR }      from '../nf-modules/modules/shifts/peakinspector/main'
include { PEAK_SELECTOR }       from '../nf-modules/modules/shifts/peakselector/main'
include { RECOM_FILTERER }      from '../nf-modules/modules/shifts/recomfilterer/main'
include { PEAK_ASSIGNATOR }     from '../nf-modules/modules/shifts/peakassignator/main'
include { PEAK_FDRER }          from '../nf-modules/modules/shifts/peakfdrer/main'


/*
========================================================================================
    RUN MAIN WORKFLOW
========================================================================================
*/

workflow SHIFTS {

    take:
    re_files
    exp_table
    peak_file
    params_file

    main:
    //
    // SUBMODULE: adapter the input files
    //
    ADAPTER('01', re_files)
    //
    // SUBMODULE: remove duplicates
    //
    DUPLICATE_REMOVER('02', ADAPTER.out.ofile, createParamStrChannel(params_file, ['DuplicateRemover','Logging','General'])) // generate string with the current parameters from the given file
    //
    // SUBMODULE: DM calibrator
    //
    DM_CALIBRATOR('03', DUPLICATE_REMOVER.out.ofile, createParamStrChannel(params_file, ['DMcalibrator','Aminoacids','Fixed Modifications','Masses','Logging', 'General']))
    //
    // SUBMODULE: Peak modelller
    //
    PEAK_MODELLER('04', DM_CALIBRATOR.out.ofile.collect(), createParamStrChannel(params_file, ['PeakModeller','Logging','General']))
    //
    // SUBMODULE: Peak selector v2
    //
    PEAK_SELECTOR('05', PEAK_MODELLER.out.oHistogram, createParamStrChannel(params_file, ['PeakSelector','Logging','General']))
    //
    // SUBMODULE: Peak inspector
    //
    PEAK_INSPECTOR('06', PEAK_SELECTOR.out.oHistogram, peak_file, createParamStrChannel(params_file, ['Plot 1','Plot 2','Logging','General']))
    //
    // SUBMODULE: Peak assignator
    //
    PEAK_ASSIGNATOR('07', PEAK_MODELLER.out.oDMtable, PEAK_SELECTOR.out.oApexlist, createParamStrChannel(params_file, ['PeakAssignator','Logging','General']))
    //
    // SUBMODULE: Peak fdrer
    //
    PEAK_FDRER('08', PEAK_ASSIGNATOR.out.oPeakassign, PEAK_SELECTOR.out.oApexlist, exp_table, createParamStrChannel(params_file, ['PeakFDRer','PeakAssignator','Logging','General']))

    // return channels
    ch_DMtable         = PEAK_MODELLER.out.oDMtable
    ch_Histogram       = PEAK_MODELLER.out.oHistogram
    ch_Plot            = PEAK_MODELLER.out.oPlot
    ch_Apexlist        = PEAK_SELECTOR.out.oApexlist
    ch_HistogramPlot   = PEAK_INSPECTOR.out.oHistogramPlot
    ch_Peakassign      = PEAK_ASSIGNATOR.out.oPeakassign
    ch_FDRfiltered     = PEAK_FDRER.out.oFDRfiltered


    emit:
    DMtable         = ch_DMtable
    Histogram       = ch_Histogram
    Plot            = ch_Plot
    Apexlist        = ch_Apexlist
    HistogramPlot   = ch_HistogramPlot
    Peakassign      = ch_Peakassign
    FDRfiltered     = ch_FDRfiltered
}

/* OBSOLETE */
workflow SHIFTS_RECOM {

    take:
    re_files
    exp_table
    params_file

    main:
    //
    // SUBMODULE: adapter the input files
    //
    ADAPTER('01', re_files)
    //
    // SUBMODULE: remove duplicates
    //
    DUPLICATE_REMOVER('02', ADAPTER.out.ofile, params_file)
    //
    // SUBMODULE: DM calibrator
    //
    DM_CALIBRATOR('03', DUPLICATE_REMOVER.out.ofile, params_file)
    //
    // SUBMODULE: Peak modelller
    //
    PEAK_MODELLER('04', DM_CALIBRATOR.out.ofile.collect(), params_file)
    //
    // SUBMODULE: Peak inspector
    //
    PEAK_INSPECTOR('05', PEAK_MODELLER.out.oHistogram)
    //
    // SUBMODULE: Peak selector v2
    //
    PEAK_SELECTOR('06', PEAK_MODELLER.out.oHistogram, params_file)
    //
    // SUBMODULE: Peak inspector
    //
    PEAK_INSPECTOR_2('07', PEAK_SELECTOR.out.oHistogram)
    //
    // SUBMODULE: Recom filterer
    //
    RECOM_FILTERER('08', PEAK_MODELLER.out.oDMtable, params_file)
    //
    // SUBMODULE: Peak assignator
    //
    def params_sections = Channel.value(['PeakAssignator','Logging','General'])
    PEAK_ASSIGNATOR('09', RECOM_FILTERER.out.oRecomfiltered, PEAK_SELECTOR.out.oApexlist, params_file, params_sections)
    //
    // SUBMODULE: Peak fdrer
    //
    PEAK_FDRER('10', PEAK_ASSIGNATOR.out.oPeakassign, exp_table, params_file)

    // return channels
    ch_DMtable         = PEAK_MODELLER.out.oDMtable
    ch_Histogram       = PEAK_MODELLER.out.oHistogram
    ch_Plot            = PEAK_MODELLER.out.oPlot
    ch_HistogramPlot   = PEAK_INSPECTOR.out.oHistogramPlot
    ch_Apexlist        = PEAK_SELECTOR.out.oApexlist
    ch_HistogramPlot2   = PEAK_INSPECTOR_2.out.oHistogramPlot
    // ch_Recomfiltered   = RECOM_FILTERER.out.oRecomfiltered
    ch_Peakassign      = PEAK_ASSIGNATOR.out.oPeakassign
    ch_FDRfiltered     = PEAK_FDRER.out.oFDRfiltered

    emit:
    DMtable         = ch_DMtable
    Histogram       = ch_Histogram
    Plot            = ch_Plot
    HistogramPlot   = ch_HistogramPlot
    Apexlist        = ch_Apexlist
    // Recomfiltered   = ch_Recomfiltered
    Peakassign      = ch_Peakassign
    FDRfiltered     = ch_FDRfiltered
}


/*
========================================================================================
    THE END
========================================================================================
*/
