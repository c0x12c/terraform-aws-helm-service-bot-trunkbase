> **ARCHIVED — deprecated.** This module is no longer maintained and is not part of [`c0x12c/terraform-modules`](https://github.com/c0x12c/terraform-modules).

# Terraform AWS Helm Service Bot Trunkbase

This Terraform module deploys `service-bot-trunkbase` on AWS EKS using Helm. It integrates with Slack and GitHub (via GitHub App authentication) to automate release workflows — cut-off branches, create tags, hotfixes, and deployment notifications.

The module handles:
*   Deploying the service-bot-trunkbase application using the `spartan` Helm chart.
*   Configuring Kubernetes resources (ServiceAccount, Ingress, ConfigMaps, Secrets, RBAC).
*   Setting up environment variables for Slack and GitHub App integrations.

## Usage

```hcl
module "service_bot_trunkbase" {
  source  = "c0x12c/helm-service-bot-trunkbase/aws"
  version = "0.1.0"

  cluster_name      = "my-eks-cluster"
  eks_oidc_provider = {
    arn = "arn:aws:iam::123456789012:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/EXAMPLE"
    url = "https://oidc.eks.us-east-1.amazonaws.com/id/EXAMPLE"
  }
  region          = "us-east-1"
  route53_zone_id = "Z0123456789ABCDEF"
  alb_dns         = "my-alb.us-east-1.elb.amazonaws.com"
  environment     = "dev"

  # Slack
  slack_signing_secret       = var.slack_signing_secret
  slack_bot_token            = var.slack_bot_token
  dev_slack_group            = "dev-team"
  release_slack_channel_name = "prj-myapp-release"
  release_slack_channel_id   = "C0XXXXXXXXX"

  # GitHub App
  github_app_id               = var.github_app_id
  github_app_installation_id  = var.github_app_installation_id
  github_app_private_key      = var.github_app_private_key
  github_org_name             = "my-org"
  github_repo_base_url        = "https://github.com/my-org"
  app_repo_list               = ["app-service", "frontend"]

  # Security
  jwt_refresh_secret = var.jwt_refresh_secret
}
```

## Examples

Refer to the [complete example](examples/complete) for a full implementation including provider configuration.


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | ~> 3 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | ~> 3 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | ~> 2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_eks_service"></a> [eks\_service](#module\_eks\_service) | c0x12c/eks-service/aws | 0.2.8 |

## Resources

| Name | Type |
|------|------|
| [helm_release.service_bot_trunkbase](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_cluster_role_binding_v1.service_bot_trunkbase](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role_binding_v1) | resource |
| [kubernetes_cluster_role_v1.service_bot_trunkbase](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role_v1) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alb_dns"></a> [alb\_dns](#input\_alb\_dns) | The DNS name of the ALB | `string` | n/a | yes |
| <a name="input_allowed_users"></a> [allowed\_users](#input\_allowed\_users) | JSON array of allowed users, e.g. `[{"email":"...","github":"..."}]` | `string` | `""` | no |
| <a name="input_app_domain"></a> [app\_domain](#input\_app\_domain) | The application domain | `string` | `"example.com"` | no |
| <a name="input_app_repo_list"></a> [app\_repo\_list](#input\_app\_repo\_list) | List of application repositories | `list(string)` | n/a | yes |
| <a name="input_bot_name"></a> [bot\_name](#input\_bot\_name) | Display name used in bot messages | `string` | `"Service Bot"` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | The name of the EKS cluster | `string` | n/a | yes |
| <a name="input_dev_slack_group"></a> [dev\_slack\_group](#input\_dev\_slack\_group) | Slack user-group handle for dev-team access control | `string` | n/a | yes |
| <a name="input_develop_branch"></a> [develop\_branch](#input\_develop\_branch) | Develop branch name | `string` | `"develop"` | no |
| <a name="input_eks_oidc_provider"></a> [eks\_oidc\_provider](#input\_eks\_oidc\_provider) | The OIDC provider for the EKS cluster | `object({ arn = string, url = string })` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The Micronaut environment | `string` | n/a | yes |
| <a name="input_github_api_endpoint"></a> [github\_api\_endpoint](#input\_github\_api\_endpoint) | GitHub API endpoint (override for GitHub Enterprise) | `string` | `"https://api.github.com"` | no |
| <a name="input_github_app_id"></a> [github\_app\_id](#input\_github\_app\_id) | GitHub App ID | `string` | n/a | yes |
| <a name="input_github_app_installation_id"></a> [github\_app\_installation\_id](#input\_github\_app\_installation\_id) | GitHub App installation ID | `string` | n/a | yes |
| <a name="input_github_app_private_key"></a> [github\_app\_private\_key](#input\_github\_app\_private\_key) | Base64-encoded RSA private key for the GitHub App | `string` | n/a | yes |
| <a name="input_github_jwt_expiration_ms"></a> [github\_jwt\_expiration\_ms](#input\_github\_jwt\_expiration\_ms) | GitHub App JWT expiration in milliseconds | `string` | `"540000"` | no |
| <a name="input_github_org_name"></a> [github\_org\_name](#input\_github\_org\_name) | GitHub organisation name | `string` | n/a | yes |
| <a name="input_github_repo_base_url"></a> [github\_repo\_base\_url](#input\_github\_repo\_base\_url) | Base URL for GitHub repositories, e.g. https://github.com/my-org | `string` | n/a | yes |
| <a name="input_http_client_log_level"></a> [http\_client\_log\_level](#input\_http\_client\_log\_level) | HTTP client log level | `string` | `"INFO"` | no |
| <a name="input_infra_repo_list"></a> [infra\_repo\_list](#input\_infra\_repo\_list) | List of infrastructure repositories | `list(string)` | `[]` | no |
| <a name="input_jwt_refresh_secret"></a> [jwt\_refresh\_secret](#input\_jwt\_refresh\_secret) | JWT refresh/signature secret (JWT\_GENERATOR\_REFRESH\_SECRET) | `string` | n/a | yes |
| <a name="input_main_branch"></a> [main\_branch](#input\_main\_branch) | Main branch name | `string` | `"master"` | no |
| <a name="input_manifest_file"></a> [manifest\_file](#input\_manifest\_file) | Path to the version manifest file inside the repository | `string` | `"manifest.json"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The Kubernetes namespace to deploy the service into | `string` | `"service-bot-trunkbase"` | no |
| <a name="input_prod_branch"></a> [prod\_branch](#input\_prod\_branch) | Production branch name | `string` | `"production"` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | n/a | yes |
| <a name="input_release_slack_channel_id"></a> [release\_slack\_channel\_id](#input\_release\_slack\_channel\_id) | Slack channel ID where slash commands are accepted | `string` | n/a | yes |
| <a name="input_release_slack_channel_name"></a> [release\_slack\_channel\_name](#input\_release\_slack\_channel\_name) | Slack channel name where slash commands are accepted | `string` | n/a | yes |
| <a name="input_route53_zone_id"></a> [route53\_zone\_id](#input\_route53\_zone\_id) | Route53 hosted zone ID | `string` | n/a | yes |
| <a name="input_schedule_enabled"></a> [schedule\_enabled](#input\_schedule\_enabled) | Enable the hotfix-branch scan scheduler | `string` | `"false"` | no |
| <a name="input_service_bot_image_repository"></a> [service\_bot\_image\_repository](#input\_service\_bot\_image\_repository) | Docker image repository for service-bot-trunkbase | `string` | `"ghcr.io/spartan-stratos/service-bot-trunkbase"` | no |
| <a name="input_service_bot_image_tag"></a> [service\_bot\_image\_tag](#input\_service\_bot\_image\_tag) | Docker image tag for service-bot-trunkbase | `string` | `"v0.1.0"` | no |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | The name of the service (used as Kubernetes deployment/namespace name) | `string` | `"service-bot-trunkbase"` | no |
| <a name="input_service_resources"></a> [service\_resources](#input\_service\_resources) | Kubernetes resource requests and limits for service-bot-trunkbase | `map(map(string))` | <pre>{<br/>  "limits": {<br/>    "memory": "1Gi"<br/>  },<br/>  "requests": {<br/>    "cpu": "200m",<br/>    "memory": "1Gi"<br/>  }<br/>}</pre> | no |
| <a name="input_slack_bot_token"></a> [slack\_bot\_token](#input\_slack\_bot\_token) | Slack bot token | `string` | n/a | yes |
| <a name="input_slack_signing_secret"></a> [slack\_signing\_secret](#input\_slack\_signing\_secret) | Slack signing secret | `string` | n/a | yes |
| <a name="input_slash_command"></a> [slash\_command](#input\_slash\_command) | Slack slash command name (without leading /) | `string` | `"bot"` | no |
| <a name="input_spartan_chart_version"></a> [spartan\_chart\_version](#input\_spartan\_chart\_version) | Version of the Spartan Helm chart to deploy | `string` | `"0.1.18"` | no |
| <a name="input_staging_branch"></a> [staging\_branch](#input\_staging\_branch) | Staging branch name | `string` | `"staging"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
