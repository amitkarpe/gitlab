nf-core pipeline download (only singularity)

nextflow inspect

nextflow pull
 nextflow pull nf-core/ampliseq
ls ~/.nextflow/assets/nf-core/ampliseq

 nextflow inspect ampliseq -profile test --outdir /tmp/ampliseq-out/ -concretize > ampliseq.list

cat ampliseq.list | grep name | wc -l
