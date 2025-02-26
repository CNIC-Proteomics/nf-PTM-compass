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


# Download the pipeline with the latest release

Export an environment variable to define the version:
```
export PIPELINE_VERSION=0.1.5
```
Note: The list of releases is located on the [releases page](https://github.com/CNIC-Proteomics/nf-PTM-compass/releases).

You can clone the latest release directly using git with the following command:
```
git clone https://github.com/CNIC-Proteomics/nf-PTM-compass.git --branch ${PIPELINE_VERSION} --recursive
```
With the *--recursive* parameter, the submodules repositories are cloned as well.


# Download Singularity images

Export an environment variable to define the version of singularity image:
```
export IMAGE_VERSION=0.1.4
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


1. Download sample files
```
cd samples && \
wget https://zenodo.org/records/14446572/files/nf-PTM-compass_Heteroplasmic_Muscle.zip?download=1 -O nf-PTM-compass_Heteroplasmic_Muscle.zip && \
unzip nf-PTM-compass_Heteroplasmic_Muscle.zip && \
cd ..
```

2. Execute the pipeline using MSFragger results as input:
```
nextflow \
    -log "/tmp/nextflow/log/nf-ptm-compass.log" \
    run main.nf   \
        -profile singularity \
        --msf_files "samples/heteroplasmic_muscle/inputs/msfragger/*.tsv" \
        --exp_table "samples/heteroplasmic_muscle/inputs/experimental_table.tsv" \
        --database "samples/heteroplasmic_muscle/inputs/database.fasta" \
        --decoy_prefix "DECOY_"\
        --params_file "samples/heteroplasmic_muscle/inputs/params.ini" \
        --sitelist_file "samples/heteroplasmic_muscle/inputs/site_solver_list.txt" \
        --groupmaker_file "samples/heteroplasmic_muscle/inputs/group_maker_list.txt" \
        --outdir  "samples/heteroplasmic_muscle/results" \
        -resume
```


# Image Version History

For more information about the program version included within the Singularity version, refer to the [changelog](changelog.md) for the current version.
