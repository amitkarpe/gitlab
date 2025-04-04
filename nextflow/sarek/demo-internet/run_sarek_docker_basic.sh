#!/bin/bash

# --- Sarek Execution within a Docker Container (Basic) ---
#
# Purpose:
#   Runs the 'nextflow run' command itself from within a Docker container.
#   Uses a pre-built image containing Nextflow and Java.
#   NOTE: This does *not* automatically run pipeline *processes* in containers.
#
# Inputs:
#   - Requires samplesheet.csv in the current directory.
#   - Requires Docker installed and running.
#   - Current directory is mounted to /data inside the container.
#
# Expected Outputs:
#   - './results_docker_basic' directory on the HOST containing pipeline outputs.
#   - Nextflow logs on the HOST.

echo "Starting Sarek pipeline using Nextflow Docker image (basic)..."
echo "Requires: samplesheet.csv, Docker"
echo "Output: ./results_docker_basic"

# Ensure output directory exists on host for mounting
OUTDIR="./results_docker_basic"
mkdir -p ${OUTDIR}

docker run -it --rm \
    -v $(pwd):/data \
    -w /data \
    nextflow/nextflow:24.04.4 \
    run nf-core/sarek \
        -r 3.4.0 \
        --input samplesheet.csv \
        --outdir ${OUTDIR} \
        -resume

echo "Sarek pipeline (Docker basic) finished. Check ${OUTDIR} on host."

