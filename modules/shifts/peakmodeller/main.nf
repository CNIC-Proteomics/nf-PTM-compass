process SHIFTS_PEAK_MODELLER {

    label 'process_medium'

    input:
    path input_file

    output:
    path "PeakModeller_DMTable.feather"

    script:
    """
    python /usr/local/shifts_v4/PeakModeller.py -i "${input_file}" -c "${params.params_shifts}"
    """
}


// start script: S:\U_Proteomica\LABS\LAB_FSM\Centrosome_PTMs\RECOM-proteomes\CentrosomasLinfosThumanos_Recom_IJ\Shifts_modules\PeakModeller.py 
// -i S:\U_Proteomica\LABS\LAB_FSM\Centrosome_PTMs\RECOM-proteomes\CentrosomasLinfosThumanos_Recom_IJ\03_DMCalibrator\*_calibrated.feather 
// -c S:\U_Proteomica\LABS\LAB_FSM\Centrosome_PTMs\RECOM-proteomes\CentrosomasLinfosThumanos_Recom_IJ\Shifts_modules\config\SHIFTS.ini

