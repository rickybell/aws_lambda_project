// Resources
resource "aws_cognito_user_pool" "user_pool" {
  name = "cat-api-user-pool"

  username_attributes      = ["email"]
  auto_verified_attributes = ["email"]
  password_policy {
    minimum_length    = 8
    require_lowercase = true
    require_numbers   = true
    require_symbols   = true
    require_uppercase = true
  }

  verification_message_template {
    default_email_option = "CONFIRM_WITH_CODE"
    email_subject        = "Confirmação da sua inscrição"
    email_message        = "Seu codigo de confirmacao eh: {####}"
  }

  schema {
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = true
    name                     = "email"
    required                 = true

    string_attribute_constraints {
      min_length = 1
      max_length = 256
    }
  }
}

resource "aws_cognito_user_pool_client" "client" {
  name = "cat-api-client"

  user_pool_id                  = aws_cognito_user_pool.user_pool.id
  generate_secret               = false
  refresh_token_validity        = 90
  prevent_user_existence_errors = "ENABLED"
  allowed_oauth_flows = [
    "implicit",
    "code"
  ]
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_scopes = [
    "email",
    "openid"
  ]
  callback_urls = [
    "https://example.com/callback"
  ]
  logout_urls = [
    "https://example.com/signout"
  ]
  supported_identity_providers = [
    "COGNITO"
  ]
  explicit_auth_flows = [
    "ALLOW_USER_SRP_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH",
    "ALLOW_CUSTOM_AUTH",
    "ALLOW_USER_PASSWORD_AUTH"
  ]

}

resource "aws_cognito_user_pool_domain" "cognito-domain" {
  domain       = "cat-api-user-pool"
  user_pool_id = aws_cognito_user_pool.user_pool.id
}


