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

// Join two channels based on the file name
def joinChannelsFromFilename(ifiles1, ifiles2) {

    // create a list of tuples with the base name and the file name.
    def files1 = ifiles1
                    // .flatten()
                    .map{  file -> tuple(file.baseName, file) }
                    // .view()
                    // .set { files1 }

    // create a list of tuples with the base name and the file name.
    def files2 = ifiles2
                    .map { file -> tuple(file.baseName, file) }
                    // .view()
                    // .set { files2 }

    // join both channels based on the first element (base name)
    def files3 = files1
                    .join(files2)
                    .map { name, f1, f2 -> [f1, f2] }
                    // .view { "value: $it" }
                    // .set { files3 }

    return files3
}

/*
========================================================================================
    DEFINED WORKFLOWS
========================================================================================
*/

workflow CREATE_INPUT_CHANNEL_PTMCOMPASS {
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
    def requiredParams = ['re_files','exp_table','database']
    getMissingParams(inputs, requiredParams)

    // create channels from input files
    re_files = Channel.fromPath("${inputs.re_files}", checkIfExists: true)
    exp_table = Channel.fromPath("${inputs.exp_table}", checkIfExists: true)
    database = Channel.fromPath("${inputs.database}", checkIfExists: true)

    // create channel for params file
    file = new File("${params_file}")
    if ( file.exists() ) {
        // def re_params_file = Channel.value("${params_file}")

        // update the database file and decoy_prefix in the parameter file
        def params_data = Utils.updateIniParams("${params_file}", ['decoy_prefix': ${params.decoy_label}] )
        println "PARAMS_DATA: ${params_data}"
        // create param string
        def params_str = ""
        params_data.each { key, value -> params_str += "$key = $value\n" }
        // print the params data
        def re_params_file = new File("TEST.params")

    } else { exit 1, "ERROR: The 'parameter' file does not exist" }




    emit:
    ch_re_files     = re_files
    ch_exp_table    = exp_table
    ch_database     = database
    ch_params_file  = re_params_file
}

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
    // join two channels based on the file name
    msf_raw_files = joinChannelsFromFilename(raw_files, msf_files)

    // these files will be used multiple times; So, we have to create a Value Channel and then, check if file exists
    File file = new File("${inputs.dm_file}")
    if ( file.exists() ) {
        dm_file = Channel.value("${inputs.dm_file}")
    } else { exit 1, "ERROR: The 'dm_file' file does not exist" }

    // create channel for params file
    file = new File("${params_file}")
    if ( file.exists() ) {
        params_file = Channel.value("${params_file}")
    } else { exit 1, "ERROR: The 'parameter' file does not exist" }

    emit:
    ch_msf_raw_files  = msf_raw_files
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
    file = new File("${params_file}")
    if ( file.exists() ) {
        params_file = Channel.value("${params_file}")
    } else { exit 1, "ERROR: The 'parameter' file does not exist" }

    emit:
    ch_re_files     = re_files
    ch_exp_table    = exp_table
    ch_params_file  = params_file
}

workflow CREATE_INPUT_CHANNEL_SOLVER {
    take:
    input_files
    params_file

    main:

    // read the file with input parameters
    f = new FileInputStream(new File(input_files))
    // create yaml
    inputs = new Yaml().load(f)
    println "INPUTS $inputs"

    // create channel for params file
    file = new File("${params_file}")
    if ( file.exists() ) {
        params_file = Channel.value("${params_file}")
    } else { exit 1, "ERROR: The 'parameter' file does not exist" }

    emit:
    ch_re_files     = re_files
    ch_exp_table    = exp_table
    ch_params_file  = params_file
}