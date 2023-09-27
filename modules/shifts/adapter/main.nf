process SHIFTS_ADAPTER {

    label 'process_medium'

    input:
    val input_file

    output:
    path("${input_file.baseName}_SHIFTS.feather"), emit: ofile
    path("${input_file.baseName}_log.txt"), emit: log

    script:
    """
    python /usr/local/shifts_v4/SHIFTSadapter.py -i "${input_file}"
    mv "${input_file.getParent()}/${input_file.baseName}_SHIFTS.feather" "${input_file.getParent()}/${input_file.baseName}_log.txt" .
    """
}
