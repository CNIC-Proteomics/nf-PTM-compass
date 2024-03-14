process GROUP_MAKER {
    tag "${order}"
    label 'process_medium'

    input:
    val  order
    path input_file
    path database
    val  params_file

    output:
    path "_PDMTable.txt", emit: ofile
    path "*_log.txt", emit: log

    script:
    """
    source ${SOLVER_HOME}/env/bin/activate && python ${SOLVER_HOME}/PDMTableMaker_V7.py -i "${re_input_file}" -f "${database}" -c "${params_file}"
    """
}
