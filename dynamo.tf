resource "aws_dynamodb_table" "confirmation_table" {
  name         = "ConfirmationCodes"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "email"

  attribute {
    name = "email"
    type = "S"
  }

  ttl {
    attribute_name = "expires_at"
    enabled        = true
  }

  tags = {
    application = "csync"
  }
}
