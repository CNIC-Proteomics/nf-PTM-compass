# ptm-compass
PTM-compass workflow


# Usage
<!-- nextflow  -c nextflow.config  -bg -q -log demuxRun.log run demuxWithUMI.nf -resume  -params-file 230208_A02012_0014_AHMKVTDRX2.params.yam -->

```
nextflow \
    run main.nf   \
        -profile singularity \
        --params_shifts "/home/jmrodriguezc/ptm-compass/SHIFTS.ini" \
        --input_files "/home/jmrodriguezc/projects/ptm-compass/tests/test2/Recom/JM_HuMarfanPlasma_TMT[0-9].txt" \
        --outdir  "/home/jmrodriguezc/projects/ptm-compass/tests/test2/Recom/outdir" \
        -resume

```

<!--
nextflow -config nextflow.config \
    run shifts_solver.nf \
        -params-file params.shifts_solver.yml \
        --input_files "/home/jmrodriguezc/projects/ptm-compass/tests/test2/Recom/JM_HuMarfanPlasma_TMT[0-9].txt" \
        --output_dir  "/home/jmrodriguezc/projects/ptm-compass/tests/test2/Recom/outdir" \
        -resume
-->


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

