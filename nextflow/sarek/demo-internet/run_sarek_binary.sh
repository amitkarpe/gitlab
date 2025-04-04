#!/bin/bash

# --- Sarek Execution with Nextflow Binary (Basic) ---
#
# Purpose:
#   Runs the nf-core/sarek pipeline using the locally installed Nextflow binary.
#   Downloads the latest stable release (or specified version) and executes it.
#   Processes run directly on the host machine without containerization by default.
#
# Inputs:
#   - Requires a samplesheet file (e.g., samplesheet.csv) in the current directory.
#   - Assumes 'nextflow' binary is installed and in the PATH.
#
# Expected Outputs:
#   - './results_binary_basic' directory containing pipeline outputs.
#   - Nextflow execution logs (.nextflow.log, reports).

echo "Starting Sarek pipeline with Nextflow binary (basic)..."
echo "Requires: samplesheet.csv, nextflow in PATH"
echo "Output: ./results_binary_basic"

# Ensure output directory naming is consistent
OUTDIR="./results_binary_basic"
mkdir -p ${OUTDIR}

nextflow run nf-core/sarek \
    -r 3.4.0 \
    --outdir ${OUTDIR} \
    -profile test \
    -resume

echo "Sarek pipeline (binary, basic) finished. Check ${OUTDIR}"
