process SHIFTS_PEAK_SELECTOR {

    label 'process_medium'

    input:
    path input_file

    output:
    path "${input_file.baseName}_apexlist.txt", emit: ofile
    path "*_log.txt", emit: log

    script:
    """
    source ${SHIFTS_HOME}/env/bin/activate && python ${SHIFTS_HOME}/PeakSelector.py -i "${input_file}" -c "${params.params_shifts}"
    """
}
