# PTM-compass
Nextflow pipeline for the PTM-compass workflow


# Usage

Executing using Ubuntu and Singularity (WSL - backend):

This workflow starts with SHIFTS
```
cd /home/jmrodriguezc/nf-PTM-compass

nextflow \
    -log "/tmp/nextflow/log/nf-ptm-compass.log" \
    run main.nf   \
        -profile singularity \
        --re_files "/mnt/tierra/U_Proteomica/UNIDAD/DatosCrudos/jmrodriguezc/projects/nf-PTM-compass/tests/test1/inputs/re_files/*" \
        --exp_table "/mnt/tierra/U_Proteomica/UNIDAD/DatosCrudos/jmrodriguezc/projects/nf-PTM-compass/tests/test1/inputs/exp_table.txt" \
        --database "/mnt/tierra/U_Proteomica/UNIDAD/DatosCrudos/jmrodriguezc/projects/nf-PTM-compass/tests/test1/inputs/database.fasta" \
        --decoy_prefix "DECOY_"\
        --params_file "/mnt/tierra/U_Proteomica/UNIDAD/DatosCrudos/jmrodriguezc/projects/nf-PTM-compass/tests/test1/inputs/params.ini" \
        --sitelist_file "/mnt/tierra/U_Proteomica/UNIDAD/DatosCrudos/jmrodriguezc/projects/nf-PTM-compass/tests/test1/inputs/sitelist.txt" \
        --groupmaker_file "/mnt/tierra/U_Proteomica/UNIDAD/DatosCrudos/jmrodriguezc/projects/nf-PTM-compass/tests/test1/inputs/groupmaker.txt" \
        --outdir  "/mnt/tierra/U_Proteomica/UNIDAD/DatosCrudos/jmrodriguezc/projects/nf-PTM-compass/tests/test1" \
        -resume
```

Adding the parameters into "inputs.yml" file
```
nextflow \
    -log "/tmp/nextflow/log/nf-ptm-compass.log" \
    run main.nf   \
        -profile singularity \
        -params-file "/mnt/tierra/U_Proteomica/UNIDAD/DatosCrudos/jmrodriguezc/projects/nf-PTM-compass/tests/test1/inputs/inputs.yml" \
        --params_file "/mnt/tierra/U_Proteomica/UNIDAD/DatosCrudos/jmrodriguezc/projects/nf-PTM-compass/tests/test1/inputs/params.ini" \
        --outdir  "/tmp/test1" \
        -resume
```

Debugging using Ubuntu (Docker - backend):
```
cd /usr/local/nf-PTM-compass

nextflow \
    -log "/opt/nextflow/nextflow/log/nf-ptm-compass.log" \
    run main.nf   \
        -params-file "/mnt/tierra/nf-PTM-compass/tests/test1/inputs/inputs.yml" \
        --outdir  "/mnt/tierra/nf-PTM-compass/tests/test1" \
        --params_file "/mnt/tierra/nf-PTM-compass/tests/test1/inputs/params.ini" \
        -resume
```


In Production using the Web Server

nextflow \
    -log "/tmp/nf-ptm-compass.log" \
    run main.nf   \
        --wkf "ptm_compass" \
        --inputs "/mnt/tierra/U_Proteomica/UNIDAD/DatosCrudos/jmrodriguezc/projects/nf-PTM-compass/tests/test2/params/inputs_ptmcompass.yml" \
        --outdir  "/mnt/tierra/U_Proteomica/UNIDAD/DatosCrudos/jmrodriguezc/projects/nf-PTM-compass/tests/test2" \
        -params-file "/mnt/tierra/U_Proteomica/UNIDAD/DatosCrudos/jmrodriguezc/projects/nf-PTM-compass/tests/test2/params/params.yml" \
        --params_file "/mnt/tierra/U_Proteomica/UNIDAD/DatosCrudos/jmrodriguezc/projects/nf-PTM-compass/tests/test2/params/ptm-compass.ini" \
        -resume

<!--
```
nextflow \
    -log "/opt/nextflow/nextflow/log/nf-ptm-compass.log" \
    run main.nf   \
        --wkf "refrag" \
        -params-file "/mnt/tierra/nf-PTM-compass/tests/test2/inputs/inputs.yml" \
        --outdir  "/mnt/tierra/nf-PTM-compass/tests/test2" \
        --params_file "/mnt/tierra/nf-PTM-compass/tests/test2/inputs/params.ini" \
        -resume

nextflow \
    -log "/opt/nextflow/nextflow/log/nf-ptm-compass.log" \
    run main.nf   \
        --wkf "ptm_compass" \
        --inputs "/mnt/tierra/nf-PTM-compass/tests/test2/params/inputs_ptmcompass.yml" \
        --outdir  "/mnt/tierra/nf-PTM-compass/tests/test2" \
        -params-file "/mnt/tierra/nf-PTM-compass/tests/test2/params/params.yml" \
        --params_file "/mnt/tierra/nf-PTM-compass/tests/test2/params/ptm-compass.ini" \
        -resume
```        
-->



<!--

# iSanXoT workflow for PTMs

Hola, usa la Z que sale de qfq2qfqall, o sea q2all, que es simplemente Zq, para la comparativa.

Es mucho más sencillo que eso. Yo lo definiría así:
-workflow normal: 
scan2pdm           (scan a peptidoforma) 
pdm2pgm           (agrupamiento de pdm para evitar dilución) sin varianza, solo agrupar
pgm2p                  (cambios en peptidoformas dentro de cada peptido) 
p2qf                       (digestión parcial) 
qf2q                       (cambios zonales) 
q2all                      (cambios de proteínas)

-integraciones “extra” (no sé por qué se hacen de rutina, se pierde mucho tiempo, yo sólo las haría si hicieran falta en un momento dado):

pgm2pgmq         (serviría para ver directamente cambios sin etapas intermedias) 
pgm2pgmqf       (no le veo ninguna utilidad)
p2pq                      (peptido a proteína, sin pasar por qf… ) 

y aquí echo en falta pdm2pdmq, que es lo que haríamos con el wf antiguo, y vendría bien para comparar.

 -->
