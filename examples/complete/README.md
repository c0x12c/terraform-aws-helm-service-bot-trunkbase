# Complete Example

This example demonstrates how to use the `terraform-aws-helm-service-bot-trunkbase` module to deploy service-bot-trunkbase on an existing EKS cluster.

## Usage

Create a `terraform.tfvars` file with the required values then:

```bash
terraform init
terraform apply
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 3.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_service_bot_trunkbase"></a> [service\_bot\_trunkbase](#module\_service\_bot\_trunkbase) | ../../ | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alb_dns"></a> [alb\_dns](#input\_alb\_dns) | The DNS name of the ALB | `string` | n/a | yes |
| <a name="input_app_repo_list"></a> [app\_repo\_list](#input\_app\_repo\_list) | List of application repositories | `list(string)` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | The name of the EKS cluster | `string` | n/a | yes |
| <a name="input_dev_slack_group"></a> [dev\_slack\_group](#input\_dev\_slack\_group) | Slack user-group handle for dev-team access control | `string` | n/a | yes |
| <a name="input_eks_oidc_provider"></a> [eks\_oidc\_provider](#input\_eks\_oidc\_provider) | The OIDC provider for the EKS cluster | `object({ arn = string, url = string })` | n/a | yes |
| <a name="input_github_app_id"></a> [github\_app\_id](#input\_github\_app\_id) | GitHub App ID | `string` | n/a | yes |
| <a name="input_github_app_installation_id"></a> [github\_app\_installation\_id](#input\_github\_app\_installation\_id) | GitHub App installation ID | `string` | n/a | yes |
| <a name="input_github_app_private_key"></a> [github\_app\_private\_key](#input\_github\_app\_private\_key) | Base64-encoded RSA private key for the GitHub App | `string` | n/a | yes |
| <a name="input_github_org_name"></a> [github\_org\_name](#input\_github\_org\_name) | GitHub organisation name | `string` | n/a | yes |
| <a name="input_github_repo_base_url"></a> [github\_repo\_base\_url](#input\_github\_repo\_base\_url) | Base URL for GitHub repositories | `string` | n/a | yes |
| <a name="input_jwt_refresh_secret"></a> [jwt\_refresh\_secret](#input\_jwt\_refresh\_secret) | JWT refresh/signature secret | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | `"us-east-1"` | no |
| <a name="input_release_slack_channel_id"></a> [release\_slack\_channel\_id](#input\_release\_slack\_channel\_id) | Slack channel ID where slash commands are accepted | `string` | n/a | yes |
| <a name="input_release_slack_channel_name"></a> [release\_slack\_channel\_name](#input\_release\_slack\_channel\_name) | Slack channel name where slash commands are accepted | `string` | n/a | yes |
| <a name="input_route53_zone_id"></a> [route53\_zone\_id](#input\_route53\_zone\_id) | Route53 hosted zone ID | `string` | n/a | yes |
| <a name="input_slack_bot_token"></a> [slack\_bot\_token](#input\_slack\_bot\_token) | Slack bot token | `string` | n/a | yes |
| <a name="input_slack_signing_secret"></a> [slack\_signing\_secret](#input\_slack\_signing\_secret) | Slack signing secret | `string` | n/a | yes |
