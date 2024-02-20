process SHIFTS_ADAPTER {

    label 'process_medium'

    input:
    val input_file

    output:
    path("${input_file.baseName}_SHIFTS.feather"), emit: ofile
    path "*_log.txt", emit: log

    script:
    """
    source ${SHIFTS_HOME}/env/bin/active && python ${SHIFTS_HOME}/SHIFTSadapter.py -i "${input_file}"
    mv "${input_file.getParent()}/${input_file.baseName}_SHIFTS.feather" "${input_file.getParent()}/${input_file.baseName}_log.txt" .
    """
}
