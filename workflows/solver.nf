/*
========================================================================================
    IMPORT MODULES
========================================================================================
*/

include { createParamStrChannel } from '../nf-modules/lib/Utils'


/*
========================================================================================
    IMPORT LOCAL MODULES/SUBWORKFLOWS
========================================================================================
*/

include { PROTEIN_ASSIGNER;
          PROTEIN_ASSIGNER as PROTEIN_ASSIGNER_2;
}                                       from '../nf-modules/modules/proteinassigner/main'
include { SCANID_GENERATOR }            from '../nf-modules/modules/scanidgenerator/main'
include { EXPERIMENT_SEPARATOR }        from '../nf-modules/modules/expseparator/main'

include { PEAK_ASSIGNATOR }             from '../nf-modules/modules/shifts/peakassignator/main'

include { DM0SOLVER }                   from '../nf-modules/modules/solver/dm0solver/main'
include { TRUNK_SOLVER }                from '../nf-modules/modules/solver/trunksolver/main'
include { BINOMIAL_SITELIST_MAKER }     from '../nf-modules/modules/solver/binomialsitelistmaker/main'
include { SITE_SOLVER }                 from '../nf-modules/modules/solver/sitesolver/main'
include { PGMTABLE_MAKER }              from '../nf-modules/modules/solver/pdmtablemaker/main'
include { GROUP_MAKER }                 from '../nf-modules/modules/solver/groupmaker/main'
include { JOINER }                      from '../nf-modules/modules/solver/joiner/main'
include { FREQ_PROCESSOR }              from '../nf-modules/modules/solver/freqprocessor/main'


/*
========================================================================================
    RUN MAIN WORKFLOW
========================================================================================
*/

workflow SOLVER {

    take:
    peakfdrer
    apexlist
    exp_table
    database
    sitelist_file
    groupmaker_file
    params_file

    main:
    //
    // SUBMODULE: DM0 solver
    //
    DM0SOLVER('09', peakfdrer, apexlist, createParamStrChannel(params_file, ['DM0Solver_Parameters','DM0Solver_DM0List','Logging','General']))
    //
    // SUBMODULE: protein assigner
    //
    PROTEIN_ASSIGNER('10', DM0SOLVER.out.ofile, database, createParamStrChannel(params_file, ['ProteinAssigner','Logging','General']))
    //
    // SUBMODULE: Trunk solver
    //
    TRUNK_SOLVER('11', PROTEIN_ASSIGNER.out.ofile, database, createParamStrChannel(params_file, ['TrunkSolver_Parameters','TrunkSolver_CombList','Aminoacids','Fixed Modifications','Masses','Logging','General']))
    //
    // SUBMODULE: protein assigner 2º round
    //
    PROTEIN_ASSIGNER_2('12', TRUNK_SOLVER.out.ofile, database, createParamStrChannel(params_file, ['ProteinAssigner_2_Round','Logging','General'], [['\\[ProteinAssigner_2_Round\\]', '[ProteinAssigner]']]))
    //
    // SUBMODULE: Peak assignator
    //
    PEAK_ASSIGNATOR('13', PROTEIN_ASSIGNER_2.out.ofile, apexlist, createParamStrChannel(params_file, ['PeakAssignator_in_Solver','Logging','General'], [['\\[PeakAssignator_in_Solver\\]', '[PeakAssignator]']]))
    //
    // SUBMODULE: Bionomial Site list maker
    //
    BINOMIAL_SITELIST_MAKER('14', PEAK_ASSIGNATOR.out.oPeakassign, createParamStrChannel(params_file, ['BinomialSiteListMaker_Parameters','Logging','General']))
    //
    // SUBMODULE: Site solver
    //
    SITE_SOLVER('15', PEAK_ASSIGNATOR.out.oPeakassign, sitelist_file, createParamStrChannel(params_file, ['SiteSolver_Parameters','Logging','General']))
    //
    // SUBMODULE: Experiment separator
    //
    EXPERIMENT_SEPARATOR('16', SITE_SOLVER.out.ofile, exp_table)
    //
    // SUBMODULE: PGMtable maker
    //
    PGMTABLE_MAKER('17', EXPERIMENT_SEPARATOR.out.ofile.flatten(), database, createParamStrChannel(params_file, ['PDMTableMaker_Parameters','PDMTableMaker_Conditions','Logging','General']))    
    //
    // SUBMODULE: Group maker
    //
    GROUP_MAKER('18', PGMTABLE_MAKER.out.ofile, groupmaker_file, createParamStrChannel(params_file, ['GroupMaker_Parameters','Logging','General']))
    //
    // SUBMODULE: Joiner
    //
    JOINER('19', GROUP_MAKER.out.ofile, createParamStrChannel(params_file, ['Joiner_Parameters','Joiner_Columns','Logging','General']))
    //
    // SUBMODULE: Get the frequencies
    //
    FREQ_PROCESSOR('20', JOINER.out.ofile)


    // return channels
    DM0solver              = DM0SOLVER.out.ofile
    MProtein               = PROTEIN_ASSIGNER.out.ofile
    TrunkSolver            = TRUNK_SOLVER.out.ofile
    PeakAssign             = PEAK_ASSIGNATOR.out.oPeakassign
    SiteList               = BINOMIAL_SITELIST_MAKER.out.ofile
    SiteSolver             = SITE_SOLVER.out.ofile
    SiteSolverExp          = EXPERIMENT_SEPARATOR.out.ofile
    PGMtable               = PGMTABLE_MAKER.out.ofile
    GroupMaker             = GROUP_MAKER.out.ofile
    GroupJoiner            = JOINER.out.ofile
    PDMFrequency           = FREQ_PROCESSOR.out.ofilePdm
    PGMFrequency           = FREQ_PROCESSOR.out.ofilePgm


    emit:
    DM0solver
    MProtein
    TrunkSolver
    PeakAssign
    SiteList
    SiteSolver
    SiteSolverExp
    PGMtable
    GroupMaker
    GroupJoiner
    PDMFrequency
    PGMFrequency
}

/*
========================================================================================
    THE END
========================================================================================
*/
