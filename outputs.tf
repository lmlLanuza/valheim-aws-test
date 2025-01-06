output "instance_public_ip" {
  description = "Public IP of the Valheim server."
  value       = aws_instance.valheim_server.public_ip
}

output "instance_id" {
  description = "Instance ID of the Valheim server."
  value       = aws_instance.valheim_server.id
}

output "s3_arn" {
  description = "ARN of the S3 Bucket"
  value       = aws_s3_bucket.backup.arn
}
