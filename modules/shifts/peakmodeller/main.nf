process SHIFTS_PEAK_MODELLER {

    label 'process_high'

    input:
    path input_file

    output:
    path "PeakModeller_DMTable.feather", emit: oDMtable
    path "PeakModeller_DMHistogram.tsv", emit: ohistogram
    path "*_log.txt", emit: log

    script:
    """
    python ${SHIFTS_HOME}/PeakModeller.py -i "*_Unique_calibrated.feather" -c "${params.params_shifts}"
    """
}
