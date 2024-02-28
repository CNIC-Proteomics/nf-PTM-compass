process RE_FRAG {
    label 'process_high'

    input:
    path raw_files
    path msf_files
    path dm_file

    output:
    path "${input_file.baseName}_REFRAG.tsv", emit: oRefrag
    path "*.log", emit: log

    script:
    """
    source ${REFRAG_HOME}/env/bin/activate && python ${REFRAG_HOME}/ReFrag.py -i "${input_file}" -r "${exp_table}" -d "${dm_file}" -c "${params.params_file}"
    """
}
