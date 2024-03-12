process PEAK_ASSIGNATOR {
    tag "${order}"
    label 'process_medium'

    input:
    val  order
    path input_file
    path input_file2
    val  params_file
    val  params_sections

    output:
    path "*_PeakAssignation.feather", emit: oPeakassign if input_file.extension == '.feather', path "*_PeakAssignation.tsv", emit: oPeakassign if input_file.extension == '.tsv'
    path "peak_assignator_params.ini", emit: ofile_param
    path "*_log.txt", emit: log

    script:
    // extract the parameter section and create a new parameter file
    def params_str = Utils.extractParamSection(params_file, params_sections)
    params_str = params_str.replaceAll(/\[PeakAssignator_[^\]]*\]/, '[PeakAssignator]')

    // create a new parameter file
    // def re_params_file = Utils.writeStrIntoFile(params_str, "peak_assignator_params.ini")
    def re_params_file = "peak_assignator_params.ini"

    """
    # create the new parameter file
    echo "${params_str}" > "${re_params_file}"

    source ${SHIFTS_HOME}/env/bin/activate && python ${SHIFTS_HOME}/PeakAssignator.py -i "${input_file}" -a "${input_file2}" -c "${re_params_file}"
    """
}
