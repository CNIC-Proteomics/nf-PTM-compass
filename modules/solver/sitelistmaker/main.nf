process DM0SOLVER {
    tag '01'
    label 'process_medium'

    input:
    path input_file
    val  params_file

    output:
    path "${input_file.baseName}_DM0S.txt", emit: ofile
    path "*_log.txt", emit: log

    script:
    """
    source ${SOLVER_HOME}/env/bin/activate && python ${SOLVER_HOME}/SiteListMaker.py -i "${input_file}" -c "${params_file}"
    """
}
