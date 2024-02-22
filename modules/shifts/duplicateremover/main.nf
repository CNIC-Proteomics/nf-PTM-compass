process SHIFTS_DUPLICATE_REMOVER {

    label 'process_medium'

    input:
    path input_file

    output:
    path "${input_file.baseName}_Unique.feather", emit: ofile
    path "*_log.txt", emit: log

    script:
    process_order++
    """
    source ${SHIFTS_HOME}/env/bin/activate && python ${SHIFTS_HOME}/DuplicateRemover.py -i "${input_file}" -s scan -n num -x xcorr_corr -p sp_score
    """
}
