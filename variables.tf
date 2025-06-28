variable "aws_access_key" {
  type        = string
  description = "AWS Access Key"
}

variable "aws_secret_key" {
  type        = string
  description = "AWS Secret Key"
}

variable "region" {
  type        = string
  default     = "eu-central-1"
  description = "AWS Region"
}

variable "from_address" {
  type        = string
  description = "Email address from which the verification code is sent from"
}
