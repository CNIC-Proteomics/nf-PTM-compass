process PEAK_ASSIGNATOR {
    tag '08'
    label 'process_medium'

    input:
    path input_file
    path input_file2

    output:
    path "${input_file.baseName}_PeakAssignation.feather", emit: oPeakassign
    path "*_log.txt", emit: log

    script:
    """
    source ${SHIFTS_HOME}/env/bin/activate && python ${SHIFTS_HOME}/PeakAssignator.py -i "${input_file}" -a "${input_file2}" -c "${params.params_file}"
    """
}
