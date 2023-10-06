process SHIFTS_DM_CALIBRATOR {

    label 'process_medium'

    input:
    path input_file

    output:
    path "${input_file.baseName}_calibrated.feather", emit: ofile

    script:
    /*
    // FOR PRODUCTION
    python /usr/local/shifts_v4/DMcalibrator.py -i "${input_file}" -c "${params.params_shifts}"
    // For debugging in DOCKER
    python /mnt/tierra/PTM-compass/src_old/SHIFTS-4/DMcalibrator.py -i "${input_file}" -c "${params.params_shifts}"
    // For debugging in UBUNTU (WSL)
    python /home/jmrodriguezc/projects/PTM-compass/src_old/SHIFTS-4/DMcalibrator.py -i "${input_file}" -c "${params.params_shifts}"
    */
    """
    python /usr/local/shifts_v4/DMcalibrator.py -i "${input_file}" -c "${params.params_shifts}"
    """

}
