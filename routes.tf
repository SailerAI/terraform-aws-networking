# Public Routes
#locals {
#  num_public_route_tables = length(var.public_subnets)
#}

resource "aws_route_table" "public" {
#  count = length(var.public_subnets)
  vpc_id = aws_vpc.main.id

  tags = merge(
    {
      "Name" = format("%s-%s-public-rt",var.project_name,var.environment)
    },
    var.tags,
  )
}

resource "aws_route_table_association" "public" {
  count = length(var.public_subnets)
  subnet_id      = element(aws_subnet.public[*].id, count.index)
  route_table_id = aws_route_table.public.id
}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id

  timeouts {
    create = "5m"
  }
}

# Private Routes



resource "aws_route_table" "private" {
  count = local.nat_gateway_count
  vpc_id = aws_vpc.main.id

  tags = merge(
    {
 #     "Name" = format("%s-%s-private-rt-%d",var.project_name,var.environment,count.index)
  "Name" = format("%s-%s-private-rt%s",var.project_name,var.environment,replace(element(var.azs, var.single_nat_gateway ? 0 : count.index), "us-east", ""))
    },
    var.tags,
  )
}

resource "aws_route_table_association" "private" {
  count = length(var.private_subnets)
  subnet_id      = element(aws_subnet.private[*].id, count.index)
  #route_table_id = aws_route_table.private[count.index].id
  route_table_id = element(
    aws_route_table.private[*].id,
    var.single_nat_gateway ? 0 : count.index,
  )
}

resource "aws_route" "private_nat_gateway" {
  count = local.nat_gateway_count
  route_table_id         = aws_route_table.private[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_nat_gateway.this[count.index].id
}

# Database Routes

resource "aws_route_table" "database" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    {
      "Name" = format("%s-%s-database-rt",var.project_name,var.environment)
    },
    var.tags,
  )
}

resource "aws_route_table_association" "database" {
  count = length(var.database_subnets)
  subnet_id      = element(aws_subnet.database[*].id, count.index)
  route_table_id = aws_route_table.database.id
}
