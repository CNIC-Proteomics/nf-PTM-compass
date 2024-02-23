process SHIFTS_RECOM_FILTERER {
    tag '07'
    label 'process_medium'

    input:
    path input_file

    output:
    path "${input_file.baseName}_RECOMfiltered.feather", emit: oRecomfiltered
    path "*_log.txt", emit: log

    script:
    """
    source ${SHIFTS_HOME}/env/bin/activate && python ${SHIFTS_HOME}/RECOMfilterer.py -i "${input_file}" -c "${params.params_file}"
    """
}
