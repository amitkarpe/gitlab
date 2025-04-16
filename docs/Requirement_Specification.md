---
# === Document Metadata ===
subtitle: "Enable user GitLab & Docker images"
title: "Requirement Specification: "
author: "Amit Karpe, Lead Engineer"
#date: "April 15, 2025" # Or use "today" for auto-date, or specific date like "2024-11-30"
lang: en-SG # Language setting for localisation (if supported by LaTeX packages)
abstract: |  # Optional: A short summary if needed
  This document defines the requirement specifications for deploying code,
  container repositories, and related cloud infrastructure in a non-internet
  environment (Singapore GCC) for Lifebit CloudOS, focusing on enabling
  private GitLab and AWS ECR usage.

# === Table of Contents Settings ===
toc: true                  # Generate Table of Contents
toc-depth: 3               # How many heading levels to include in TOC (e.g., ### Headings)
#toc-title: "Contents"    # Optional: Custom title for the TOC page

# === PDF/LaTeX Output Settings (used by Pandoc with LaTeX engine) ===
documentclass: article      # Standard LaTeX document class (or report, book)
fontsize: 11pt             # Base font size (e.g., 10pt, 11pt, 12pt)
geometry: "top=1in, bottom=1in, left=1in, right=1in"

# linestretch: 1.5         # Optional: Adjust line spacing (requires setspace package)
# fontfamily: times        # Optional: Specify font family (e.g., times, helvet - requires relevant LaTeX packages)
# mainfont: "Times New Roman" # Example for XeLaTeX/LuaLaTeX font specification
# sansfont: "Arial"         # Example for XeLaTeX/LuaLaTeX font specification
# monofont: "Courier New"   # Example for XeLaTeX/LuaLaTeX font specification

# === Custom Variables for LaTeX Template ===
# These are only useful if your custom LaTeX template (`.tex` file) is set up to use them
# Example: Using `$if(header-text)$$header-text$$endif$` in the template
header-text: "RESTRICTED, SENSITIVE (NORMAL)"
footer-text: |
 SYNAPXE PTE LTD A wholly owned company of MOH Holdings Pte Ltd   Reg No. 200814464H
#  SYNAPXE PTE LTD \\quad A wholly owned company of MOH Holdings Pte Ltd \quad Reg No. 200814464H
logo-path: "synapxelogo.png" # Path to your logo file (relative or absolute)

# === Other Pandoc Options ===
number-sections: false # Automatically number section headings (##, ###, etc.)
# fig-caption: true        # Enable figure captions
# tbl-caption: true        # Enable table captions
# bibliography: references.bib # Optional: Path to bibliography file
# csl: style.csl             # Optional: Path to citation style file
---

```{=openxml}
<w:p>
  <w:r>
    <w:br w:type="page"/>
  </w:r>
</w:p>
```
```{=latex}
\newpage
```

**Prepared By**

| Name       | Project Role   | Signature | Date        |
| :--------- | :------------- | :-------- | :---------- |
| Amit Karpe | Lead Engineer  |           | 30 Nov 2024 |

**Reviewed By**

| Name       | Project Role   | Signature | Date        |
| :--------- | :------------- | :-------- | :---------- |
| Yeo Zhen Xuan | Tech Lead   |           | 30 Nov 2024 |

**Approved By**

| Name       | Project Role   | Signature | Date        |
| :--------- | :------------- | :-------- | :---------- |
| Luke Lim   | Synapxe Project Manager |    | 30 Nov 2024 |
| Kevin Lam  | TRUST Business Lead     |    | 30 Nov 2024 |


```{=openxml}
<w:p>
  <w:r>
    <w:br w:type="page"/>
  </w:r>
</w:p>
```
```{=latex}
\newpage
```

**Table of Contents**

1. INTRODUCTION
   - 1.1 Document Purpose
   - 1.2 System Overview
   - 1.3 Project Objectives / Goals
   - 1.4 Definitions/Glossary
   - 1.5 References
2. FUNCTIONAL SPECIFICATION OVERVIEW
   - 2.1 In-Scope
   - 2.2 Out-of-Scope
   - 2.3 Assumptions and Dependencies
   - 2.4 User Access
3. WORKFLOWS
   - 3.1 Existing or “As-Is” Process Workflow
   - 3.2 Proposed or “To-Be” Process Workflow
4. FUNCTIONAL REQUIREMENTS
   - 4.1 Statutory or Regulatory Requirements
     - 4.1.1 Personal Data Protection Act (PDPA)
   - 4.2 <Functional Requirement or Feature # 1>
     - 4.2.1 Graphical User Interface
     - 4.2.2 Data Flow
     - 4.2.3 Process Flow
     - 4.2.4 Business Validation
     - 4.2.5 Data Validation
     - 4.2.6 Reports/print-outs
   - 4.3 <Functional Requirement or Feature # 2>
     - 4.3.1 Graphical User Interface
     - 4.3.2 Data Flow
     - 4.3.3 Process Flow
     - 4.3.4 Business Validation
     - 4.3.5 Data Validation
     - 4.3.6 Reports/print-outs
5. DATA SETUP
   - 5.1 <Example 1 – Patient Race>
   - 5.2 <Example 2 – Relationship>
6. RECONCILIATION REPORTS
7. BATCH JOBS
8. AUDIT LOGGING
9. DATA MIGRATION REQUIREMENTS
10. INTERFACE REQUIREMENTS
11. PERFORMANCE REQUIREMENTS
   - 11.1 System Criticality & Availability
   - 11.2 Response Time
12. SUMMARY / RECOMMENDATIONS
APPENDIX A <DESCRIPTION>

---


```{=openxml}
<w:p>
  <w:r>
    <w:br w:type="page"/>
  </w:r>
</w:p>
```
```{=latex}
\newpage
```

### 1. INTRODUCTION

#### 1.1 Document Purpose

This document defines the requirement specifications for deploying code, container repositories, and related cloud infrastructure in a non-internet environment within Singapore Government on Commercial Cloud (GCC) by GovTech. The project aims to enable private repository hosting, pipeline execution, and container management for Lifebit CloudOS workflows.

#### 1.2 System Overview

**Tech Deliverable**  
4a. Enable Lifebit users to run their own codes  
- Phase 1 – Setup repositories (GitLab and AWS ECR) for hosting, accessing & managing private Docker tools & scripts/codes  
- Phase 2 – Setup to support hosting, accessing & managing NextFlow pipeline

**Problem Statement**  
Currently, there is no version control repository available within the TRUST-Lifebit platform where researchers can host their custom codes and pipelines.

**Outcome**  
CloudOS user can securely access and perform version control and collaborate with fellow researchers of their private codes, docker tools, and pipelines using Gitlab account and docker images using AWS ECR.

#### 1.3 Project Objectives / Goals

- Enable private code and container repository hosting within a closed cloud environment.
- Provide a scalable and secure solution for pipeline execution and container management.
- Ensure compliance with regulatory and security requirements.

#### 1.4 Definitions/Glossary

- **GitLab Server**: Self-hosted version of GitLab for code repository management.
- **AWS ECR**: Private container image repository for storing and managing Docker images.
- **AWS Batch**: Managed batch processing service for running containerized workloads.
- **CloudOS**: Lifebit’s cloud-native bioinformatics platform.

#### 1.5 References

- GovTech GCC Documentation
- AWS Security Best Practices

---

### 2. FUNCTIONAL SPECIFICATION OVERVIEW

#### 2.1 In-Scope

- Setup a self-hosted GitLab server within the CloudOS environment.
- Setup of AWS ECR in a separate AWS GCC account for private container storage.
- Integration of AWS Batch for executing workflows.

#### 2.2 Out-of-Scope

- External internet connectivity for GitLab or ECR.
- Support for third-party container registries.

#### 2.3 Assumptions and Dependencies

- AWS GCC accounts are pre-configured with necessary permissions.
- CloudOS is deployed and functional in a closed environment.

#### 2.4 User Access

Researchers and engineers will have access to GitLab for version control via Commandline.  
AWS ECR will be accessible only within AWS GCC accounts via private networking.

---

### 3. WORKFLOWS

#### Existing or “As-Is” Process Workflow

NA

#### Proposed or “To-Be” Process Workflow

NA

---

### 4. FUNCTIONAL REQUIREMENTS

#### 4.1 Statutory or Regulatory Requirements

NA

#### 4.2 <Functional Requirement or Feature # 1>

NA

#### 4.3 <Functional Requirement or Feature # 2>

NA

---

### 5. DATA SETUP

NA

---

### 6. RECONCILIATION REPORTS

NA

---

### 7. BATCH JOBS

NA

---

### 8. AUDIT LOGGING

NA

---

### 9. DATA MIGRATION REQUIREMENTS

NA

---

### 10. INTERFACE REQUIREMENTS

NA

---

### 11. PERFORMANCE REQUIREMENTS

NA

---

### 12. SUMMARY / RECOMMENDATIONS

NA

---
