provider "aws" {
  region = var.aws_region
}

data "archive_file" "zip"{
    type = "zip"
    output_path = "${path.module}/greet_lambda.zip"
    source_dir = "${path.module}/app"
} 

resource "aws_lambda_function" "greet_lambda" {
  function_name    = "greet_lambda"
  filename         = "greet_lambda.zip"
  handler          = "greet_lambda.lambda_handler"
  source_code_hash = "file(${data.archive_file.zip.output_path})"
  role             = "${aws_iam_role.greet_lambda.arn}"
  runtime          = "python3.8"
  memory_size      = 128
  timeout          = 1
}

#  source_code_hash = "${base64sha256(file("${data.archive_file.zip.output_path}"))}"
# A Lambda function may access to other AWS resources such as S3 bucket. So an
# IAM role needs to be defined. This hello world example does not access to
# any resource, so the role is empty.
#
# The date 2012-10-17 is just the version of the policy language used here [1].
#
# [1]: https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_elements_version.html
resource "aws_iam_role" "greet_lambda" {
  name               = "greet_lambda_role"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": {
    "Action": "sts:AssumeRole",
    "Principal": {
      "Service": "lambda.amazonaws.com"
    },
    "Effect": "Allow"
  }
}
POLICY
}

# Add base Lambda Execution policy
resource "aws_iam_role_policy" "lambda_cloudwatch_logs_polcy" {
  name   = "lambda-${aws_lambda_function.greet_lambda.function_name}-policy"
  role   = aws_iam_role.greet_lambda.id
  policy = data.aws_iam_policy_document.lambda_cloudwatch_logs_policy.json
}

# JSON POLICY - base Lambda Execution policy
data "aws_iam_policy_document" "lambda_cloudwatch_logs_policy" {
  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:CreateLogGroup",
      "logs:PutLogEvents",
    ]

    resources = ["*"]
  }
}

resource "aws_cloudwatch_log_group" "lambda" {
  name              = "/aws/lambda/${aws_lambda_function.greet_lambda.function_name}"
  retention_in_days = 7

}