<p align="right">
  <img src="Logo.png" alt="Synapxe Logo" width="150"/>
</p>

# Design Specification: TRUST Tech Deliverable 4a. Enable user GitLab & Docker images
# Document Title

Your document content goes here...


**Revision History**
NA

**Prepared By**

| Name       | Project Role   | Signature | Date        |
| :--------- | :------------- | :-------- | :---------- |
| Amit Karpe | Lead Engineer  |           | 31 Jan 2025 |

**Reviewed By**

| Name          | Project Role | Signature | Date        |
| :------------ | :----------- | :-------- | :---------- |
| Yeo Zhen Xuan | Tech Lead    |           | 31 Jan 2025 |

**Approved By**

| Name       | Project Role            | Signature | Date        |
| :--------- | :---------------------- | :-------- | :---------- |
| Luke Lim   | Synapxe Project Manager |           | 31 Jan 2025 |
| Kevin Lam  | TRUST Business Lead     |           | 31 Jan 2025 |

---

## Table of Contents

1.  Introduction
    * 1.1 References
2.  Application Overview
    * 2.1 Layers or architectural framework
    * 2.2 Deployment View
    * 2.3 Development View
    * 2.4 Architectural Mechanisms
3.  Architecturally significant requirements
4.  Security
    * 4.1 System Security
    * 4.2 Data Security
    * 4.3 Application Security
5.  Common Modules: NA
6.  Functional Modules: NA
7.  Message / Service Interface: NA
8.  Database Design: NA
* Appendix A: NA

---

## 1. Introduction

### 1.1 References

* GovTech GCC Security Guidelines
* AWS Best Practices for Multi-Account Strategy

---

## 2. Application Overview

### 2.1 Layers or architectural framework

The solution follows a multi-account AWS architecture for hosting CloudOS and related infrastructure components:
* AWS Service Account: Hosts CloudOS and GitLab Server for private code repositories.
* AWS Workload Account: Hosts AWS Batch and AWS ECR for containerized workload execution.

### 2.2 Deployment View

* GitLab Server: Deployed in the AWS Service Account, configured for private access.
* AWS ECR: Deployed in the AWS Workload Account, accessible only within AWS GCC accounts.
* AWS Batch: Utilized for running containerized jobs, with required IAM permissions.

### 2.3 Development View

* GitLab provides private repository hosting for researchers and engineers.
* CI/CD workflows will be managed within GitLab to integrate with AWS Batch.
* AWS ECR will store and manage private container images for workloads.

### 2.4 Architectural Mechanisms

* Secure networking between AWS accounts using VPC peering or AWS PrivateLink.
* IAM roles and policies restricting access to only necessary resources.

---

## 3. Architecturally significant requirements

* Deployment in a non-internet environment within Singapore GCC.
* Secure and private access for all services.
* Multi-account strategy for isolation and compliance.

---

## 4. Security

### 4.1 System Security

* Network access controls enforced via Security Groups and VPC.
* AWS KMS for encrypting sensitive data and images.

### 4.2 Data Security

* No external data access permitted; all data resides within AWS GCC.
* Private container images stored in AWS ECR with strict access policies.

### 4.3 Application Security

* GitLab access restricted to authorized users only.
* IAM roles configured for least privilege access.

---

## 5. Common Modules

* NA

---

## 6. Functional Modules

* NA

---

## 7. Message / Service Interface

* NA

---

## 8. Database Design

* NA

---

## Appendix A

* NA