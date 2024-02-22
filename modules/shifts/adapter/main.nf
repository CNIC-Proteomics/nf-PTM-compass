// Import the variables from variables.nf
include { process_order } from 'variables.nf'

process SHIFTS_ADAPTER {

    label 'process_medium'

    input:
    val input_file

    output:
    path("${input_file.baseName}_SHIFTS.feather"), emit: ofile
    path "*_log.txt", emit: log

    script:
    process_order++
    """
    source ${SHIFTS_HOME}/env/bin/activate && python ${SHIFTS_HOME}/SHIFTSadapter.py -i "${input_file}"
    mv "${input_file.getParent()}/${input_file.baseName}_SHIFTS.feather" "${input_file.getParent()}/${input_file.baseName}_log.txt" .
    """
}
