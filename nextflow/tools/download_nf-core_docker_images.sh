#!/usr/bin/env bash

# --- Bash Script to Download Docker Images for an nf-core Pipeline ---
#
# Purpose:
#   Inspects a Nextflow pipeline (using 'nextflow inspect'), extracts the
#   Docker container image names used by its processes, and saves each
#   image as a .tar file using 'docker save'. This is useful for
#   transferring pipeline dependencies to an offline environment.
#
# Relies on: nextflow, docker, jq
#
# Usage:
#   ./download_nf-core_docker_images.sh <nf-core_pipeline_name>
# Example:
#   ./download_nf-core_docker_images.sh nf-core/rnaseq
#   ./download_nf-core_docker_images.sh nf-core/sarek
#
# Outputs:
#   - <pipeline_name_sanitized>_image_list.json : JSON output from 'nextflow inspect'.
#   - <pipeline_name_sanitized>_images/ : Directory containing the saved .tar image files.
#
# Based on the Python script from: https://github.com/nextflow-io/nextflow/discussions/4708

# --- Configuration ---
set -euo pipefail # Exit on error, undefined variable, or pipe failure

# --- Check Dependencies ---
command -v nextflow >/dev/null 2>&1 || { echo >&2 "Error: 'nextflow' command not found. Please install Nextflow."; exit 1; }
command -v docker >/dev/null 2>&1 || { echo >&2 "Error: 'docker' command not found. Please install Docker."; exit 1; }
command -v jq >/dev/null 2>&1 || { echo >&2 "Error: 'jq' command not found. Please install jq (e.g., 'sudo dnf install jq')."; exit 1; }

# --- Argument Handling ---
if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <nf-core_pipeline_name>"
    echo "Example: $0 nf-core/rnaseq"
    exit 1
fi

core_module="$1"
# Sanitize pipeline name for use in filenames (replace '/' with '_')
module=$(echo "${core_module}" | sed 's|/|_|g')

echo "Pipeline: ${core_module}"
echo "Output prefix: ${module}"

# --- Inspect Pipeline (if JSON doesn't exist) ---
json_file="${module}_image_list.json"
image_dir="${module}_images"

if [[ ! -f "${json_file}" ]]; then
    echo "Inspecting pipeline to find Docker images..."
    # Run nextflow inspect and capture output to the JSON file
    # Using a temporary file and move to avoid partial file if inspect fails
    temp_json=$(mktemp)
    if nextflow inspect "${core_module}" -profile test,docker --outdir "testing_${module}" > "${temp_json}"; then
        mv "${temp_json}" "${json_file}"
        echo "Pipeline inspection saved to ${json_file}"
        # Clean up the temporary testing directory created by inspect
        rm -rf "testing_${module}" > /dev/null 2>&1 || true
    else
        echo >&2 "Error: 'nextflow inspect' failed. Could not generate ${json_file}."
        rm -f "${temp_json}" # Clean up temp file on failure
        exit 1
    fi
else
    echo "Using existing inspection file: ${json_file}"
fi

# --- Create Image Directory ---
if [[ ! -d "${image_dir}" ]]; then
    echo "Creating image directory: ${image_dir}"
    mkdir -p "${image_dir}"
else
    echo "Image directory already exists: ${image_dir}"
fi

# --- Parse JSON and Save Images ---
echo "Parsing JSON and saving Docker images..."

# Use jq to extract container image names, filtering out null/empty values and ensuring uniqueness
# Read line by line to handle potential issues with large lists
jq -r '.processes[].container | select(length > 0)' "${json_file}" | sort -u | while IFS= read -r image; do
    if [[ -z "$image" ]]; then
        echo "Skipping empty image name."
        continue
    fi

    # Generate a valid filename for the tarball
    # Get the base name (e.g., biocontainers/fastqc:0.11.9--0 -> fastqc:0.11.9--0)
    image_basename=$(basename "${image}")
    # Replace ':' with '_' (e.g., fastqc:0.11.9--0 -> fastqc_0.11.9--0)
    tar_name=$(echo "${image_basename}" | sed 's/:/_/g').tar
    output_path="${image_dir}/${tar_name}"

    # --- ADDED: Pull the image first ---
    echo -n "Pulling image: ${image} ... "
    if docker pull "${image}"; then
        echo "Pulled."
        # --- Now save the pulled image ---
        echo -n "Attempting to save image: ${image} -> ${output_path} ... "
        if docker save "${image}" --output "${output_path}"; then
            echo "Saved."
        else
            echo "Failed to save pulled image!"
        fi
    else
        echo "Failed to pull!"
    fi
done

echo "--- Docker image download process finished. ---"
echo "Tar files are located in: ${image_dir}"
echo "Transfer this directory to the offline system and run:"
echo "cd ${image_dir} && ls -1 *.tar | xargs -L 1 docker load -i"
