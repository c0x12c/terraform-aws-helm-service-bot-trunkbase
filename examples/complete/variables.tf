variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "eks_oidc_provider" {
  description = "The OIDC provider for the EKS cluster"
  type        = object({ arn = string, url = string })
}

variable "route53_zone_id" {
  description = "Route53 hosted zone ID"
  type        = string
}

variable "alb_dns" {
  description = "The DNS name of the ALB"
  type        = string
}

# Slack
variable "slack_signing_secret" {
  description = "Slack signing secret"
  type        = string
  sensitive   = true
}

variable "slack_bot_token" {
  description = "Slack bot token"
  type        = string
  sensitive   = true
}

variable "dev_slack_group" {
  description = "Slack user-group handle for dev-team access control"
  type        = string
}

variable "release_slack_channel_name" {
  description = "Slack channel name where slash commands are accepted"
  type        = string
}

variable "release_slack_channel_id" {
  description = "Slack channel ID where slash commands are accepted"
  type        = string
}

# GitHub App
variable "github_app_id" {
  description = "GitHub App ID"
  type        = string
  sensitive   = true
}

variable "github_app_installation_id" {
  description = "GitHub App installation ID"
  type        = string
  sensitive   = true
}

variable "github_app_private_key" {
  description = "Base64-encoded RSA private key for the GitHub App"
  type        = string
  sensitive   = true
}

variable "github_org_name" {
  description = "GitHub organisation name"
  type        = string
}

variable "github_repo_base_url" {
  description = "Base URL for GitHub repositories, e.g. https://github.com/my-org"
  type        = string
}

variable "app_repo_list" {
  description = "List of application repositories"
  type        = list(string)
}

# Security
variable "jwt_refresh_secret" {
  description = "JWT refresh/signature secret"
  type        = string
  sensitive   = true
}
