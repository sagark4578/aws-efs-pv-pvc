variable "environment" {
  type    = string
  default = "dev"
}

variable "org_name" {
  type    = string
  default = "bhuman"
}

variable "remote_state_bucket" {
  type = string
}

variable "remote_state_region" {
  type = string
}

variable "aws_region" {
  type = string
}
