process SHIFTS_PEAK_MODELLER {

    label 'process_medium'

    input:
    path input_file

    output:
    path "PeakModeller_DMTable.feather"

    script:
    """
    python /usr/local/shifts_v4/PeakModeller.py -i "${input_file}" -c "${params.params_shifts}"
    """
}
