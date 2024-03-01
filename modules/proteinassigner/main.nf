process PROTEIN_ASSIGNER {
    tag '02'
    label 'process_medium'

    input:
    path input_file
    path database
    path params_file

    output:
    path("${input_file.baseName}_PA.tsv", emit: ofile)
    path "*_log.txt", emit: log

    script:
    // define files
    def output_file ="${input_file.baseName}_PA.tsv"

    """    
    source ${PROTEIN_ASSIGNER_HOME}/env/bin/activate && python ${PROTEIN_ASSIGNER_HOME}/ProteinAssigner_v5.py -i "${input_file}" -f "${database}" -o "${output_file}" -c "${params_file}"
    """
}
