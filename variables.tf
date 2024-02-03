variable "name" {
  description = "The name you want to give to resources created"
  type        = string
  default     = ""
}

variable "account_id" {
  description = "The 12 digit AWS account ID to deploy resources to"
  type        = string
  default     = ""
}

variable "region" {
  description = "The AWS region where resources should be deployed"
  type        = string
  default     = "us-west-2"
}

# Make sure to set the correct regex pattern in data.tf for your role!!!
variable "sso_enabled" {
  description = "Flag for whether or not to look up SSO role for bucket and key access"
  type        = bool
  default     = true
}