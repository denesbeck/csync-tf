resource "aws_sqs_queue" "registration_queue" {
  name = "csync_registration_queue"

  tags = {
    application = "csync"
  }
}

resource "aws_lambda_event_source_mapping" "sqs_to_lambda" {
  event_source_arn = aws_sqs_queue.registration_queue.arn
  function_name    = aws_lambda_function.csync_verify.arn
  enabled          = true
  batch_size       = 1
}
