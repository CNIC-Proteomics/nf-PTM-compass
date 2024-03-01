process PEAK_FDRER {
    tag '09'
    label 'process_high'

    input:
    path input_file
    path exp_table
    path params_file

    output:
    path "${input_file.baseName}_FDRfiltered.tsv", emit: oFDRfiltered
    path "${input_file.baseName}_FDR.tsv", emit: oFDR
    path "*_log.txt", emit: log

    script:
    """
    source ${SHIFTS_HOME}/env/bin/activate && python ${SHIFTS_HOME}/PeakFDRer.py -i "${input_file}" -e "${exp_table}" -c "${params_file}"
    """
}
