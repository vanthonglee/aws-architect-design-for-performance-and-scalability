# Define the cloud provider
provider "aws" {
  access_key = "xxx"
  secret_key = "xxx"
  token = "xxx"
  region = "us-east-1"  # Replace with your desired AWS region
}

# Zip file into package
data "archive_file" "greet_lambda_zip" {
  type        = "zip"
  source_file = "greet_lambda.py"
  output_path = "${path.module}/greet_lambda.zip"
}

# Create a new Lambda function
resource "aws_lambda_function" "lambda_python_function" {
  filename      = data.archive_file.greet_lambda_zip.output_path
  function_name = "greet_lambda_function"
  role          = aws_iam_role.lambda_execution_role.arn
  handler       = "greet_lambda.lambda_handler"
  runtime       = "python3.9"

  environment {
    variables = {
      greeting = var.greeting
    }
  }
}

# Define the iam role for lambda function
resource "aws_iam_role" "lambda_execution_role" {
  name = "lambda_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

# Define the iam policy for the lambda function
resource "aws_iam_policy" "iam_policy_for_lambda_logging" {
 
 name         = "iam_policy_for_lambda_logging_for_lambda_execution_role"
 path         = "/"
 description  = "AWS IAM Policy for Lamda Logging Permission"
 policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": [
       "logs:CreateLogGroup",
       "logs:CreateLogStream",
       "logs:PutLogEvents"
     ],
     "Resource": "arn:aws:logs:*:*:*",
     "Effect": "Allow"
   }
 ]
}
EOF
}

# Attach IAM Policy of Lamda to IAM role of Lamda 
resource "aws_iam_role_policy_attachment" "attach_iam_policy_for_lambda_logging_to_lambda_execution_role" {
  role       = aws_iam_role.lambda_execution_role.name
  policy_arn = aws_iam_policy.iam_policy_for_lambda_logging.arn
}