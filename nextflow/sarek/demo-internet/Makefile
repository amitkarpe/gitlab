# Makefile for running nf-core/sarek pipeline examples

# Ensure scripts are executable
$(shell chmod +x *.sh)

# Default target (optional: provide help or run a default case)
default: help

help:
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@echo "  binary             -> Run Sarek using local Nextflow binary (basic)."
	@echo "  docker_basic       -> Run Nextflow itself inside Docker (basic)."
	@echo "  binary_params      -> Run Sarek with local Nextflow + custom parameters."
	@echo "  docker_params      -> Run Nextflow in Docker + custom parameters."
	@echo "  binary_test        -> Run Sarek with local Nextflow + 'test' profile."
	@echo "  docker_test        -> Run Nextflow in Docker + 'test' profile."
	@echo "  binary_docker      -> Run Sarek with local Nextflow + 'docker' profile (processes in Docker)."
	@echo "  docker_docker      -> Run Nextflow in Docker + 'docker' profile (Docker-in-Docker)."
	@echo "  clean              -> Remove results directories and Nextflow work/log files."
	@echo ""
	@echo "Prerequisites: See makefile.md for required software (Java, Nextflow, Docker)."
	@echo "Note: Most targets require 'samplesheet.csv' in the current directory."


# --- Execution Targets ---

# Run Sarek using the locally installed Nextflow binary (basic)
binary:
	@echo "--- Running: make binary ---"
	bash ./run_sarek_binary.sh

# Run the Nextflow command itself from within a Docker container (basic)
docker_basic:
	@echo "--- Running: make docker_basic ---"
	bash ./run_sarek_docker_basic.sh

# Run Sarek using the local Nextflow binary with specific parameters
binary_params:
	@echo "--- Running: make binary_params ---"
	bash ./run_sarek_binary_params.sh

# Run the Nextflow command within a Docker container with specific parameters
docker_params:
	@echo "--- Running: make docker_params ---"
	bash ./run_sarek_docker_params.sh

# Run Sarek using the local Nextflow binary with the 'test' profile
binary_test:
	@echo "--- Running: make binary_test ---"
	bash ./run_sarek_binary_test_profile.sh

# Run the Nextflow command within a Docker container with the 'test' profile
docker_test:
	@echo "--- Running: make docker_test ---"
	bash ./run_sarek_docker_test_profile.sh

# Run Sarek using the local Nextflow binary, executing processes in Docker containers
binary_docker:
	@echo "--- Running: make binary_docker ---"
	bash ./run_sarek_binary_docker_profile.sh

# Run the Nextflow command within a Docker container, executing processes also in Docker (DinD)
docker_docker:
	@echo "--- Running: make docker_docker ---"
	bash ./run_sarek_docker_docker_profile.sh


# --- Utility Targets ---

# Clean up results and Nextflow temporary files
clean:
	@echo "--- Cleaning up results and Nextflow files ---"
	rm -rf ./results_*
	rm -rf ./.nextflow*
	rm -rf ./work
	rm -f ./nextflow_report*.html
	rm -f ./nextflow_trace*.txt
	rm -f ./pipeline_info/*

.PHONY: default help binary docker_basic binary_params docker_params binary_test docker_test binary_docker docker_docker clean

