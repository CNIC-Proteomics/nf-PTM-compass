process SHIFTS_DUPLICATE_REMOVER {

    label 'process_medium'

    input:
    path input_file

    output:
    path "${input_file.baseName}_Unique.feather", emit: ofile

    script:
    """
    python /usr/local/shifts_v4/DuplicateRemover.py -i "${input_file}" -s scan -n num -x xcorr_corr -p sp_score
    """
}
