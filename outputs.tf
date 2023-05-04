output "layers" {
  value = [{
    got = {
      arn         = aws_lambda_layer_version.got.arn
      name        = aws_lambda_layer_version.got.layer_name
      description = aws_lambda_layer_version.got.description
      created_at  = aws_lambda_layer_version.got.created_date
    }
  }]
}

output "lambdas" {
  value = [{
    arn           = aws_lambda_function.cat_api.arn
    name          = aws_lambda_function.cat_api.function_name
    description   = aws_lambda_function.cat_api.description
    version       = aws_lambda_function.cat_api.version
    last_modified = aws_lambda_function.cat_api.last_modified
  }]
}

output "base_url" {
  value = aws_api_gateway_deployment.deployment_lambda_cat_api.invoke_url
}
