provider "aws" {
  region = var.region
}

data "aws_eks_cluster" "cluster" {
  name = var.cluster_name
}

data "aws_eks_cluster_auth" "cluster" {
  name = var.cluster_name
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.cluster.token
  }
}

module "service_bot_trunkbase" {
  source = "../../"

  cluster_name      = var.cluster_name
  eks_oidc_provider = var.eks_oidc_provider
  region            = var.region
  route53_zone_id   = var.route53_zone_id
  alb_dns           = var.alb_dns

  # Slack
  slack_signing_secret       = var.slack_signing_secret
  slack_bot_token            = var.slack_bot_token
  dev_slack_group            = var.dev_slack_group
  release_slack_channel_name = var.release_slack_channel_name
  release_slack_channel_id   = var.release_slack_channel_id

  # GitHub App
  github_app_id              = var.github_app_id
  github_app_installation_id = var.github_app_installation_id
  github_app_private_key     = var.github_app_private_key
  github_org_name            = var.github_org_name
  github_repo_base_url       = var.github_repo_base_url
  app_repo_list              = var.app_repo_list

  # Security
  jwt_refresh_secret = var.jwt_refresh_secret
}
