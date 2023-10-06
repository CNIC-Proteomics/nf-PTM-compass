process SHIFTS_PEAK_MODELLER {

    label 'process_high'

    input:
    path input_file

    output:
    path "PeakModeller_DMTable.feather"

    script:
    /*
    // FOR PRODUCTION
    python /usr/local/shifts_v4/PeakModeller.py -i "${input_file}" -c "${params.params_shifts}"
    // For debugging in DOCKER
    python /mnt/tierra/PTM-compass/src_old/SHIFTS-4/PeakModeller.py -i "*_Unique_calibrated.feather" -c "${params.params_shifts}"
    // For debugging in UBUNTU (WSL)
    python /home/jmrodriguezc/projects/PTM-compass/src_old/SHIFTS-4/PeakModeller.py -i "*_Unique_calibrated.feather" -c "${params.params_shifts}"
    */
    """
    python /usr/local/shifts_v4/PeakModeller.py -i "${input_file}" -c "${params.params_shifts}"
    """
}
