# nf-PTM-compass

nf-PTM-compass is a [Nextflow](https://www.nextflow.io/) pipeline that enhances the identification and quantification of Post-Translational Modifications (PTMs).

nf-PTM-compass was developed by the Cardiovascular Proteomics Lab/Proteomic Unit at The National Centre for Cardiovascular Research (CNIC, https://www.cnic.es).

This application is licensed under a Creative Commons Attribution-NoDerivatives 4.0 International (CC BY-ND 4.0) License. For further details, read the https://creativecommons.org/licenses/by-nd/4.0/.

# Installation

## Prerequisites
Before you begin, ensure you have met the following requirements:

- You have Linux operating system on your machine. If you have Windows operating system, read the section [Install WSL on Windows](docs/WSL.md)

## Install Nextflow

For more information, read the [How to install Nextflow](docs/Nextflow.md) section.

## Install Singularity

For more information, read the [How to install Singularity](docs/SingularityCE.md) section.

## Download Singularity images

You need to download the Singularity image for the pipeline, ensuring version compatibility with the Nextflow pipeline. See the above *versions* section:
```
singularity pull --arch amd64 library://proteomicscnic/next-launcher/ptm-compass:0.1.0
```

# Version history

| Version | Description                  | Singularity image                                                                        | Tag     | Code                                                        | Version |
|---------|------------------------------|------------------------------------------------------------------------------------------|---------|-------------------------------------------------------------|---------|
| 0.1.0   | First stable version         |                                                                                          |         |                                                             |         |
|         |                              | [ptm-compass](https://cloud.sylabs.io/library/proteomicscnic/next-launcher/ptm-compass)  | 0.1.0   |                                                             |         |
|         |                              |                                                                                          |         | [RefMod](https://github.com/CNIC-Proteomics/ReFrag)         | 0.4.3   |
|         |                              |                                                                                          |         | [SHIFTS](https://github.com/CNIC-Proteomics/SHIFTS)         | 0.4.3   |
|         |                              |                                                                                          |         | [SOLVER](https://github.com/CNIC-Proteomics/Solvers-PTMap)  | 1.0     |
| 0.1.1   | Second stable version        |                                                                                          |         |                                                             |         |



# Usage

## Execute the pipeline using ReCom results as input

Currently, this pipeline begins with SHIFTS.

You can execute this pipeline using either ReCom results or RefMod results.


1. Download test files
```
cd tests && \
wget https://zenodo.org/records/12744716/files/test_ReCom_1.zip?download=1 -O test_Recom_1.zip && \
unzip test_Recom_1.zip -d test_Recom_1
```

2. Execute the pipeline using ReCom results as input:
```
nextflow \
    -log "/tmp/nextflow/log/nf-ptm-compass.log" \
    run main.nf   \
        -profile singularity \
        --recom_files "tests/test_Recom_1/recom_files/*" \
        --exp_table "tests/test_Recom_1/exp_table.txt" \
        --database "tests/test_Recom_1/database.fasta" \
        --decoy_prefix "DECOY_"\
        --params_file "tests/test_Recom_1/params.ini" \
        --sitelist_file "tests/test_Recom_1/sitelist.txt" \
        --groupmaker_file "tests/test_Recom_1/groupmaker.txt" \
        --outdir  "tests/test_Recom_1" \
        -resume
```


<!-- 
2. Execute the pipeline using ReCom results as input:
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
 -->

## Execute the pipeline using ReCom results as input

Under construction...

<!-- 
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
 -->
