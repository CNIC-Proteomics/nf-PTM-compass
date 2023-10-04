process SHIFTS_DM_CALIBRATOR {

    label 'process_medium'

    input:
    path input_file

    output:
    path "${input_file.baseName}_calibrated.feather", emit: ofile

    script:
    """
    python /usr/local/shifts_v4/DMcalibrator.py -i "${input_file}" -c "${params.params_shifts}"
    """
}
