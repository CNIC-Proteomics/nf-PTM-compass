process SHIFTS_RECOM_FILTERER {

    label 'process_medium'

    input:
    path input_file

    output:
    path "${input_file.baseName}_RECOMfiltered.feather", emit: ofile
    path "*_log.txt", emit: log

    script:
    """
    source ${SHIFTS_HOME}/env/bin/activate && python ${SHIFTS_HOME}/RECOMfilterer.py -i "${input_file}" -c "${params.params_file}"
    """
}
