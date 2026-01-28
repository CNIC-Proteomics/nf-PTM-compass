___
## 1.10

### Date 📅 *2026_01*

### Changes in detail

**rc1**
+ Add the fixed parameter file when the inputs are derived from REFMOD results.
+ Change the parameter key in the command line for the search engine result files.
+ Refine and simplify the code by removing obsolete code.
+ Discard nextflow schema file from nf-core. It is saved in the "pipeline" folder of next-Launcher.

**rc2**
+ Added caldeltamh_column parameter to PeakModeller.

**rc3**
+ Upgrade the Python version to 3.12 in the singularity image using the default Python version from Ubuntu 24.04.

**rc4**
+ Fixed a bug in the 'refmod' parameter flag.

### Image Version history

+ Updated to the new version:
  - PTM-compass 1.7

| Singularity image (version)                                                                        | Code                                                          | Version |
|----------------------------------------------------------------------------------------------------|---------------------------------------------------------------|---------|
|                                                                                                    |                                                               |         |
| [ptm-compass:1.7](https://cloud.sylabs.io/library/proteomicscnic/next-launcher/ptm-compass)        |                                                               |         |
|                                                                                                    | [PTM-compass](https://github.com/CNIC-Proteomics/PTM-compass) | 1.7     |


___
## 1.9

### Date 📅 *2025_09*

### Changes in detail

**rc1**
+ Upgraded Nextflow modules.
+ Updated singularity image.
+ Updated documentation: Zenodo repository.
+ Version format reduced from three segments to two (major.minor).

**rc2**
+ Upgraded Nextflow modules.

### Image Version history

+ Updated to the new version:
  - PTM-compass 1.5

| Singularity image (version)                                                                        | Code                                                          | Version |
|----------------------------------------------------------------------------------------------------|---------------------------------------------------------------|---------|
|                                                                                                    |                                                               |         |
| [ptm-compass:1.5](https://cloud.sylabs.io/library/proteomicscnic/next-launcher/ptm-compass)        |                                                               |         |
|                                                                                                    | [PTM-compass](https://github.com/CNIC-Proteomics/PTM-compass) | 1.5     |



___
## 0.1.8

### Date 📅 *2025_08*

### Changes in detail

**rc1**
+ Updated documentation:
  - Highlighting the Singularity and Nextflow versions.
  - Hardware specifications and execution time.
  - Summary log in the pipeline execution (nextflow).
**rc2**
+ Updated summary log in the pipeline execution (nextflow).
**rc3**
+ Moved the process container attribute from the modules.config file to nextflow.config.
**rc4,rc5,rc6**
+ Fixing the bug in the nextflow.config for the process container.
**rc7**
+ Redefine the process container attribute.

### Image Version history

| Singularity image (version)                                                                          | Code                                                          | Version |
|------------------------------------------------------------------------------------------------------|---------------------------------------------------------------|---------|
|                                                                                                      |                                                               |         |
| [ptm-compass:0.1.5](https://cloud.sylabs.io/library/proteomicscnic/next-launcher/ptm-compass)        |                                                               |         |
|                                                                                                      | [PTM-compass](https://github.com/CNIC-Proteomics/PTM-compass) | 1.4     |


___
## 0.1.7

### Date 📅 *2025_08*

### Changes in detail

+ Unassigned modifications are now displayed in the *BinomialSiteListMaker*.

+ Parameter update: by default, users can no longer modify the show_unassigned parameter in *BinomialSiteListMaker*.

+ Updated the deltamass lists in *DM0Solver* and *GroupMaker*.

+ Updated the **proteincolumn** of DMcalibrator because MSFragger 4.2 renamed the *protein* column to *proteins*.

+ Updated the deltamass lists for *DM0Solver* in the fixed parameters.



### Image Version history

| Singularity image (version)                                                                          | Code                                                          | Version |
|------------------------------------------------------------------------------------------------------|---------------------------------------------------------------|---------|
|                                                                                                      |                                                               |         |
| [ptm-compass:0.1.5](https://cloud.sylabs.io/library/proteomicscnic/next-launcher/ptm-compass)        |                                                               |         |
|                                                                                                      | [PTM-compass](https://github.com/CNIC-Proteomics/PTM-compass) | 1.4     |


___
## 0.1.6

### Date 📅 *2025_04*

### Changes in detail

+ The ReFrag (REFMOD) code is deprecated here. It will be used in the `nf-SearchEngine` pipeline.
+ Updated the documentation and test guide.
+ Fixed a bug related to saving log files.

### Image Version history

| Singularity image (version)                                                                          | Code                                                          | Version |
|------------------------------------------------------------------------------------------------------|---------------------------------------------------------------|---------|
|                                                                                                      |                                                               |         |
| [ptm-compass:0.1.5](https://cloud.sylabs.io/library/proteomicscnic/next-launcher/ptm-compass)        |                                                               |         |
|                                                                                                      | [PTM-compass](https://github.com/CNIC-Proteomics/PTM-compass) | 1.4     |


___
## 0.1.5

### Date 📅 *2025_02*

### Changes in detail

+ 'base.config' file is deprecated.

### Image Version history

+ PTM-compass (1.3):
  + PeakSelector:
    - Fixed a bug in the 'PeakSelector' related to the bin width.
    - Duplicate bin params in config


| Singularity image (version)                                                                          | Code                                                          | Version |
|------------------------------------------------------------------------------------------------------|---------------------------------------------------------------|---------|
|                                                                                                      |                                                               |         |
| [ptm-compass:0.1.4](https://cloud.sylabs.io/library/proteomicscnic/next-launcher/ptm-compass)        |                                                               |         |
|                                                                                                      | [PTM-compass](https://github.com/CNIC-Proteomics/PTM-compass) | 1.3     |
|                                                                                                      | [RefMod](https://github.com/CNIC-Proteomics/ReFrag)           | 0.4.4   |


___
## 0.1.4

### Date 📅 *2025_01*

### Changes in detail

+ Fixing a bug: The fixed parameter contains the TMT delta masses for the 'TrunkSolver_CombList'.

### Image Version history

| Singularity image (version)                                                                          | Code                                                          | Version |
|------------------------------------------------------------------------------------------------------|---------------------------------------------------------------|---------|
|                                                                                                      |                                                               |         |
| [ptm-compass:0.1.3](https://cloud.sylabs.io/library/proteomicscnic/next-launcher/ptm-compass)        |                                                               |         |
|                                                                                                      | [PTM-compass](https://github.com/CNIC-Proteomics/PTM-compass) | 1.2     |
|                                                                                                      | [RefMod](https://github.com/CNIC-Proteomics/ReFrag)           | 0.4.4   |


___
## 0.1.3

### Date 📅 *2024_12*

### Highlights

+ Include the parameter files.

### Changes in detail

+ Include the parameter files for: TMT_10-plex, TMT_11-plex, TMT_16-plex, TMT_19-plex, Label-Free.

+ Fixing a bug prividing the "database" parameter.


### Image Version history

| Version | Singularity image                                                                                    | Code                                                          | Version |
|---------|------------------------------------------------------------------------------------------------------|---------------------------------------------------------------|---------|
| 0.1.2   |                                                                                                      |                                                               |         |
|         | [ptm-compass:0.1.2](https://cloud.sylabs.io/library/proteomicscnic/next-launcher/ptm-compass)        |                                                               |         |
|         |                                                                                                      | [PTM-compass](https://github.com/CNIC-Proteomics/PTM-compass) | 1.2     |
|         |                                                                                                      | [RefMod](https://github.com/CNIC-Proteomics/ReFrag)           | 0.4.4   |


___
## 0.1.2
```
DATE: 2024_12
```

### Highlights

+ New release of PTM-compass (v1.2)

### Changes

+ New release of PTM-compass (v1.2)


### Image Version history

| Version | Singularity image                                                                                    | Code                                                          | Version |
|---------|------------------------------------------------------------------------------------------------------|---------------------------------------------------------------|---------|
| 0.1.2   |                                                                                                      |                                                               |         |
|         | [ptm-compass:0.1.2](https://cloud.sylabs.io/library/proteomicscnic/next-launcher/ptm-compass)        |                                                               |         |
|         |                                                                                                      | [PTM-compass](https://github.com/CNIC-Proteomics/PTM-compass) | 1.2     |
|         |                                                                                                      | [RefMod](https://github.com/CNIC-Proteomics/ReFrag)           | 0.4.4   |


___
## 0.1.1
```
DATE: 2024_12
```

### Highlights

+ Consolidate the code for SHIFTS, SOLVER, ProteinAssigner, etc., into a single repository.

### Changes

+ Unify the parameters for each code into a single INI parameter file.

+ Update the workflow to accept the MSFragger results.

+ SHIFTadapter: Added a module that inserts the ScanID into search engine results.

### Image Version history

| Version | Singularity image                                                                                    | Code                                                          | Version |
|---------|------------------------------------------------------------------------------------------------------|---------------------------------------------------------------|---------|
| 0.1.1   |                                                                                                      |                                                               |         |
|         | [ptm-compass:0.1.1](https://cloud.sylabs.io/library/proteomicscnic/next-launcher/ptm-compass)        |                                                               |         |
|         |                                                                                                      | [PTM-compass](https://github.com/CNIC-Proteomics/PTM-compass) | 1.1     |
|         |                                                                                                      | [RefMod](https://github.com/CNIC-Proteomics/ReFrag)           | 0.4.4   |


___
## 0.1.0
```
DATE: 2024_07
```

### Highlights

+ Release the first stable version.

### Changes


### Image Version history

| Version | Description                  | Singularity image                                                                                    | Code                                                        | Version |
|---------|------------------------------|------------------------------------------------------------------------------------------------------|-------------------------------------------------------------|---------|
| 0.1.0   | First stable version         |                                                                                                      |                                                             |         |
|         |                              | [ptm-compass:0.1.0](https://cloud.sylabs.io/library/proteomicscnic/next-launcher/ptm-compass)        |                                                             |         |
|         |                              |                                                                                                      | [RefMod](https://github.com/CNIC-Proteomics/ReFrag)         | 0.4.3   |
|         |                              |                                                                                                      | [SHIFTS](https://github.com/CNIC-Proteomics/SHIFTS)         | 0.4.3   |
|         |                              |                                                                                                      | [SOLVER](https://github.com/CNIC-Proteomics/Solvers-PTMap)  | 1.0     |


___
## 0.0.X
```
DATE: 2024_XX
```

### Highlights

+ Developing the beta version

