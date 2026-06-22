output "lambda_function_name" {
  value = aws_lambda_function.investigator.function_name
}

output "lambda_function_arn" {
  value = aws_lambda_function.investigator.arn
}

output "lambda_log_group_name" {
  value = aws_cloudwatch_log_group.lambda.name
}

output "eventbridge_target_id" {
  value = aws_cloudwatch_event_target.securityhub_to_lambda.target_id
}