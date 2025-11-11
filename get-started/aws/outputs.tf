output "instance_hostname" {
  description = "Private DNS name of the EC2 instance."
  value       = aws_instance.appsrv.private_dns
}
