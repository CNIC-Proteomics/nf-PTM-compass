# Usage

## Execute the pipeline with samples

The input files provided are open search results for mouse heteroplasmy (`heart tissue`) at the following URL:

https://zenodo.org/records/17159646/files/heteroplasmic_heart.zip?download=1

```
nextflow \
    -log "/tmp/nextflow/log/nf-ptm-compass.log" \
    run main.nf   \
        -profile singularity \
        --sch_files "samples/heteroplasmic_heart/inputs/msfragger/*.tsv" \
        --exp_table "samples/heteroplasmic_heart/inputs/experimental_table.tsv" \
        --database "samples/heteroplasmic_heart/inputs/database.fasta" \
        --decoy_prefix "DECOY_"\
        --params_file "samples/heteroplasmic_heart/inputs/params_nf.ini" \
        --sitelist_file "samples/heteroplasmic_heart/inputs/site_solver_list.txt" \
        --groupmaker_file "samples/heteroplasmic_heart/inputs/group_maker_list.txt" \
        --outdir  "samples/heteroplasmic_heart/results" \
        -resume
```

<!--
+ Using the MSFragger results
```
nextflow \
    -log "/tmp/nextflow/log/nf-ptm-compass.log" \
    run main.nf   \
        -profile singularity \
        --sch_files "/mnt/tierra/U_Proteomica/UNIDAD/Softwares/jmrodriguezc/nf-PTM-compass/samples/heteroplasmic_heart/inputs/msfragger/*.tsv" \
        --exp_table "/mnt/tierra/U_Proteomica/UNIDAD/Softwares/jmrodriguezc/nf-PTM-compass/samples/heteroplasmic_heart/inputs/experimental_table.tsv" \
        --database "/mnt/tierra/U_Proteomica/UNIDAD/Softwares/jmrodriguezc/nf-PTM-compass/samples/heteroplasmic_heart/inputs/database.fasta" \
        --decoy_prefix "DECOY_"\
        --params_file "/mnt/tierra/U_Proteomica/UNIDAD/Softwares/jmrodriguezc/nf-PTM-compass/samples/heteroplasmic_heart/inputs/params_nf.ini" \
        --sitelist_file "/mnt/tierra/U_Proteomica/UNIDAD/Softwares/jmrodriguezc/nf-PTM-compass/samples/heteroplasmic_heart/inputs/site_solver_list.txt" \
        --groupmaker_file "/mnt/tierra/U_Proteomica/UNIDAD/Softwares/jmrodriguezc/nf-PTM-compass/samples/heteroplasmic_heart/inputs/group_maker_list.txt" \
        --outdir  "/mnt/tierra/U_Proteomica/UNIDAD/Softwares/jmrodriguezc/nf-PTM-compass/samples/heteroplasmic_heart/results" \
        -resume
```
+ Using the REFMOD module
```
nextflow \
    -log "/tmp/nextflow/log/nf-ptm-compass.log" \
    run main.nf   \
        -profile singularity \
        --search_engine refmod \
        --sch_files "/mnt/tierra/U_Proteomica/UNIDAD/Softwares/jmrodriguezc/nf-PTM-compass/samples/heteroplasmic_heart/inputs/refmod/*.tsv" \
        --exp_table "/mnt/tierra/U_Proteomica/UNIDAD/Softwares/jmrodriguezc/nf-PTM-compass/samples/heteroplasmic_heart/inputs/experimental_table.tsv" \
        --database "/mnt/tierra/U_Proteomica/UNIDAD/Softwares/jmrodriguezc/nf-PTM-compass/samples/heteroplasmic_heart/inputs/database.fasta" \
        --decoy_prefix "DECOY_"\
        --params_file "/mnt/tierra/U_Proteomica/UNIDAD/Softwares/jmrodriguezc/nf-PTM-compass/samples/heteroplasmic_heart/inputs/params_nf.ini" \
        --sitelist_file "/mnt/tierra/U_Proteomica/UNIDAD/Softwares/jmrodriguezc/nf-PTM-compass/samples/heteroplasmic_heart/inputs/site_solver_list.txt" \
        --groupmaker_file "/mnt/tierra/U_Proteomica/UNIDAD/Softwares/jmrodriguezc/nf-PTM-compass/samples/heteroplasmic_heart/inputs/group_maker_list.txt" \
        --outdir  "/mnt/tierra/U_Proteomica/UNIDAD/Softwares/jmrodriguezc/nf-PTM-compass/samples/heteroplasmic_heart/results" \
        -resume
```
-->


+ You can download the input files for this `liver` sample from the study by Bagwan N, Bonzon-Kulichenko E, Calvo E, et al. [1] at the following URL:

https://zenodo.org/records/17159646/files/heteroplasmic_liver.zip?download=1

```
nextflow \
    -log "/tmp/nextflow/log/nf-ptm-compass.log" \
    run main.nf   \
        -profile singularity \
        --msf_files "samples/heteroplasmic_liver/inputs/msfragger/*.tsv" \
        --exp_table "samples/heteroplasmic_liver/inputs/experimental_table.tsv" \
        --database "samples/heteroplasmic_liver/inputs/database.fasta" \
        --decoy_prefix "DECOY_"\
        --params_file "samples/heteroplasmic_liver/inputs/params_nf.ini" \
        --sitelist_file "samples/heteroplasmic_liver/inputs/site_solver_list.txt" \
        --groupmaker_file "samples/heteroplasmic_liver/inputs/group_maker_list.txt" \
        --outdir  "samples/heteroplasmic_liver/results" \
        -resume
```

+ You can download the input files for this `muscle` sample from the study by Bagwan N, Bonzon-Kulichenko E, Calvo E, et al. [1] at the following URL:

https://zenodo.org/records/17159646/files/heteroplasmic_muscle.zip?download=1

```
nextflow \
    -log "/tmp/nextflow/log/nf-ptm-compass.log" \
    run main.nf   \
        -profile singularity \
        --msf_files "samples/heteroplasmic_muscle/inputs/msfragger/*.tsv" \
        --exp_table "samples/heteroplasmic_muscle/inputs/experimental_table.tsv" \
        --database "samples/heteroplasmic_muscle/inputs/database.fasta" \
        --decoy_prefix "DECOY_"\
        --params_file "samples/heteroplasmic_muscle/inputs/params_nf.ini" \
        --sitelist_file "samples/heteroplasmic_muscle/inputs/site_solver_list.txt" \
        --groupmaker_file "samples/heteroplasmic_muscle/inputs/group_maker_list.txt" \
        --outdir  "samples/heteroplasmic_muscle/results" \
        -resume
```
