# Define the output variable for the lambda function.
output "iam_for_lambda_arn" {
  value = aws_iam_role.lambda_execution_role.arn
}