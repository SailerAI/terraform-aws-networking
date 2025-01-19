output "vpc_id" {
  value     = aws_ssm_parameter.vpc.value
  sensitive = true
}

output "private_subnet_ids" {
  value     = [for subnet in aws_ssm_parameter.private_subnet_ids : subnet.value]
  sensitive = true
}

output "database_subnet_ids" {
  value     = [for subnet in aws_ssm_parameter.database_subnet_ids : subnet.value]
  sensitive = true
}

output "public_subnet_ids" {
  value     = [for subnet in aws_ssm_parameter.public_subnet_ids : subnet.value]
  sensitive = true
}
