output "greet_lambda_lambda_function_qualified_arn" {
  description = "The ARN identifying your Lambda Function Version"
  value       = element(concat(aws_lambda_function.greet_lambda.*.qualified_arn, [""]), 0)
}
