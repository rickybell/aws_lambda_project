locals {
  lambdas_path = "${path.module}/lambdas"
  layers_path  = "${path.module}/layers"
  STAGE        = "develop"

  common_tags = {
    Project   = "Lambda Layers with Terraform"
    CreatedAt = formatdate("YYYY-MM-DD", timestamp())
    ManageBy  = "Terraform"
    Owner     = "Ricky Bell"
  }
}
