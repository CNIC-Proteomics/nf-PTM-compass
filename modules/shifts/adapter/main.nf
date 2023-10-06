process SHIFTS_ADAPTER {

    label 'process_medium'

    input:
    val input_file

    output:
    path("${input_file.baseName}_SHIFTS.feather"), emit: ofile
    // path("${input_file.baseName}_log.txt"), emit: log

    script:
    /*
    // FOR PRODUCTION
    python /usr/local/shifts_v4/SHIFTSadapter.py -i "${input_file}"
    // For debugging in DOCKER
    python /mnt/tierra/PTM-compass/src_old/SHIFTS-4/SHIFTSadapter.py -i "${input_file}"
    // For debugging in UBUNTU (WSL)
    python /home/jmrodriguezc/projects/PTM-compass/src_old/SHIFTS-4/SHIFTSadapter.py -i "${input_file}"
    */
    """
    python /usr/local/shifts_v4/SHIFTSadapter.py -i "${input_file}"
    mv "${input_file.getParent()}/${input_file.baseName}_SHIFTS.feather" "${input_file.getParent()}/${input_file.baseName}_log.txt" .
    """
}
