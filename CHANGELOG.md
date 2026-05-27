# Changelog

All notable changes to this project will be documented in this file.
## [0.4.0]() (2025-12-12)

### Fix Bugs
* Move `create_kubernetes_namespace` out of `service` because it's a variables of `eks-service`

## [0.3.0]() (2025-12-12)

### Version Updating
* Increase `helm` version require for terraform, which may conflicts with other modules due to our modules are all `~> 3.0`.

## [0.2.0]() (2025-12-09)

### Refactoring

* Renamed `micronaut_env` variable to `environment`.

### Chore

* Updated Terraform required version to `>= 1.10`.

## [0.1.0]() (2025-12-09)

### Features

* Initial implementation of Service Bot module.
* Deploys Service Bot using Helm chart `spartan`.
* Configures EKS service with `c0x12c/eks-service/aws`.
* Sets up integrations for Slack, GitHub, Jenkins, and Atlassian.
* Supports external secrets and config maps.
