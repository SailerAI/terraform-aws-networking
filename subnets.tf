### Public Subnets
resource "aws_subnet" "public" {
  count = length(var.public_subnets)
  vpc_id = aws_vpc.main.id
  cidr_block = var.public_subnets[count.index]
  availability_zone = var.azs[count.index]
  tags = {
    Name = format("%s-%s-public-subnet%s", var.project_name,var.environment, replace(element(var.azs, count.index), "us-east", ""))
  }
}

### Private Subnets
resource "aws_subnet" "private" {
  count = length(var.private_subnets)
  vpc_id = aws_vpc.main.id
  cidr_block = var.private_subnets[count.index]
  availability_zone = var.azs[count.index]
  tags = {
    Name = format("%s-%s-private-subnet%s", var.project_name,var.environment, replace(element(var.azs, count.index), "us-east", ""))
  }
}

### Database Subnets
resource "aws_subnet" "database" {
  count = length(var.database_subnets)
  vpc_id = aws_vpc.main.id
  cidr_block = var.database_subnets[count.index]
  availability_zone = var.azs[count.index]
  tags = {
    Name = format("%s-%s-database-subnet%s", var.project_name,var.environment, replace(element(var.azs, count.index), "us-east", ""))
  }
}