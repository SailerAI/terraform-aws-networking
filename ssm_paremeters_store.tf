resource "aws_ssm_parameter" "vpc" {
  name  = format("/%s/%s/vpc/id", var.project_name, var.environment)
  type  = "String"
  value = aws_vpc.main.id

}

resource "aws_ssm_parameter" "public_subnet_ids" {
  count = length(aws_subnet.public)

  name        = format("/%s/%s/public-subnet-%s", var.project_name, var.environment, replace(element(var.azs, count.index), "us-east-", ""))
  description = "Public subnet ID for ${element(var.azs, count.index)}"
  type        = "String"
  value       = aws_subnet.public[count.index].id

  tags = {
    Environment = var.environment
    Project     = var.project_name
  }
}

resource "aws_ssm_parameter" "private_subnet_ids" {
  count = length(aws_subnet.private)
  name  = format("/%s/%s/private-subnet-%s", var.project_name, var.environment, replace(element(var.azs, count.index), "us-east-", ""))
  type  = "String"
  value = aws_subnet.private[count.index].id
}

resource "aws_ssm_parameter" "database_subnet_ids" {
  count = length(aws_subnet.database)
  name  = format("/%s/%s/database-subnet-%s", var.project_name, var.environment, replace(element(var.azs, count.index), "us-east-", ""))
  type  = "String"
  value = aws_subnet.database[count.index].id
}