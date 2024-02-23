process SHIFTS_PEAK_SELECTOR {
    tag '06'
    label 'process_medium'

    input:
    path input_file

    output:
    path "PeakModeller_ApexList.txt", emit: oApexlist
    path "*_log.txt", emit: log

    script:
    """
    source ${SHIFTS_HOME}/env/bin/activate && python ${SHIFTS_HOME}/PeakSelector.py -i "${input_file}" -c "${params.params_file}"
    """
}
