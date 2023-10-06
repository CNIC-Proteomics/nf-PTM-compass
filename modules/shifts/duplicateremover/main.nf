process SHIFTS_DUPLICATE_REMOVER {

    label 'process_medium'

    input:
    path input_file

    output:
    path "${input_file.baseName}_Unique.feather", emit: ofile

    script:
    /*
    // FOR PRODUCTION
    python /usr/local/shifts_v4/DuplicateRemover.py -i "${input_file}" -s scan -n num -x xcorr_corr -p sp_score
    // For debugging in DOCKER
    python /mnt/tierra/PTM-compass/src_old/SHIFTS-4/DuplicateRemover.py -i "${input_file}" -s scan -n num -x xcorr_corr -p sp_score
    // For debugging in UBUNTU (WSL)
    python /home/jmrodriguezc/projects/PTM-compass/src_old/SHIFTS-4/DuplicateRemover.py -i "${input_file}" -s scan -n num -x xcorr_corr -p sp_score
    */
    """
    python /usr/local/shifts_v4/DuplicateRemover.py -i "${input_file}" -s scan -n num -x xcorr_corr -p sp_score
    """
}
