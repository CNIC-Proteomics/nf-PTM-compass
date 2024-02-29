# ptm-compass
Nextflow pipeline for the PTM-compass workflow


# Usage

Debugging using Ubuntu (Docker - backend):
```
cd /usr/local/nf-PTM-compass

nextflow \
    -log "/opt/nextflow/nextflow/log/nf-ptm-compass.log" \
    run main.nf   \
        --wkf "ptm_compass" \
        --inputs "/mnt/tierra/nf-PTM-compass/tests/test2/params/inputs_ptmcompass.yml" \
        --outdir  "/mnt/tierra/nf-PTM-compass/tests/test2" \
        --params_file "/mnt/tierra/nf-PTM-compass/tests/test2/params/ptm-compass.ini" \
        -resume

nextflow \
    -log "/opt/nextflow/nextflow/log/nf-ptm-compass.log" \
    run main.nf   \
        --wkf "refrag" \
        --inputs "/mnt/tierra/nf-PTM-compass/tests/test3/params/inputs_refrag.yml" \
        --outdir  "/mnt/tierra/nf-PTM-compass/tests/test3" \
        -params-file "/mnt/tierra/nf-PTM-compass/tests/test3/params/params.yml" \
        --params_file "/mnt/tierra/nf-PTM-compass/tests/test3/params/ReFrag.ini" \
        -resume

nextflow \
    -log "/opt/nextflow/nextflow/log/nf-ptm-compass.log" \
    run main.nf   \
        --wkf "ptm_compass" \
        --inputs "/mnt/tierra/nf-PTM-compass/tests/test1/params/inputs_ptmcompass.yml" \
        --outdir  "/mnt/tierra/nf-PTM-compass/tests/test1" \
        --params_file "/mnt/tierra/nf-PTM-compass/tests/test1/params/params.ini" \
        -resume

```

In Production using the Web Server


nextflow \
    -log "/opt/nextflow/nextflow/log/nf-refrag.log" \
    run main.nf   \
        --inputs "/mnt/tierra/nf-ReFrag/tests/test1/params/inputs_refrag.yml" \
        --outdir  "/mnt/tierra/nf-ReFrag/tests/test1" \
        -params-file "/mnt/tierra/nf-ReFrag/tests/test1/params/params.yml" \
        --params_file "/mnt/tierra/nf-ReFrag/tests/test1/params/ReFrag.ini" \
        -resume


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
