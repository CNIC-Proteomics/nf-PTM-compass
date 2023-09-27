//
// Create channel for input file
//

workflow CREATE_INPUT_CHANNEL {
    take:
    input_files

    main:
    input_files = Channel.fromPath("$params.input_files")

    emit:
    input_file         = input_files
}
