variable "region" {
  description = "AWS Region to deploy the resources."
  type        = string
  default     = "ap-southeast-1"
}

variable "availability_zone" {
  description = "AWS Availability Zone to deploy the resources."
  type        = string
  default     = "ap-southeast-1b"
}

variable "instance_type" {
  description = "EC2 instance type."
  type        = string
  default     = "t3a.medium"
}

variable "valheim_server_name" {
  description = "Name of the Valheim server."
  type        = string
  default     = "ValheimServer"
}

variable "backup_s3_bucket" {
  description = "S3 bucket name for backups."
  type        = string
  default     = "terraform-valheim-llanuza-v1"
}
