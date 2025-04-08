#!/usr/bin/env bash

# ------------------------------
# Export nf-core pipeline + Docker images for offline use
# ------------------------------

set -euo pipefail

# --- Configurable Defaults ---
S3_BUCKET="${S3_BUCKET:-}"  # Set this as env var if needed
PROFILE="test,docker"
OUTDIR_ROOT="${OUTDIR_ROOT:-offline_assets}"  # Base output dir

# --- Check Dependencies ---
for cmd in nextflow docker jq aws; do
    command -v $cmd >/dev/null 2>&1 || { echo >&2 "Error: '$cmd' command not found."; exit 1; }
done

# --- Check Arguments ---
if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <nf-core_pipeline> (e.g., nf-core/rnaseq)"
    exit 1
fi

PIPELINE="$1"
MODULE=$(echo "${PIPELINE}" | sed 's|/|_|g')
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
OUTDIR="${OUTDIR_ROOT}/${MODULE}_${TIMESTAMP}"
mkdir -p "${OUTDIR}/images" "${OUTDIR}/pipeline"

echo "🔍 Inspecting pipeline: ${PIPELINE}"
INSPECT_JSON="${OUTDIR}/${MODULE}_inspect.json"
if nextflow inspect "${PIPELINE}" -profile ${PROFILE} --outdir "${OUTDIR}/tmp" > "${INSPECT_JSON}"; then
    rm -rf "${OUTDIR}/tmp"
else
    echo "❌ Failed to inspect pipeline."
    exit 1
fi

echo "📁 Copying pipeline code..."
PIPELINE_SRC_DIR="${HOME}/.nextflow/assets/${PIPELINE}"
cp -r "${PIPELINE_SRC_DIR}" "${OUTDIR}/pipeline/"

echo "🐳 Extracting Docker containers..."
jq -r '.processes[].container | select(length > 0)' "${INSPECT_JSON}" | sort -u > "${OUTDIR}/image-list.txt"

echo "📦 Pulling and saving Docker images..."
while read -r image; do
    [[ -z "$image" ]] && continue
    image_basename=$(basename "$image")
    tar_name=$(echo "${image_basename}" | sed 's/:/_/g').tar
    out_tar="${OUTDIR}/images/${tar_name}"

    echo "➡️  $image"
    docker pull "$image"
    docker save "$image" -o "$out_tar"
done < "${OUTDIR}/image-list.txt"

echo "✅ All images pulled and saved to: ${OUTDIR}/images"
echo "✅ Pipeline code saved to: ${OUTDIR}/pipeline"

# --- Upload to S3 ---
if [[ -n "$S3_BUCKET" ]]; then
    echo "☁️  Uploading to S3: $S3_BUCKET"
    aws s3 sync "${OUTDIR}" "s3://${S3_BUCKET}/${MODULE}_${TIMESTAMP}/"
    echo "✅ Upload complete."
else
    echo "ℹ️  No S3_BUCKET specified. Skipping upload."
    echo "    To upload: S3_BUCKET=your-bucket-name ./offline_nextflow_export.sh nf-core/rnaseq"
fi

# --- Final Instructions ---
cat <<EOF

🚀 Done! You can now copy this directory to your offline machine:
  ${OUTDIR}

🖥️ On the offline machine:
  cd ${OUTDIR}/images
  for f in *.tar; do docker load -i \$f; done

🧪 Run the pipeline:
  export NXF_OFFLINE=true
  nextflow run ${OUTDIR}/pipeline/rnaseq -r 3.18.0 -profile docker --outdir /tmp/output

EOF
