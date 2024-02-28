//
// Create channel for input files
//

/*
========================================================================================
    LOCAL FUNCIOTNS
========================================================================================
*/

import org.yaml.snakeyaml.Yaml

// Define a function to check which parameters are missing in the dictionary
def getMissingParams(Map dictionary, List params) {
    def missingParams = []
    // Iterate over each parameter in the list
    for (param in params) {
        // Check if the parameter exists in the dictionary
        if (!dictionary.containsKey(param)) {
            // If parameter is missing, add it to the list of missing parameters
            missingParams.add(param)
        }
    }
    // Stop from the missing parameters
    if (!missingParams.isEmpty()) {
        exit 1, "ERROR: Missing parameters in dictionary: ${missingParams}"
    }
    // Return the list of missing parameters
    return missingParams
}

// def Join two channels based on the file name
def joinChannelsFromFilename(files1, files2) {

    // create a list of tuples with the base name and the file name.
    // This channels is a list of channels (collect()), we have to flatten the list
    def files1 = files1
            // .flatten()
            .map{  file -> tuple(file.baseName, file) }
            // .view()
            // .set { files1 }

    file1.view()

    // create a list of tuples with the base name and the file name.
    // files2
    //             .map { file -> tuple(file.baseName, file) }
    //             .view()
    //             .set { files2 }

    // // join both channels based on the first element (base name)
    // files1
    //             .join(files2)
    //             .map { name, f1, f2 -> [f1, f2] }
    //             .view { "value: $it" }
    //             .set { files3 }

    // return files3
}

/*
========================================================================================
    DEFINED WORKFLOWS
========================================================================================
*/

workflow CREATE_INPUT_CHANNEL_REFRAG {
    take:
    input_files
    params_file

    main:

    // read the file with input parameters
    f = new FileInputStream(new File(input_files))
    // create yaml
    inputs = new Yaml().load(f)

    // stop from the missing parameters
    def requiredParams = ['raw_files','msf_files','dm_file']
    getMissingParams(inputs, requiredParams)

    // create channels from input files
    raw_files = Channel.fromPath("${inputs.raw_files}", checkIfExists: true)
    msf_files = Channel.fromPath("${inputs.msf_files}", checkIfExists: true)
    dm_file = Channel.fromPath("${inputs.dm_file}", checkIfExists: true)

    // create channel for params file
    params_file = Channel.fromPath("${params_file}", checkIfExists: true)

    joined_msf_raw_files = joinChannelsFromFilename(raw_files, msf_files)

    emit:
    ch_raws           = raw_files
    ch_msf_files      = msf_files
    ch_dm_file        = dm_file
    ch_params_file    = params_file
}

workflow CREATE_INPUT_CHANNEL_SHIFTS {
    take:
    input_files
    params_file

    main:

    // read the file with input parameters
    f = new FileInputStream(new File(input_files))
    // create yaml
    inputs = new Yaml().load(f)
    // add the input files into params variable
    //new Yaml().load(inputs).each({ k, v -> params[k] = v })

    // stop from the missing parameters
    def requiredParams = ['re_files','exp_table']
    getMissingParams(inputs, requiredParams)

    // create channels from input files
    re_files = Channel.fromPath("${inputs.re_files}", checkIfExists: true)
    exp_table = Channel.fromPath("${inputs.exp_table}", checkIfExists: true)

    // create channel for params file
    params_file = Channel.fromPath("${params_file}", checkIfExists: true)

    emit:
    ch_re_files     = re_files
    ch_exp_table    = exp_table
    ch_params_file  = params_file
}

workflow CREATE_INPUT_CHANNEL_SOLVER {
    take:
    input_files

    main:

    // read the file with input parameters
    f = new FileInputStream(new File(input_files))
    // create yaml
    inputs = new Yaml().load(f)
    println "INPUTS $inputs"

    // // create channels from input files
    // ch_re_files = Channel.fromPath("$inputs.re_files")
    // ch_exp_table = Channel.fromPath("$inputs.exp_tables")

    // emit:
    // ch_re_files   = ch_re_files
    // ch_exp_table  = ch_exp_table
}