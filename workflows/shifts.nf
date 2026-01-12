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
    sch_files
    exp_table
    peak_file
    params_file

    main:
    //
    // SUBMODULE: adapter the input files
    //
    ADAPTER('01', sch_files)
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
    DMtable         = PEAK_MODELLER.out.oDMtable
    Histogram       = PEAK_MODELLER.out.oHistogram
    Plot            = PEAK_MODELLER.out.oPlot
    Apexlist        = PEAK_SELECTOR.out.oApexlist
    HistogramPlot   = PEAK_INSPECTOR.out.oHistogramPlot
    Peakassign      = PEAK_ASSIGNATOR.out.oPeakassign
    FDRfiltered     = PEAK_FDRER.out.oFDRfiltered


    emit:
    DMtable
    Histogram
    Plot
    Apexlist
    HistogramPlot
    Peakassign
    FDRfiltered
}


/*
========================================================================================
    THE END
========================================================================================
*/
