# PTM-compass
Nextflow pipeline for the PTM-compass workflow


# Usage

Executing using Ubuntu and Singularity (WSL - backend):

Currently, this pipeline begins with SHIFTS.

You can execute this pipeline using either ReCom results or RefMod results.

1. Execute the pipeline using ReCom results as input:
```
cd /home/jmrodriguezc/nf-PTM-compass

nextflow \
    -log "/tmp/nextflow/log/nf-ptm-compass.log" \
    run main.nf   \
        -profile singularity \
        --recom_files "/mnt/tierra/U_Proteomica/UNIDAD/Softwares/jmrodriguezc/nf-PTM-compass/tests/test1/inputs/recom_files/*" \
        --exp_table "/mnt/tierra/U_Proteomica/UNIDAD/Softwares/jmrodriguezc/nf-PTM-compass/tests/test1/inputs/exp_table.txt" \
        --database "/mnt/tierra/U_Proteomica/UNIDAD/Softwares/jmrodriguezc/nf-PTM-compass/tests/test1/inputs/database.fasta" \
        --decoy_prefix "DECOY_"\
        --params_file "/mnt/tierra/U_Proteomica/UNIDAD/Softwares/jmrodriguezc/nf-PTM-compass/tests/test1/inputs/params.ini" \
        --sitelist_file "/mnt/tierra/U_Proteomica/UNIDAD/Softwares/jmrodriguezc/nf-PTM-compass/tests/test1/inputs/sitelist.txt" \
        --groupmaker_file "/mnt/tierra/U_Proteomica/UNIDAD/Softwares/jmrodriguezc/nf-PTM-compass/tests/test1/inputs/groupmaker.txt" \
        --outdir  "/mnt/tierra/U_Proteomica/UNIDAD/Softwares/jmrodriguezc/nf-PTM-compass/tests/test1" \
        -resume
```

2. Execute the pipeline using RefMod results as input:
```
cd /home/jmrodriguezc/nf-PTM-compass

nextflow \
    -log "/tmp/nextflow/log/nf-ptm-compass.log" \
    run main.nf   \
        -profile singularity \
        --refmod_files "/mnt/tierra/U_Proteomica/UNIDAD/Softwares/jmrodriguezc/nf-PTM-compass/tests/test2/inputs/refmod_files/*" \
        --exp_table "/mnt/tierra/U_Proteomica/UNIDAD/Softwares/jmrodriguezc/nf-PTM-compass/tests/test2/inputs/exp_table.txt" \
        --database "/mnt/tierra/U_Proteomica/UNIDAD/Softwares/jmrodriguezc/nf-PTM-compass/tests/test2/inputs/database.fasta" \
        --decoy_prefix "DECOY_"\
        --params_file "/mnt/tierra/U_Proteomica/UNIDAD/Softwares/jmrodriguezc/nf-PTM-compass/tests/test2/inputs/params.ini" \
        --sitelist_file "/mnt/tierra/U_Proteomica/UNIDAD/Softwares/jmrodriguezc/nf-PTM-compass/tests/test2/inputs/sitelist.txt" \
        --groupmaker_file "/mnt/tierra/U_Proteomica/UNIDAD/Softwares/jmrodriguezc/nf-PTM-compass/tests/test2/inputs/groupmaker.txt" \
        --outdir  "/mnt/tierra/U_Proteomica/UNIDAD/Softwares/jmrodriguezc/nf-PTM-compass/tests/test2" \
        -resume
```


You can include the parameters in a 'yaml' file to execute the above tasks:
```
nextflow \
    -log "/tmp/nextflow/log/nf-ptm-compass.log" \
    run main.nf   \
        -profile singularity \
        -params-file "/mnt/tierra/U_Proteomica/UNIDAD/Softwares/jmrodriguezc/nf-PTM-compass/tests/test1/inputs/inputs.yml" \
        --params_file "/mnt/tierra/U_Proteomica/UNIDAD/Softwares/jmrodriguezc/nf-PTM-compass/tests/test1/inputs/params.ini" \
        -resume
```


# Installation

## Prerequisites

Under construction...

- Linux Operating system... In the case to use Windows, install WSL (Linux)

- Install Nextflow

- Install Singularity


