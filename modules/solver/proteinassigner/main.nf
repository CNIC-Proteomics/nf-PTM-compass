process SOLVER_PROTEIN_ASSIGNER {

    label 'process_medium'

    input:
    path input_file

    output:
    path "PeakModeller_DMTable.feather", emit: oDMtable
    path "PeakModeller_DMHistogram.tsv", emit: ohistogram
    path "*_log.txt", emit: log

    script:
    """
    source ${SHIFTS_HOME}/env/bin/activate && python ${SHIFTS_HOME}/PeakModeller.py -i "*_Unique_calibrated.feather" -c "${params.params_shifts}"
    """
}
