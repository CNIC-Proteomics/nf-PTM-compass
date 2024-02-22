process SOLVER_DM0SOLVER {

    label 'process_medium'

    input:
    path input_file
    path input_file2

    output:
    path "${input_file.baseName}_DM0S.txt", emit: ofile
    path "*_log.txt", emit: log

    script:
    """
    source ${SHIFTS_HOME}/env/bin/activate && python ${SHIFTS_HOME}/PeakModeller.py -i "${input_file}" -a "${input_file2}" -c "${params.params_file}"
    """
}
