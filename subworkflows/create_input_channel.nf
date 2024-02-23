//
// Create channel for input files
//

import org.yaml.snakeyaml.Yaml


workflow CREATE_INPUT_CHANNEL_SHIFTS {
    take:
    input_files

    main:

    // read the file with input parameters
    f = new FileInputStream(new File(input_files))
    // create yaml
    inputs = new Yaml().load(f)
    // add the input files into params variable
    //new Yaml().load(inputs).each({ k, v -> params[k] = v })
    println "INPUTS $inputs"

    // create channels from input files
    ch_re_files = Channel.fromPath("$inputs.re_files")
    ch_exp_table = Channel.fromPath("$inputs.exp_tables")

    emit:
    ch_re_files   = ch_re_files
    ch_exp_table  = ch_exp_table
}

workflow CREATE_INPUT_CHANNEL_SOLVER {
    take:
    input_files

    main:

    // read the file with input parameters
    f = new FileInputStream(new File(input_files))
    // create yaml
    inputs = new Yaml().load(f)
    // add the input files into params variable
    //new Yaml().load(inputs).each({ k, v -> params[k] = v })
    println "INPUTS $inputs"

    // create channels from input files
    ch_re_files = Channel.fromPath("$inputs.re_files")
    ch_exp_table = Channel.fromPath("$inputs.exp_tables")

    emit:
    ch_re_files   = ch_re_files
    ch_exp_table  = ch_exp_table
}