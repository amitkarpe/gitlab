# Requirement Specification: TRUST Tech Deliverable 4a. Enable user GitLab & Docker images

![Synapxe Logo](Logo.png "Synapxe Logo")

**Prepared By**

| Name       | Project Role   | Signature | Date        |
| :--------- | :------------- | :-------- | :---------- |
| Amit Karpe | Lead Engineer  |           | 30 Nov 2024 |

**Reviewed By**

| Name          | Project Role | Signature | Date        |
| :------------ | :----------- | :-------- | :---------- |
| Yeo Zhen Xuan | Tech Lead    |           | 30 Nov 2024 |

**Approved By**

| Name       | Project Role            | Signature | Date        |
| :--------- | :---------------------- | :-------- | :---------- |
| Luke Lim   | Synapxe Project Manager |           | 30 Nov 2024 |
| Kevin Lam  | TRUST Business Lead     |           | 30 Nov 2024 |

---

## Table of Contents

1.  Introduction
    * 1.1 Document Purpose
    * 1.2 System Overview
    * 1.3 Project Objectives / Goals
    * 1.4 Definitions/Glossary
    * 1.5 References
2.  Functional Specification Overview
    * 2.1 In-Scope
    * 2.2 Out-of-Scope
    * 2.3 Assumptions and Dependencies
    * 2.4 User Access
3.  Workflows: NA
4.  Functional Requirements: NA
5.  Data Setup: NA
6.  Reconciliation Reports: NA
7.  Batch Jobs: NA
8.  Audit Logging: NA
9.  Data Migration Requirements: NA
10. Interface Requirements: NA
11. Performance Requirements: NA
12. Summary / Recommendations: NA
* Appendix A: NA

---

## 1. Introduction

### 1.1 Document Purpose

This document defines the requirement specifications for deploying code, container repositories, and related cloud infrastructure in a non-internet environment within Singapore Government on Commercial Cloud (GCC) by GovTech[cite: 44]. The project aims to enable private repository hosting, pipeline execution, and container management for Lifebit CloudOS workflows[cite: 45].

### 1.2 System Overview

* **Tech Deliverable:** 4a. Enable Lifebit users to run their own codes. Phase 1 – Setup repositories (GitLab and AWS ECR) for hosting, accessing & managing private Docker tools & scripts/codes. Phase 2 – Setup to support hosting, accessing & managing NextFlow pipeline[cite: 46].
* **Problem Statement:** How to deploy and run custom codes and pipelines within TRUST-Lifebit platform. Currently, there is no version control repository available within the TRUST-Lifebit platform where researchers can host their custom codes and pipelines. Researchers are limited to using only the predefined system tools and pipelines provided by Lifebit, which cannot be tailored to their specific research needs, hindering flexibility and innovation in their workflows[cite: 46].
* **Outcome:** CloudOS user can securely access and perform version control and collaborate with fellow researchers of their private codes, docker tools, and pipelines using Gitlab account and docker images using AWS ECR[cite: 46].
* **Background Work:** SHIP and HATS by GovTech which provides Gitlab and Nessus Repository[cite: 47]. But Per Use of Gitlab will need license / subscription cost, that is why this solution was not accepted[cite: 48].
* **Solution:** The solution includes a hosted GitLab server in the CloudOS environment for private code repositories[cite: 49], AWS Elastic Container Registry (ECR) in a separate AWS GCC account for container images[cite: 50], workload execution using AWS Batch in a dedicated compute environment[cite: 51], and secure communication and deployment strategies due to the non-internet constraints[cite: 51].

### 1.3 Project Objectives / Goals

* Enable private code and container repository hosting within a closed cloud environment[cite: 52].
* Provide a scalable and secure solution for pipeline execution and container management[cite: 53].
* Ensure compliance with regulatory and security requirements[cite: 53].

### 1.4 Definitions/Glossary

* **GitLab Server:** Self-hosted version of GitLab for code repository management[cite: 54].
* **AWS ECR:** Private container image repository for storing and managing Docker images[cite: 55].
* **AWS Batch:** Managed batch processing service for running containerized workloads[cite: 56].
* **CloudOS:** Lifebit’s cloud-native bioinformatics platform[cite: 56].

### 1.5 References

* GovTech GCC Documentation [cite: 57]
* AWS Security Best Practices [cite: 57]

---

## 2. Functional Specification Overview

### 2.1 In-Scope

* Setup a self-hosted GitLab server within the CloudOS environment[cite: 57].
* Setup of AWS ECR in a separate AWS GCC account for private container storage[cite: 58].
* Integration of AWS Batch for executing workflows[cite: 59].

### 2.2 Out-of-Scope

* External internet connectivity for GitLab or ECR[cite: 59].
* Support for third-party container registries[cite: 59].

### 2.3 Assumptions and Dependencies

* AWS GCC accounts are pre-configured with necessary permissions[cite: 60].
* CloudOS is deployed and functional in a closed environment[cite: 60].

### 2.4 User Access

* Researchers and engineers will have access to GitLab for version control via Commandline[cite: 61].
* AWS ECR will be accessible only within AWS GCC accounts via private networking[cite: 62].

---

## 3. Workflows
NA

## 4. Functional Requirements
NA

## 5. Data Setup
NA

## 6. Reconciliation Reports
NA

## 7. Batch Jobs
NA

## 8. Audit Logging
NA

## 9. Data Migration Requirements
NA

## 10. Interface Requirements
NA

## 11. Performance Requirements
NA

## 12. Summary / Recommendations
NA

---

## Appendix A
NA