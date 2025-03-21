# Docker Images for Nextflow Pipelines

This file tracks Docker images that need to be pulled from Docker Hub and pushed to our private AWS ECR repository.

## Format
Each image should be on a new line with the following format:
```
image_name:tag
```

## Images
# Add images below this line (one per line)
# test
nfcore/rnaseq
nfcore/ampliseq
nfcore/scrnaseq
nfcore/rnafusion
nfcore/hlatyping
nfcore/demo
nfcore/sarek

nfcore/ampliseq:1.2.0
nfcore/rnafusion:fusioninspector_2.8.0dev
nfcore/scrnaseq:1.1.0
nfcore/hlatyping:1.2.0
nfcore/sarek:2.7.2
nfcore/sarek
nfcore/rnaseq
nfcore/ampliseq
nfcore/scrnaseq
nfcore/rnafusion
nfcore/hlatyping
nfcore/demo
#nfcore/sarek
#nfcore/sarek
#nfcore/sarek
#nfcore/sarek
#nfcore/sarek
#nfcore/sarek
# Negative testing webhook by updating automation/add_images.md