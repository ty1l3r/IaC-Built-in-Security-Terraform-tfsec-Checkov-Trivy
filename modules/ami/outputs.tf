# modules/ami/outputs.tf

output "ami_id" {
  description = "ID de la dernière AMI Amazon Linux 2"
  value       = data.aws_ami.amazon_linux_latest.id
}
