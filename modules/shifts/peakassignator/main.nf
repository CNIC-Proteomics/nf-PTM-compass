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
    path "peak_assignator_params.ini", emit: ofile_param
    // path "*_log.txt", emit: log

    exec:

    // extract the parameter section and create a new parameter file
    def params_str = Utils.extractParamSection(params_file, params_sections)

    // create a new parameter file
    // def ii = task.workDir.resolve(input_file).text
    // println "II: ${ii}"
    // def re_params_file = input_file.resolve('peak_assignator_params.ini').text
    // println "PARA_FILE: ${re_params_file}"
    // re_params_file = Utils.writeStrIntoFile(params_str, re_params_file)
    def re_params_file = Utils.writeStrIntoFile(params_str, "peak_assignator_params.ini")

    def re_params_file2 = new File("PeakModeller_DMTable_RECOMfiltered_PeakAssignation.feather")
    re_params_file.write("KK")


    // """
    // source ${SHIFTS_HOME}/env/bin/activate && python ${SHIFTS_HOME}/PeakAssignator.py -i "${input_file}" -a "${input_file2}" -c "${re_params_file}"
    // """
}
