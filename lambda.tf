resource "aws_lambda_function" "csync_verify" {
  function_name = "CSyncVerify"
  role          = aws_iam_role.lambda_exec_role.arn
  handler       = "PLACEHOLDER"
  runtime       = "nodejs22.x"
  filename      = "PLACEHOLDER.zip"
  lifecycle {
    ignore_changes = all
  }
}
