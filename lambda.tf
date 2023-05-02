resource "null_resource" "build_cat_api" {
  triggers = {
    cat_api_build = filemd5("${local.lambdas_path}/cat-api/package.json"),
    cat_api_build = filemd5("${local.lambdas_path}/cat-api/index.ts")
  }

  provisioner "local-exec" {
    working_dir = "${local.lambdas_path}/cat-api"
    command     = "npm run prebuild && npm run build"
  }
}

data "archive_file" "cat_api_artefact" {
  output_path = "files/cat-api-artefact.zip"
  type        = "zip"
  source_file = "${local.lambdas_path}/cat-api/dist/index.js"

  depends_on = [
    null_resource.build_cat_api
  ]
}

resource "aws_lambda_function" "cat_api" {
  function_name = "cat_api"
  handler       = "index.handler"
  role          = aws_iam_role.cat_api_lambda.arn
  runtime       = "nodejs16.x"

  filename         = data.archive_file.cat_api_artefact.output_path
  source_code_hash = data.archive_file.cat_api_artefact.output_base64sha256

  timeout     = 5
  memory_size = 128

  layers = [aws_lambda_layer_version.got.arn]

  tags = local.common_tags
}
