 GitLab on AWS - Docker Image Automation for Nextflow
This repository automates the process of pulling Docker images from Docker Hub and pushing them to AWS ECR (Elastic Container Registry) for use with Nextflow pipelines.

Design & Requirement Documentation
1. Project Overview
The project automates the management of Docker images used in Nextflow pipelines. Docker images are pulled from Docker Hub and pushed to AWS ECR to streamline the deployment of Nextflow pipelines on AWS infrastructure. The automation ensures that images are only updated when necessary (based on age) and that failed image processing does not interrupt the workflow.

2. Functional Requirements
The system must fulfill the following functional requirements:

Image Management:

Users should be able to add Docker image names and tags to list_images.md.

The system must automatically pull images from Docker Hub.

If the image is not in AWS ECR, the system should create a corresponding repository.

The system must tag the image with a format suitable for AWS ECR.

Only images that are older than 7 days or are not present in AWS ECR should be refreshed.

The system must push the images to ECR after tagging.

Automation Process:

Upon merging a pull request (PR) with new image additions to list_images.md, the automation must trigger AWS CodeBuild to process the images.

The CodeBuild process must automatically:

Check if the image exists in ECR and if it needs to be updated.

Pull new or outdated images from Docker Hub.

Skip images that were recently pushed (within the past 7 days).

Authentication & Error Handling:

The system should authenticate Docker Hub using stored credentials to avoid rate limiting during pulls.

The system should handle errors gracefully, logging them without halting the processing of other images.

Failed images should be logged for review but not interrupt the overall pipeline.

3. Non-Functional Requirements
Performance:

The system should process images quickly and efficiently, minimizing unnecessary Docker pulls or ECR pushes.

The system must handle up to 100 images per batch without significant delays.

Reliability:

The system must reliably push images to AWS ECR, ensuring that all images listed are available in the registry.

The failure of one image to push should not affect the processing of other images in the queue.

Security:

Authentication credentials for Docker Hub must be securely stored in AWS Secrets Manager.

ECR repositories should be configured with appropriate IAM permissions to restrict access to authorized users.

Scalability:

The solution should be able to scale and handle an increasing number of Docker images and repositories as needed.

4. System Architecture
The architecture of the system is as follows:

GitLab CI/CD Pipeline:

The system leverages GitLab's PR workflow to trigger AWS CodeBuild upon merging changes to list_images.md.

The PR is reviewed, and once approved, the changes automatically trigger CodeBuild.

AWS CodeBuild:

CodeBuild is used to automate the process of checking ECR for existing images, pulling updated Docker images from Docker Hub, and pushing them to AWS ECR.

It uses the buildspec.yml file to define the build steps and environment variables.

Docker Hub:

Docker Hub is the source of Docker images. The automation pulls images from Docker Hub based on the entries in list_images.md.

AWS ECR:

AWS Elastic Container Registry (ECR) is used to store the Docker images after they are pulled from Docker Hub and tagged for ECR.

5. Data Design
The system uses a simple file (list_images.md) to store the list of Docker images to be processed. The images are referenced by their Docker Hub image names (e.g., mambaorg/micromamba:0.25.1).

Example of list_images.md:
markdown
Copy
Edit
mambaorg/micromamba:0.25.1
nextflow/rnaseq-nf:latest
Each image entry is processed individually, ensuring minimal downtime and failures.

6. Interface Design
User Input: Users add Docker images to the list_images.md file by submitting a PR. The PR is reviewed and merged by project maintainers.

Logging and Output: The automation logs all actions performed, including the pull, push, and skipping of images.

Error Reporting: If an image fails to process, it is logged for review, and the pipeline continues processing other images.

7. Testing & Validation
The system includes testing scripts for validating the CodeBuild logic both locally and on AWS:

Local Testing:

The test-local.sh script simulates the build process locally, allowing for quick validation before pushing to AWS.

Full AWS CodeBuild Local Testing:

The local-build.sh script uses the AWS CodeBuild Local agent to test the build in an environment that closely mimics AWS CodeBuild.

Test Validation:

Ensure that only necessary images are pulled from Docker Hub.

Verify that the ECR repositories are created automatically and that images are tagged correctly.

Check that images are pushed to ECR and are available for use.

8. Deployment & Maintenance
CI/CD Pipeline: Once the system is set up, it will automatically deploy updates with each successful PR merge.

Monitoring: AWS CloudWatch can be used to monitor the CodeBuild process for any failures or issues that arise during the automation.

Regular Updates: The system should be reviewed every 6 months to ensure that it can handle any changes in Docker Hub or AWS ECR policies.
