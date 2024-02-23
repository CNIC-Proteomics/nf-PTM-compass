process SHIFTS_PEAK_MODELLER {
    tag '04'
    label 'process_high'

    input:
    path input_file

    output:
    path "PeakModeller_DMTable.feather", emit: oDMtable
    path "PeakModeller_DMHistogram.tsv", emit: oHistogram
    path "*_log.txt", emit: log

    script:
    """
    source ${SHIFTS_HOME}/env/bin/activate && python ${SHIFTS_HOME}/PeakModeller.py -i "*_Unique_calibrated.feather" -c "${params.params_file}"
    """
}
