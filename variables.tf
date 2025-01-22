variable "region" {
  description = "AWS Region to deploy the resources."
  type        = string
  default     = "ap-southeast-1"
}

variable "availability_zone" {
  description = "AWS Availability Zone to deploy the resources."
  type        = string
  default     = "ap-southeast-1a"
}

variable "instance_type" {
  description = "EC2 instance type."
  type        = string
  default     = "t3.medium"
}

variable "valheim_server_name" {
  description = "Name of the Valheim server."
  type        = string
  default     = "ValheimServer"
}

variable "valheim_ami_owner" {
  description = "Owner of the AMI used for the EC2"
  type        = string
  default     = "self" # Change this to "099720109477" for the Base Ubuntu Image
}

variable "valheim_ami_name" {
  description = "The name of the AMI to be used for the EC2"
  type        = string
  default     = "ValheimServerV4-20250122" # Change this to "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*" for the Base Ubuntu Image
}

variable "backup_s3_bucket" {
  description = "S3 bucket name for backups."
  type        = string
  default     = "terraform-valheim-llanuza-v1"
}
