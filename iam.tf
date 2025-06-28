resource "aws_iam_role" "lambda_exec_role" {
  name = "CSyncVerifyLambdaRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })

  tags = {
    application = "csync"
  }
}

resource "aws_iam_role_policy" "lambda_dynamo_policy" {
  name = "LambdaDynamoPolicy"
  role = aws_iam_role.lambda_exec_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "dynamodb:PutItem"
        ],
        Effect   = "Allow",
        Resource = aws_dynamodb_table.confirmation_table.arn
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_basic_exec_policy_attachment" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy" "lambda_ses_send_policy" {
  name = "LambdaSESSendPolicy"
  role = aws_iam_role.lambda_exec_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid      = "AllowSESSendFromVerifiedIdentity",
        Effect   = "Allow",
        Action   = "ses:SendEmail",
        Resource = "arn:aws:ses:${var.region}:${data.aws_caller_identity.current.account_id}:identity/*"
        Condition : {
          "StringEquals" : {
            "ses:FromAddress" : var.from_address
          }
        }
      }
    ]
  })
}
