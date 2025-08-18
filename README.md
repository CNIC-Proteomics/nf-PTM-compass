# nf-PTM-compass

nf-PTM-compass is a [Nextflow](https://www.nextflow.io/) pipeline that enhances the identification and quantification of Post-Translational Modifications (PTMs).

<!-- ![Workflow schema](docs/images/pipeline.png) -->

nf-PTM-compass was developed by the Cardiovascular Proteomics Lab/Proteomic Unit at The National Centre for Cardiovascular Research (CNIC, https://www.cnic.es).

This application is licensed under a Creative Commons Attribution-NoDerivatives 4.0 International (CC BY-ND 4.0) License. For further details, read the https://creativecommons.org/licenses/by-nd/4.0/.


# Installation

## Prerequisites

Before you begin, ensure you have met the following requirements:

- A **Linux operating system** is needed on your machine.

## Linux operating system on Windows

If you are using a Windows operating system, refer to the section [Install WSL on Windows](docs/WSL.md) to set up a Linux operating system on your Windows machine.

## Install Singularity

For more information, read the [How to install Singularity](docs/SingularityCE.md) section.

## Install Nextflow

For more information, read the [How to install Nextflow](docs/Nextflow.md) section.

## Install Git

For more information, read the [How to install Git](docs/Git.md) section.


# Download the pipeline (latest release)

You can download the pipeline by specifying a release version:
```
export PIPELINE_VERSION=0.1.7
```
To see the full list of available versions, visit the [releases page](https://github.com/CNIC-Proteomics/nf-PTM-compass/releases).

Clone the specified release directly using Git:
```
git clone https://github.com/CNIC-Proteomics/nf-PTM-compass.git --branch ${PIPELINE_VERSION} --recursive
```
With the *--recursive* parameter, the submodules repositories are cloned as well.


# Download Singularity images

Export an environment variable to define the version of singularity image:
```
export IMAGE_VERSION=0.1.5
```
Note: The list of releases is located on the [singularity repository page](https://cloud.sylabs.io/library/proteomicscnic/next-launcher/ptm-compass).

Navigate to the backends folder:
```
cd nf-PTM-compass/backends
```

You need to download the Singularity image for the pipeline, ensuring version compatibility with the Nextflow pipeline. See the above *versions* section:
```
singularity pull --arch amd64 library://proteomicscnic/next-launcher/ptm-compass:${IMAGE_VERSION}
```

You might see warning messages like the following. You can discard or ignore them:

    WARNING: failed to get key material: 404 Not Found: entity not found
    WARNING: integrity: signature object 5 not valid: openpgp: signature made by unknown entity
    WARNING: Skipping container verification

Create a symbolic link
```
ln -s ptm-compass_${IMAGE_VERSION}.sif ptm-compass.sif
```


# Usage

## Execute the pipeline with samples

The input files provided are open search results for mouse heteroplasmy (`heart tissue`) at the following URL:

https://zenodo.org/records/15182537/files/heteroplasmic_heart.zip?download=1

These files are intended for use with nf-PTM-compass and are derived from the study by Bagwan N., Bonzon-Kulichenko E., Calvo E., et al. [1]. The results were generated using the `nf-SearchEngine` pipeline (MSFragger [2]).

1. Download sample files:
```
cd samples && \
wget https://zenodo.org/records/15182537/files/heteroplasmic_heart.zip?download=1 -O heteroplasmic_heart.zip && \
unzip heteroplasmic_heart.zip && \
cd ..
```

2. Execute the pipeline using MSFragger results as input:
```
nextflow \
    -log "/tmp/nextflow/log/nf-ptm-compass.log" \
    run main.nf   \
        -profile singularity \
        --msf_files "samples/heteroplasmic_heart/inputs/msfragger/*.tsv" \
        --exp_table "samples/heteroplasmic_heart/inputs/experimental_table.tsv" \
        --database "samples/heteroplasmic_heart/inputs/database.fasta" \
        --decoy_prefix "DECOY_"\
        --params_file "samples/heteroplasmic_heart/inputs/params.ini" \
        --sitelist_file "samples/heteroplasmic_heart/inputs/site_solver_list.txt" \
        --groupmaker_file "samples/heteroplasmic_heart/inputs/group_maker_list.txt" \
        --outdir  "samples/heteroplasmic_heart/results" \
        -resume
```
<!--
2. Execute the pipeline IN LOCAL using MSFragger results as input:
```
nextflow \
    -log "/tmp/nextflow/log/nf-ptm-compass.log" \
    run main.nf   \
        --msf_files "/mnt/tierra/U_Proteomica/UNIDAD/Softwares/jmrodriguezc/nf-PTM-compass/samples/heteroplasmic_heart/inputs/msfragger/*.tsv" \
        --exp_table "/mnt/tierra/U_Proteomica/UNIDAD/Softwares/jmrodriguezc/nf-PTM-compass/samples/heteroplasmic_heart/inputs/experimental_table.tsv" \
        --database "/mnt/tierra/U_Proteomica/UNIDAD/Softwares/jmrodriguezc/nf-PTM-compass/samples/heteroplasmic_heart/inputs/database.fasta" \
        --decoy_prefix "DECOY_"\
        --params_file "/mnt/tierra/U_Proteomica/UNIDAD/Softwares/jmrodriguezc/nf-PTM-compass/samples/heteroplasmic_heart/inputs/params.ini" \
        --sitelist_file "/mnt/tierra/U_Proteomica/UNIDAD/Softwares/jmrodriguezc/nf-PTM-compass/samples/heteroplasmic_heart/inputs/site_solver_list.txt" \
        --groupmaker_file "/mnt/tierra/U_Proteomica/UNIDAD/Softwares/jmrodriguezc/nf-PTM-compass/samples/heteroplasmic_heart/inputs/group_maker_list.txt" \
        --outdir  "/mnt/tierra/U_Proteomica/UNIDAD/Softwares/jmrodriguezc/nf-PTM-compass/samples/heteroplasmic_heart/results" \
        -resume
```
-->

## Download more samples

+ You can download the input files for this `liver` sample from the study by Bagwan N, Bonzon-Kulichenko E, Calvo E, et al. [1] at the following URL:

https://zenodo.org/records/15182445/files/heteroplasmic_liver.zip?download=1

To execute the pipeline, follow the same steps as in Sample 1.

<!--
2. Execute the pipeline IN LOCAL using MSFragger results as input:
```
nextflow \
    -log "/tmp/nextflow/log/nf-ptm-compass.log" \
    run main.nf   \
        --msf_files "/mnt/tierra/U_Proteomica/UNIDAD/Softwares/jmrodriguezc/nf-PTM-compass/samples/heteroplasmic_liver/inputs/msfragger/*.tsv" \
        --exp_table "/mnt/tierra/U_Proteomica/UNIDAD/Softwares/jmrodriguezc/nf-PTM-compass/samples/heteroplasmic_liver/inputs/experimental_table.tsv" \
        --database "/mnt/tierra/U_Proteomica/UNIDAD/Softwares/jmrodriguezc/nf-PTM-compass/samples/heteroplasmic_liver/inputs/database.fasta" \
        --decoy_prefix "DECOY_"\
        --params_file "/mnt/tierra/U_Proteomica/UNIDAD/Softwares/jmrodriguezc/nf-PTM-compass/samples/heteroplasmic_liver/inputs/params.ini" \
        --sitelist_file "/mnt/tierra/U_Proteomica/UNIDAD/Softwares/jmrodriguezc/nf-PTM-compass/samples/heteroplasmic_liver/inputs/site_solver_list.txt" \
        --groupmaker_file "/mnt/tierra/U_Proteomica/UNIDAD/Softwares/jmrodriguezc/nf-PTM-compass/samples/heteroplasmic_liver/inputs/group_maker_list.txt" \
        --outdir  "/mnt/tierra/U_Proteomica/UNIDAD/Softwares/jmrodriguezc/nf-PTM-compass/samples/heteroplasmic_liver/results" \
        -resume
```
-->


+ You can download the input files for this `muscle` sample from the study by Bagwan N, Bonzon-Kulichenko E, Calvo E, et al. [1] at the following URL:

https://zenodo.org/records/15182445/files/heteroplasmic_muscle.zip?download=1

To execute the pipeline, follow the same steps as in Sample 1.


<!--
2. Execute the pipeline IN LOCAL using MSFragger results as input:
```
nextflow \
    -log "/tmp/nextflow/log/nf-ptm-compass.log" \
    run main.nf   \
        --msf_files "/mnt/tierra/U_Proteomica/UNIDAD/Softwares/jmrodriguezc/nf-PTM-compass/samples/heteroplasmic_muscle/inputs/msfragger/*.tsv" \
        --exp_table "/mnt/tierra/U_Proteomica/UNIDAD/Softwares/jmrodriguezc/nf-PTM-compass/samples/heteroplasmic_muscle/inputs/experimental_table.tsv" \
        --database "/mnt/tierra/U_Proteomica/UNIDAD/Softwares/jmrodriguezc/nf-PTM-compass/samples/heteroplasmic_muscle/inputs/database.fasta" \
        --decoy_prefix "DECOY_"\
        --params_file "/mnt/tierra/U_Proteomica/UNIDAD/Softwares/jmrodriguezc/nf-PTM-compass/samples/heteroplasmic_muscle/inputs/params.ini" \
        --sitelist_file "/mnt/tierra/U_Proteomica/UNIDAD/Softwares/jmrodriguezc/nf-PTM-compass/samples/heteroplasmic_muscle/inputs/site_solver_list.txt" \
        --groupmaker_file "/mnt/tierra/U_Proteomica/UNIDAD/Softwares/jmrodriguezc/nf-PTM-compass/samples/heteroplasmic_muscle/inputs/group_maker_list.txt" \
        --outdir  "/mnt/tierra/U_Proteomica/UNIDAD/Softwares/jmrodriguezc/nf-PTM-compass/samples/heteroplasmic_muscle/results" \
        -resume
```
-->


## References

[1] Bagwan N, Bonzon-Kulichenko E, Calvo E, et al. Comprehensive Quantification of the Modified Proteome Reveals Oxidative Heart Damage in Mitochondrial Heteroplasmy. Cell Reports. 2018;23(12):3685-3697.e4. https://doi.org/10.1016/j.celrep.2018.05.080

[2] Kong, A., Leprevost, F., Avtonomov, D. et al. MSFragger: ultrafast and comprehensive peptide identification in mass spectrometry–based proteomics. Nat Methods 14, 513–520 (2017). https://doi.org/10.1038/nmeth.4256

# Image Version History

For more information about the program version included within the Singularity version, refer to the [changelog](changelog.md) for the current version.
