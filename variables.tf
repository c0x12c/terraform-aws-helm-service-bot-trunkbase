variable "http_client_log_level" {
  description = "HTTP client log level"
  type        = string
  default     = "INFO"
}

variable "spartan_chart_version" {
  description = "Version of the Spartan Helm chart to deploy"
  type        = string
  default     = "0.1.18"
}

variable "service_bot_image_repository" {
  description = "Docker image repository for service-bot-trunkbase"
  type        = string
  default     = "ghcr.io/spartan-stratos/service-bot-trunkbase"
}

variable "service_bot_image_tag" {
  description = "Docker image tag for service-bot-trunkbase"
  type        = string
  default     = "v0.1.0"
}

variable "service_resources" {
  description = "Kubernetes resource requests and limits for service-bot-trunkbase"
  type        = map(map(string))
  default = {
    requests = {
      cpu    = "200m"
      memory = "1Gi"
    }
    limits = {
      memory = "1Gi"
    }
  }
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "route53_zone_id" {
  description = "Route53 hosted zone ID"
  type        = string
}

variable "alb_dns" {
  description = "The DNS name of the ALB"
  type        = string
}

variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "eks_oidc_provider" {
  description = "The OIDC provider for the EKS cluster"
  type        = object({ arn = string, url = string })
}

variable "service_name" {
  description = "The name of the service (used as Kubernetes deployment/namespace name)"
  type        = string
  default     = "service-bot-trunkbase"
}

variable "environment" {
  description = "The Micronaut environment"
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

variable "namespace" {
  description = "The Kubernetes namespace to deploy the service into"
  type        = string
  default     = "service-bot-trunkbase"
}

variable "app_domain" {
  description = "The application domain"
  type        = string
  default     = "example.com"
}

# Bot general config
variable "bot_name" {
  description = "Display name used in bot messages"
  type        = string
  default     = "Service Bot"
}

variable "slash_command" {
  description = "Slack slash command name (without leading /)"
  type        = string
  default     = "bot"
}

variable "dev_slack_group" {
  description = "Slack user-group handle for dev-team access control"
  type        = string
}

variable "allowed_users" {
  description = "JSON array of allowed users, e.g. [{\"email\":\"...\",\"github\":\"...\"}]"
  type        = string
  default     = ""
}

variable "release_slack_channel_name" {
  description = "Slack channel name where slash commands are accepted"
  type        = string
}

variable "release_slack_channel_id" {
  description = "Slack channel ID where slash commands are accepted"
  type        = string
}

# GitHub App auth (replaces PAT-based auth)
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

variable "github_api_endpoint" {
  description = "GitHub API endpoint (override for GitHub Enterprise)"
  type        = string
  default     = "https://api.github.com"
}

variable "github_jwt_expiration_ms" {
  description = "GitHub App JWT expiration in milliseconds"
  type        = string
  default     = "540000"
}

# Repos
variable "app_repo_list" {
  description = "List of application repositories"
  type        = list(string)
}

variable "infra_repo_list" {
  description = "List of infrastructure repositories"
  type        = list(string)
  default     = []
}

# Branch names
variable "main_branch" {
  description = "Main branch name"
  type        = string
  default     = "master"
}

variable "develop_branch" {
  description = "Develop branch name"
  type        = string
  default     = "develop"
}

variable "staging_branch" {
  description = "Staging branch name"
  type        = string
  default     = "staging"
}

variable "prod_branch" {
  description = "Production branch name"
  type        = string
  default     = "production"
}

variable "manifest_file" {
  description = "Path to the version manifest file inside the repository"
  type        = string
  default     = "manifest.json"
}

# Scheduler
variable "schedule_enabled" {
  description = "Enable the hotfix-branch scan scheduler"
  type        = string
  default     = "false"
}

# Security
variable "jwt_refresh_secret" {
  description = "JWT refresh/signature secret (JWT_GENERATOR_REFRESH_SECRET)"
  type        = string
  sensitive   = true
}
