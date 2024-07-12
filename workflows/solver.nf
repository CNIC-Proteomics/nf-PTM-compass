/*
========================================================================================
    VALIDATE INPUTS
========================================================================================
*/

/*
========================================================================================
    CONFIG FILES
========================================================================================
*/


/*
========================================================================================
    IMPORT LOCAL MODULES/SUBWORKFLOWS
========================================================================================
*/

include { DM0SOLVER;
          DM0SOLVER as DM0SOLVER_2
}                               from '../nf-modules/modules/solver/dm0solver/main'
include { PROTEIN_ASSIGNER;
          PROTEIN_ASSIGNER as PROTEIN_ASSIGNER_2;
}                               from '../nf-modules/modules/proteinassigner/main'
include { SCANID_GENERATOR }    from '../nf-modules/modules/scanidgenerator/main'
include { PEAK_ASSIGNATOR }     from '../nf-modules/modules/shifts/peakassignator/main'

include { TRUNK_SOLVER }        from '../nf-modules/modules/solver/trunksolver/main'
include { SITELIST_MAKER }      from '../nf-modules/modules/solver/sitelistmaker/main'
include { SITE_SOLVER }         from '../nf-modules/modules/solver/sitesolver/main'
include { PDMTABLE_MAKER }      from '../nf-modules/modules/solver/pdmtablemaker/main'
include { GROUP_MAKER }         from '../nf-modules/modules/solver/groupmaker/main'
include { JOINER      }         from '../nf-modules/modules/solver/joiner/main'



/*
========================================================================================
    RUN MAIN WORKFLOW
========================================================================================
*/

workflow SOLVER {

    take:
    peakfdrer
    apexlist
    database
    sitelist_file
    groupmaker_file
    params_file

    main:
    //
    // SUBMODULE: DM0 solver
    //
    def params_sections_dm = Channel.value(['DM0Solver_Parameters','DM0Solver_DM0List','Logging','General'])
    DM0SOLVER('01', peakfdrer, apexlist, params_file, params_sections_dm)
    //
    // SUBMODULE: protein assigner
    //
    def params_sections_pa = Channel.value(['ProteinAssigner'])
    PROTEIN_ASSIGNER('02', DM0SOLVER.out.ofile, database, params_file, params_sections_pa)
    //
    // SUBMODULE: Trunk solver
    //
    TRUNK_SOLVER('03', PROTEIN_ASSIGNER.out.ofile, database, params_file)
    //
    // SUBMODULE: protein assigner 2º round
    //
    def params_sections_pa2 = Channel.value(['ProteinAssigner_2_Round'])
    PROTEIN_ASSIGNER_2('04', TRUNK_SOLVER.out.ofile, database, params_file, params_sections_pa2)
    //
    // SUBMODULE: Peak assignator
    //
    def params_sections_pe = Channel.value(['PeakAssignator_in_Solver','Logging','General'])
    PEAK_ASSIGNATOR('05', PROTEIN_ASSIGNER_2.out.ofile, apexlist, params_file, params_sections_pe)
    //
    // SUBMODULE: Site list maker
    //
    SITELIST_MAKER('06', PEAK_ASSIGNATOR.out.oPeakassign, params_file)
    //
    // SUBMODULE: Site solver
    //
    SITE_SOLVER('07', PEAK_ASSIGNATOR.out.oPeakassign, sitelist_file, params_file)
    //
    // SUBMODULE: DM0 solver 2º round
    //
    def params_sections_dm2 = Channel.value(['DM0Solver_Parameters_2_Round','DM0Solver_DM0List','Logging','General'])
    DM0SOLVER_2('08', SITE_SOLVER.out.ofile, apexlist, params_file, params_sections_dm2)
    //
    // SUBMODULE: Scan id generator
    //
    SCANID_GENERATOR('09', DM0SOLVER_2.out.ofile)
    //
    // SUBMODULE: PDMtable maker
    //
    PDMTABLE_MAKER('10', SCANID_GENERATOR.out.ofile, database, params_file)
    //
    // SUBMODULE: Group maker
    //
    GROUP_MAKER('11', PDMTABLE_MAKER.out.ofile, groupmaker_file, params_file)
    //
    // SUBMODULE: Joiner
    //
    JOINER('12', GROUP_MAKER.out.ofile, params_file)


    // return channels
    ch_DM0solver              = DM0SOLVER.out.ofile
    ch_MProtein               = PROTEIN_ASSIGNER.out.ofile
    ch_TrunkSolver            = TRUNK_SOLVER.out.ofile
    ch_PeakAssign             = PEAK_ASSIGNATOR.out.oPeakassign
    ch_SiteFrequency          = SITELIST_MAKER.out.oFrequency
    ch_SiteCleanFrequency     = SITELIST_MAKER.out.oCleanFrequency
    ch_SiteCleanP0Frequency   = SITELIST_MAKER.out.oCleanP0Frequency
    ch_SiteSolver             = SITE_SOLVER.out.ofile
    ch_PDMtable               = PDMTABLE_MAKER.out.ofile
    ch_GroupMaker             = GROUP_MAKER.out.ofile
    ch_GroupJoiner            = JOINER.out.ofile

    emit:
    DM0solver             = ch_DM0solver
    MProtein              = ch_MProtein
    TrunkSolver           = ch_TrunkSolver
    Peakassign            = ch_PeakAssign
    SiteFrequency         = ch_SiteFrequency
    SiteCleanFrequency    = ch_SiteCleanFrequency
    SiteCleanP0Frequency  = ch_SiteCleanP0Frequency
    SiteSolver            = ch_SiteSolver
    PDMtable              = ch_PDMtable
    GroupMaker            = ch_GroupMaker
    GroupJoiner           = ch_GroupJoiner
}

/*
========================================================================================
    THE END
========================================================================================
*/
