# Git Flow with Hotfix – Azure DevOps CI/CD Pipeline to AKS (Enterprise POC)

This repository contains the complete live POC codebase implementing the enterprise architecture:

## Components Included
- **Express.js API (`src/index.js`)**: Working microservice with readiness (`/ready`) & health (`/healthz`) endpoints.
- **Docker Containerization (`Dockerfile`)**: Optimized multi-stage node container.
- **Terraform Infrastructure (`terraform/`)**: Modules for VNet, ACR, Key Vault, and AKS (Dev/QA/Prod).
- **Helm Packaging (`helm/app-chart/`)**: Production-ready Helm chart supporting Blue/Green deployment slots.
- **DevSecOps Security (`.azuredevops/`, `k8s/policies/`)**:
  - Trivy Container Vulnerability Scan
  - Cosign Container Signing using Azure Key Vault KMS
  - Kyverno Admission Control Policy enforcing signed images on AKS.
- **Git Flow Branching Strategy**: Fully configured multi-stage CI/CD pipelines for `develop`, `release/*`, `main`, and `hotfix/*`.
