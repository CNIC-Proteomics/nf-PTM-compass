/*
========================================================================================
    IMPORT LOCAL MODULES/SUBWORKFLOWS
========================================================================================
*/

include { REFMOD } from './refmod'
include { SHIFTS } from './shifts'
include { SOLVER } from './solver'


//
// SUBWORKFLOW: Create input channels
//
include {
    CREATE_INPUT_CHANNEL_PTMCOMPASS;
    CREATE_INPUT_CHANNEL_PTMCOMPASS_REFMOD;
    CREATE_INPUT_CHANNEL_PTMCOMPASS_RECOM
} from '../nf-modules/subworkflows/ptm_compass'
include { CREATE_INPUT_CHANNEL_REFMOD } from '../nf-modules/subworkflows/refmod'
include { CREATE_INPUT_CHANNEL_SHIFTS } from '../nf-modules/subworkflows/shifts'
include { CREATE_INPUT_CHANNEL_SOLVER } from '../nf-modules/subworkflows/solver'


/*
========================================================================================
    DEFINED WORKFLOWS
========================================================================================
*/

//
// WORKFLOW: Run main analysis pipeline using the MSFragger adaptor
//

workflow PTM_COMPASS_WORKFLOW {
    //
    // SUBWORKFLOW: Create input channels
    //
    CREATE_INPUT_CHANNEL_PTMCOMPASS()
    //
    // WORKFLOW: Run SHIFTS analysis pipeline
    //
    SHIFTS(
        CREATE_INPUT_CHANNEL_PTMCOMPASS.out.ch_msf_files,
        CREATE_INPUT_CHANNEL_PTMCOMPASS.out.ch_exp_table,
        CREATE_INPUT_CHANNEL_PTMCOMPASS.out.ch_peak_file,
        CREATE_INPUT_CHANNEL_PTMCOMPASS.out.ch_params_file
    )
    //
    // WORKFLOW: Run SOLVER analysis pipeline
    //
    SOLVER(
        SHIFTS.out.FDRfiltered,
        SHIFTS.out.Apexlist,
        CREATE_INPUT_CHANNEL_PTMCOMPASS.out.ch_database,
        CREATE_INPUT_CHANNEL_PTMCOMPASS.out.ch_sitelist_file,
        CREATE_INPUT_CHANNEL_PTMCOMPASS.out.ch_groupmaker_file,
        CREATE_INPUT_CHANNEL_PTMCOMPASS.out.ch_params_file
    )
}

//
// WORKFLOW: Run main analysis pipeline using RefMod
//

workflow PTM_COMPASS_WORKFLOW_REFMOD {
    //
    // SUBWORKFLOW: Create input channels
    //
    CREATE_INPUT_CHANNEL_PTMCOMPASS_REFMOD()
    //
    // WORKFLOW: RefMod analysis
    //
    REFMOD(
        CREATE_INPUT_CHANNEL_PTMCOMPASS_REFMOD.out.ch_msf_raw_files,
        CREATE_INPUT_CHANNEL_PTMCOMPASS_REFMOD.out.ch_dm_file,
        CREATE_INPUT_CHANNEL_PTMCOMPASS_REFMOD.out.ch_params_file
    )
    //
    // WORKFLOW: Run SHIFTS analysis pipeline
    //
    SHIFTS(
        REFMOD.out.ofile,  // REFMOD.out.ofile.collect(),
        CREATE_INPUT_CHANNEL_PTMCOMPASS_REFMOD.out.ch_exp_table,
        CREATE_INPUT_CHANNEL_PTMCOMPASS_REFMOD.out.ch_peak_file,
        CREATE_INPUT_CHANNEL_PTMCOMPASS_REFMOD.out.ch_params_file
    )
    //
    // WORKFLOW: Run SOLVER analysis pipeline
    //
    SOLVER(
        SHIFTS.out.FDRfiltered,
        SHIFTS.out.Apexlist,
        CREATE_INPUT_CHANNEL_PTMCOMPASS_REFMOD.out.ch_database,
        CREATE_INPUT_CHANNEL_PTMCOMPASS_REFMOD.out.ch_sitelist_file,
        CREATE_INPUT_CHANNEL_PTMCOMPASS_REFMOD.out.ch_groupmaker_file,
        CREATE_INPUT_CHANNEL_PTMCOMPASS_REFMOD.out.ch_params_file
    )
}

//
// WORKFLOW: Run main analysis pipeline using ReCom
//

workflow PTM_COMPASS_WORKFLOW_RECOM {
    //
    // SUBWORKFLOW: Create input channel
    //
    CREATE_INPUT_CHANNEL_PTMCOMPASS_RECOM()
    //
    // WORKFLOW: Run SHIFTS analysis pipeline
    //
    SHIFTS_RECOM(
        CREATE_INPUT_CHANNEL_PTMCOMPASS_RECOM.out.ch_re_files,
        CREATE_INPUT_CHANNEL_PTMCOMPASS_RECOM.out.ch_exp_table,
        CREATE_INPUT_CHANNEL_PTMCOMPASS_RECOM.out.ch_peak_file,
        CREATE_INPUT_CHANNEL_PTMCOMPASS_RECOM.out.ch_params_file
    )
    //
    // WORKFLOW: Run SOLVER analysis pipeline
    //
    SOLVER(
        SHIFTS_RECOM.out.FDRfiltered,
        SHIFTS_RECOM.out.Apexlist,
        CREATE_INPUT_CHANNEL_PTMCOMPASS_RECOM.out.ch_database,
        CREATE_INPUT_CHANNEL_PTMCOMPASS_RECOM.out.ch_sitelist_file,
        CREATE_INPUT_CHANNEL_PTMCOMPASS_RECOM.out.ch_groupmaker_file,
        CREATE_INPUT_CHANNEL_PTMCOMPASS_RECOM.out.ch_params_file
    )
}

workflow REFMOD_WORKFLOW {
    //
    // SUBWORKFLOW: Create input channels
    //
    CREATE_INPUT_CHANNEL_REFMOD ()
    //
    // WORKFLOW: RefMod analysis
    //
    REFMOD(
        CREATE_INPUT_CHANNEL_REFMOD.out.ch_msf_raw_files,
        CREATE_INPUT_CHANNEL_REFMOD.out.ch_dm_file,
        CREATE_INPUT_CHANNEL_REFMOD.out.ch_params_file
    )
}

workflow SHIFTS_WORKFLOW {
    //
    // SUBWORKFLOW: Create input channel
    //
    CREATE_INPUT_CHANNEL_SHIFTS()
    //
    // WORKFLOW: Run SHIFTS analysis pipeline
    //
    SHIFTS(
        CREATE_INPUT_CHANNEL_SHIFTS.out.ch_re_files,
        CREATE_INPUT_CHANNEL_SHIFTS.out.ch_exp_table,
        CREATE_INPUT_CHANNEL_SHIFTS.out.ch_peak_file,
        CREATE_INPUT_CHANNEL_SHIFTS.out.ch_params_file
    )
}

workflow SOLVER_WORKFLOW {
    //
    // SUBWORKFLOW: Create input channel
    //
    CREATE_INPUT_CHANNEL_SOLVER()
    //
    // WORKFLOW: Run SOLVER analysis pipeline
    //
    SOLVER(
        CREATE_INPUT_CHANNEL_SOLVER.out.ch_peakfdr_file,
        CREATE_INPUT_CHANNEL_SOLVER.out.ch_apexlist_file,
        CREATE_INPUT_CHANNEL_SOLVER.out.ch_database,
        CREATE_INPUT_CHANNEL_SOLVER.out.ch_sitelist_file,
        CREATE_INPUT_CHANNEL_SOLVER.out.ch_groupmaker_file,
        CREATE_INPUT_CHANNEL_SOLVER.out.ch_params_file
    )
}


/*
========================================================================================
    THE END
========================================================================================
*/
