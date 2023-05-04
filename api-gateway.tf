resource "aws_api_gateway_rest_api" "rest_api_lambda_cat_api" {
  name        = "${local.STAGE}-test-lambda"
  description = "Terraform Serverless Application Example"
  tags = {
    STAGE = "${local.STAGE}"
  }
}

resource "aws_api_gateway_resource" "proxy_resource_cat_api" {
  rest_api_id = aws_api_gateway_rest_api.rest_api_lambda_cat_api.id
  parent_id   = aws_api_gateway_rest_api.rest_api_lambda_cat_api.root_resource_id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "proxy_method_cat_api" {
  rest_api_id   = aws_api_gateway_rest_api.rest_api_lambda_cat_api.id
  resource_id   = aws_api_gateway_resource.proxy_resource_cat_api.id
  http_method   = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "integration_lambda_cat_api" {
  rest_api_id = aws_api_gateway_rest_api.rest_api_lambda_cat_api.id
  resource_id = aws_api_gateway_method.proxy_method_cat_api.resource_id
  http_method = aws_api_gateway_method.proxy_method_cat_api.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.cat_api.invoke_arn
}

resource "aws_api_gateway_method" "proxy_root_method_cat_api" {
  rest_api_id   = aws_api_gateway_rest_api.rest_api_lambda_cat_api.id
  resource_id   = aws_api_gateway_rest_api.rest_api_lambda_cat_api.root_resource_id
  http_method   = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "integration_root_lambda_cat_api" {
  rest_api_id = aws_api_gateway_rest_api.rest_api_lambda_cat_api.id
  resource_id = aws_api_gateway_method.proxy_root_method_cat_api.resource_id
  http_method = aws_api_gateway_method.proxy_root_method_cat_api.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.cat_api.invoke_arn
}

resource "aws_api_gateway_deployment" "deployment_lambda_cat_api" {
  depends_on = [
    aws_api_gateway_integration.integration_lambda_cat_api,
    aws_api_gateway_integration.integration_root_lambda_cat_api,
  ]

  rest_api_id = aws_api_gateway_rest_api.rest_api_lambda_cat_api.id
  stage_name  = "test"
}







# resource "aws_lambda_permission" "test_lambda_cat_api_gateway_permission" {
#   function_name = "cat_api"
#   principal     = "apigateway.amazonaws.com"
#   action        = "lambda:InvokeFunction"
#   source_arn    = "${aws_api_gateway_rest_api.test_lambda_cat_api.execution_arn}/*/*"

#   depends_on = [aws_lambda_function.cat_api]
# }

# resource "aws_api_gateway_resource" "test_cat_api_event_resource" {
#   rest_api_id = aws_api_gateway_rest_api.test_lambda_cat_api.id
#   parent_id   = aws_api_gateway_rest_api.test_lambda_cat_api.root_resource_id
#   path_part   = "event"
# }

# resource "aws_api_gateway_resource" "test_cat_api_event_push_resource" {
#   rest_api_id = aws_api_gateway_rest_api.test_lambda_cat_api.id
#   parent_id   = aws_api_gateway_resource.test_cat_api_event_resource.id
#   path_part   = "push"
# }

# resource "aws_api_gateway_method" "test_cat_api_event_push_method" {
#   rest_api_id   = aws_api_gateway_rest_api.test_lambda_cat_api.id
#   resource_id   = aws_api_gateway_resource.test_cat_api_event_push_resource.id
#   http_method   = "POST"
#   authorization = "NONE"
# }

# resource "aws_api_gateway_integration" "test_cat_api_lambda_integration" {
#   rest_api_id             = aws_api_gateway_rest_api.test_lambda_cat_api.id
#   resource_id             = aws_api_gateway_resource.test_cat_api_event_push_resource.id
#   http_method             = aws_api_gateway_method.test_cat_api_event_push_method.http_method
#   integration_http_method = "POST"
#   type                    = "AWS_PROXY"
#   uri                     = aws_lambda_function.cat_api.invoke_arn
# }

# resource "aws_api_gateway_deployment" "test_cat_api_deployment" {
#   rest_api_id = aws_api_gateway_rest_api.test_lambda_cat_api.id
#   stage_name  = local.STAGE

#   depends_on = [aws_api_gateway_integration.test_cat_api_lambda_integration]
# }
