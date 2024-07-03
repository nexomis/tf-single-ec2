variable "region" {
  description = "The AWS region to deploy to"
  type        = string
  default     = "eu-west-3"
}

variable "prefix" {
  description = "Prefix for names of resources"
  type        = string
}

variable "volume_size" {
  description = "Disk space"
  type        = number
  default = 100
}

variable "aws_profile" {
  description = "AWS CLI profile"
  type        = string
}

variable "instance_type" {
  description = "instance_type"
  type        = string
}

