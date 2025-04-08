#!/bin/bash

# Downloading pipelines for offline use

# https://nf-co.re/docs/nf-core-tools/pipelines/download

export NXF_PLUGINS_DIR=~/nextflow-offline/plugins
export NXF_SINGULARITY_CACHEDIR=~/nextflow-offline/singularity_image

# https://nf-co.re/hlatyping/2.0.0/
export NAME=hlatyping 
export REVISION="2.0.0"
nf-core pipelines download $NAME -r $REVISION --container-library docker.io --force --container-system none --compress none --outdir /tmp/$NAME --container-cache-utilisation copy

# https://nf-co.re/scrnaseq/4.0.0/
export NAME=scrnaseq
export REVISION="4.0.0"
nf-core pipelines download $NAME -r $REVISION --force --container-system none --download-configuration yes --compress none --outdir /tmp/$NAME --container-cache-utilisation copy

# https://nf-co.re/rnafusion/3.0.2/
export NAME=rnafusion
export REVISION="3.0.2"
nf-core pipelines download $NAME -r $REVISION --force --container-system none --download-configuration yes --compress none --outdir /tmp/$NAME --container-cache-utilisation copy

# https://nf-co.re/ampliseq/2.13.0/
export NAME=ampliseq
export REVISION="2.13.0"
nf-core pipelines download $NAME -r $REVISION --force --container-system none --download-configuration yes --compress none --outdir /tmp/$NAME --container-cache-utilisation remote

# https://nf-co.re/rnaseq/3.18.0/
export NAME=rnaseq
export REVISION="3.18.0"
nf-core pipelines download $NAME -r $REVISION --force --container-system none --download-configuration yes --compress none --outdir /tmp/$NAME --container-cache-utilisation remote