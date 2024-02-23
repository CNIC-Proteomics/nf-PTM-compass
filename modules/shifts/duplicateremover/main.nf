process SHIFTS_DUPLICATE_REMOVER {
    // tag '02'
    label 'process_medium'

    input:
    path input_file

    output:
    path "${input_file.baseName}_Unique.feather", emit: ofile
    path "*_log.txt", emit: log

    script:
    """
    source ${SHIFTS_HOME}/env/bin/activate && python ${SHIFTS_HOME}/DuplicateRemover.py -i "${input_file}" -s scan -n num -x xcorr_corr -p sp_score
    """
}
