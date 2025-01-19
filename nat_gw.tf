resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.project_name}-${var.environment}-igw"
  }
}


################################################################################
# NAT Gateway
################################################################################

locals {
  nat_gateway_count = var.single_nat_gateway ? 1 : length(var.azs)
  nat_gateway_ips   = aws_eip.nat[*].id
}

resource "aws_eip" "nat" {
  count = local.nat_gateway_count
  domain = "vpc"

    tags = merge(
    {
      "Name" = format("%s-%s-nat-eip%s",var.project_name ,var.environment, replace(element(var.azs, var.single_nat_gateway ? 0 : count.index), "us-east", ""))
    },
    var.tags,
  )

  depends_on = [aws_internet_gateway.this]
}


resource "aws_nat_gateway" "this" {
  count = local.nat_gateway_count

  allocation_id = element(
    local.nat_gateway_ips,
    var.single_nat_gateway ? 0 : count.index,
  )
  subnet_id = element(
    aws_subnet.public[*].id,
    var.single_nat_gateway ? 0 : count.index,
  )

  tags = merge(
    {
     "Name" = format("%s-%s-nat-gw%s",var.project_name ,var.environment, replace(element(var.azs, var.single_nat_gateway ? 0 : count.index), "us-east", ""))},   
    var.tags,
  )

  depends_on = [aws_internet_gateway.this]
}