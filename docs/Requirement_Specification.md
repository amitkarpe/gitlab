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
#number-sections: true      # Automatically number section headings (##, ###, etc.)
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
5.  Common Modules: 
6.  Functional Modules: 
7.  Message / Service Interface: 
8.  Database Design: 
9. Appendix A: 

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
