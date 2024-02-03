variable "name" {
  description = "The name of the new Permission Set to create"
  type        = string
}

variable "sso_instance" {
  description = "The ARN of the SSO instance we are managing"
  type        = string
}

variable "idstore" {
  description = "The SSO Identity Store, used for group lookups"
  type        = string
}

variable "session_duration" {
  description = "The duration that sessions are valid for"
  type        = string
  default     = "PT1H"
}

variable "policies" {
  description = "The list of managed policies to attach to the Permission Set"
  type        = list(string)
}

variable "accounts" {
  description = "The list of AWS accounts to grant access to"
  type        = list(string)
}

variable "groups" {
  description = "The list of AWS groups to attach the Permission Set to"
  type        = list(string)
}

variable "tags" {
  description = "The tags that should be applied to the resource"
  type        = map(string)
  default     = {}
}