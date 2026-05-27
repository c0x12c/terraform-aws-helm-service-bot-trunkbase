module "eks_service" {
  source  = "c0x12c/eks-service/aws"
  version = "0.2.8"

  cluster_name      = var.cluster_name
  eks_oidc_provider = var.eks_oidc_provider

  region          = var.region
  route53_zone_id = var.route53_zone_id

  alb_dns = var.alb_dns
  service = {
    name      = var.service_name
    namespace = var.namespace
    hostnames = [var.app_domain]

    config_map = {
      MICRONAUT_ENVIRONMENTS = var.environment
      HTTP_CLIENT_LOG_LEVEL  = var.http_client_log_level
      APP_DOMAIN             = var.app_domain

      # Bot identity
      BOT_NAME      = var.bot_name
      SLASH_COMMAND = var.slash_command

      # Slack access control
      DEV_SLACK_GROUP            = var.dev_slack_group
      ALLOWED_USERS              = var.allowed_users
      RELEASE_SLACK_CHANNEL_NAME = var.release_slack_channel_name
      RELEASE_SLACK_CHANNEL_ID   = var.release_slack_channel_id

      # Repositories
      APP_REPO_LIST   = join(",", var.app_repo_list)
      INFRA_REPO_LIST = join(",", var.infra_repo_list)

      # Branch strategy
      MAIN_BRANCH    = var.main_branch
      DEVELOP_BRANCH = var.develop_branch
      STAGING_BRANCH = var.staging_branch
      PROD_BRANCH    = var.prod_branch
      MANIFEST_FILE  = var.manifest_file

      # Scheduler
      SCHEDULE_ENABLED = var.schedule_enabled

      # GitHub
      GITHUB_ORG_NAME          = var.github_org_name
      GITHUB_REPO_BASE_URL     = var.github_repo_base_url
      GITHUB_API_ENDPOINT      = var.github_api_endpoint
      GITHUB_JWT_EXPIRATION_MS = var.github_jwt_expiration_ms
    }

    secrets = {
      # Slack
      SLACK_SIGNING_SECRET = var.slack_signing_secret
      SLACK_BOT_TOKEN      = var.slack_bot_token

      # GitHub App auth
      GITHUB_APP_ID              = var.github_app_id
      GITHUB_APP_INSTALLATION_ID = var.github_app_installation_id
      GITHUB_APP_PRIVATE_KEY     = var.github_app_private_key

      # JWT
      JWT_GENERATOR_REFRESH_SECRET = var.jwt_refresh_secret
    }

    create_service_account = true

    service_account_name = var.service_name
  }
  create_kubernetes_namespace = true
}

resource "helm_release" "service_bot_trunkbase" {
  name       = var.service_name
  repository = "https://spartan-stratos.github.io/helm-charts"
  chart      = "spartan"
  namespace  = var.namespace
  version    = var.spartan_chart_version

  depends_on = [module.eks_service]

  values = [
    yamlencode({
      replicaCount = 1
      image = {
        repository = var.service_bot_image_repository
        tag        = var.service_bot_image_tag
      }

      fullnameOverride = var.service_name
      containerName    = var.service_name
      appNameLabel     = var.service_name

      serviceAccount = {
        create = false
        name   = var.service_name
      }

      ingress = {
        enabled   = true
        className = "alb"
        annotations = {
          "alb.ingress.kubernetes.io/scheme"           = "internet-facing"
          "alb.ingress.kubernetes.io/group.name"       = "external"
          "kubernetes.io/ingress.class"                = "alb"
          "alb.ingress.kubernetes.io/target-type"      = "ip"
          "alb.ingress.kubernetes.io/healthcheck-path" = "/health"
          "alb.ingress.kubernetes.io/listen-ports"     = jsonencode([{ HTTP = 80 }, { HTTPS = 443 }])
        }

        hosts = [
          {
            host = var.app_domain
            paths = [
              {
                path     = "/*"
                pathType = "ImplementationSpecific"
              }
            ]
          }
        ]
      }

      resources = var.service_resources

      livenessProbe = {
        httpGet = {
          path = "/health"
          port = 8080
        }
      }
      readinessProbe = {
        httpGet = {
          path = "/health"
          port = 8080
        }
      }

      autoscaling = {
        enabled = false
      }

      configMap = {
        externalConfigMapEnv = {
          enabled = true
          name    = "${var.service_name}-config-map"
        }
      }

      secret = {
        externalSecretEnv = {
          enabled = true
          name    = "${var.service_name}-env-var"
        }
      }

      extraEnvs = [
        {
          name  = "ENVIRONMENT"
          value = var.environment
        }
      ]
    })
  ]
}
