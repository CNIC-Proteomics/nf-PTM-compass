process PEAK_ASSIGNATOR {
    tag '08'
    label 'process_medium'

    input:
    path input_file
    path input_file2
    val  params_file
    val  params_sections

    output:
    path "${input_file.baseName}_PeakAssignation.feather", emit: oPeakassign
    path "*_log.txt", emit: log

    script:

    // extract the parameter section and create a new parameter file
    def params_str = Utils.extractParamSection(params_file, params_sections)
    println "STR: ${params_str}"

    // create a new parameter file
    def re_params_file = Utils.writeStrIntoFile(params_str, "peak_assignator_params.ini")

    """
    source ${SHIFTS_HOME}/env/bin/activate && python ${SHIFTS_HOME}/PeakAssignator.py -i "${input_file}" -a "${input_file2}" -c "${re_params_file}"
    """
}
