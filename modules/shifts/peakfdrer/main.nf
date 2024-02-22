process SHIFTS_PEAK_FDRER {

    label 'process_medium'

    input:
    path input_file

    output:
    path "${input_file.baseName}_FDRfiltered.tsv", emit: oFDRfiltered
    path "${input_file.baseName}_FDR.tsv", emit: oFDR
    path "*_log.txt", emit: log

    script:
    """
    source ${SHIFTS_HOME}/env/bin/activate && python ${SHIFTS_HOME}/PeakFDRer.py -i "${input_file}" -e "${params.params_exp}" -c "${params.params_file}"
    """
}
