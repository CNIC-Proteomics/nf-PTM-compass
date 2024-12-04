# nf-PTM-compass

nf-PTM-compass is a [Nextflow](https://www.nextflow.io/) pipeline that enhances the identification and quantification of Post-Translational Modifications (PTMs).

<!-- ![Workflow schema](docs/images/pipeline.png) -->

nf-PTM-compass was developed by the Cardiovascular Proteomics Lab/Proteomic Unit at The National Centre for Cardiovascular Research (CNIC, https://www.cnic.es).

This application is licensed under a Creative Commons Attribution-NoDerivatives 4.0 International (CC BY-ND 4.0) License. For further details, read the https://creativecommons.org/licenses/by-nd/4.0/.

# Installation

## Prerequisites: Linux operating system
Before you begin, ensure you have met the following requirements:

- A Linux operating system is needed on your machine. If you have Windows operating system, read the section [Install WSL on Windows](docs/WSL.md)

## Install Singularity

For more information, read the [How to install Singularity](docs/SingularityCE.md) section.

## Download Singularity images

You need to download the Singularity image for the pipeline, ensuring version compatibility with the Nextflow pipeline. See the above *versions* section:
```
singularity pull --arch amd64 library://proteomicscnic/next-launcher/ptm-compass:0.1.1
```

Create a symbolic link
```
ln -s ptm-compass_0.1.1.sif ptm-compass.sif
```

## Install Nextflow

For more information, read the [How to install Nextflow](docs/Nextflow.md) section.

## Install Git

To update the package list, use the following command:
```
sudo apt-get update
```

We now install git with the following command:
```
apt-get install -y git
```

# Download the pipeline with the latest release

You can clone the latest release directly using git with the following command:
```
export VERSION=0.1.1 && \
  git clone https://github.com/CNIC-Proteomics/nf-PTM-compass.git --branch ${VERSION} --recursive
```
With the *--recursive* parameter, the submodules repositories are cloned as well.

The list of releases is located on the [releases page](https://github.com/CNIC-Proteomics/nf-PTM-compass/releases).

# Usage

## Execute the pipeline using MSFragger results as input

1. Download test files
```
cd tests && \
wget https://zenodo.org/records/12755225/files/test_MSFragger_1.zip?download=1 -O test_MSFragger_1.zip && \
unzip test_MSFragger_1.zip -d test_MSFragger_1
```

2. Execute the pipeline using MSFragger results as input:
```
nextflow \
    -log "/tmp/nextflow/log/nf-ptm-compass.log" \
    run main.nf   \
        -profile singularity \
        --msf_files "tests/test_MSFragger_1/inputs/msfragger/*.tsv" \
        --exp_table "tests/test_MSFragger_1/inputs/exp_table.txt" \
        --database "tests/test_MSFragger_1/inputs/database.fasta" \
        --decoy_prefix "DECOY_"\
        --params_file "tests/test_MSFragger_1/inputs/params.ini" \
        --sitelist_file "tests/test_MSFragger_1/inputs/sitelist.txt" \
        --groupmaker_file "tests/test_MSFragger_1/inputs/grouplist.txt" \
        --outdir  "tests/test_MSFragger_1/results" \
        -resume
```


### Image Version history

| Version | Singularity image                                                                                    | Code                                                          | Version |
|---------|------------------------------------------------------------------------------------------------------|---------------------------------------------------------------|---------|
| 0.1.1   |                                                                                                      |                                                               |         |
|         | [ptm-compass:0.1.1](https://cloud.sylabs.io/library/proteomicscnic/next-launcher/ptm-compass)        |                                                               |         |
|         |                                                                                                      | [PTM-compass](https://github.com/CNIC-Proteomics/PTM-compass) | 1.1     |
|         |                                                                                                      | [RefMod](https://github.com/CNIC-Proteomics/ReFrag)           | 0.4.4   |

For more information, read the [changelog](changelog.md) for the current version.