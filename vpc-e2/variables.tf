variable "region" {
  description = "AWS region"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

# provider "aws" {
#   region = var.region
# }

variable "access_key" {
  type = string
}
variable "secret_key" {
  type = string
}

