variable "region" {
  description = "AWS Region to deploy the resources."
  type        = string
  default     = "ap-southeast-1"
}

variable "instance_type" {
  description = "EC2 instance type."
  type        = string
  default     = "t4g.small"
}

variable "key_pair_name" {
  description = "Key pair for SSH access."
  type        = string
}

variable "valheim_server_name" {
  description = "Name of the Valheim server."
  type        = string
  default     = "ValheimServer"
}

variable "server_password" {
  description = "Password for the Valheim server."
  type        = string
  default     = "iloveaaron"
}

variable "world_name" {
  description = "World name for the Valheim server."
  type        = string
  default     = "ValheimWorld"
}

variable "backup_s3_bucket" {
  description = "S3 bucket name for backups."
  type        = string
}