process DM_CALIBRATOR {
    tag '03'
    label 'process_medium'

    input:
    path input_file
    val params_file

    output:
    path "${input_file.baseName}_calibrated.feather", emit: ofile
    path "*_log.txt", emit: log

    script:
    """
    source ${SHIFTS_HOME}/env/bin/activate && python ${SHIFTS_HOME}/DMcalibrator.py -i "${input_file}" -c "${params_file}"
    """

}
