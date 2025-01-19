## Global Variables

variable "project_name" {
  description = "Nome do projeto"
  type        = string
}

variable "environment" {
  description = "Ambiente"
  type        = string
}

variable "region" {
  description = "Região"
  type        = string
}

## VPC Variables


variable "vpc_cidr" {
  description = "Cidr do VPC"
  type        = string
}


variable "azs" {
  description = "A list of availability zones names or ids in the region"
  type        = list(string)
  default     = []
}


variable "enable_dns_hostnames" {
  description = "Should be true to enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Should be true to enable DNS support in the VPC"
  type        = bool
  default     = true
}

variable "enable_nat_gateway" {
  description = "Should be true to enable NAT Gateway"
  type        = bool
  default     = true
}

variable "vpc_tags" {
  description = "Additional tags for the VPC"
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

# Publiс Subnets
################################################################################

variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "public_subnet_tags" {
  description = "Additional tags for the public subnets"
  type        = map(string)
  default     = {}
}

################################################################################
# Private Subnets
################################################################################

variable "private_subnets" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "private_subnet_tags" {
  description = "Additional tags for the private subnets"
  type        = map(string)
  default     = {}
}

################################################################################
# Database Subnets
################################################################################

variable "database_subnets" {
  description = "A list of database subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "database_subnet_tags" {
  description = "Additional tags for the database subnets"
  type        = map(string)
  default     = {}
}

### NAT Gateway

variable "single_nat_gateway" {
  description = "Should be true if you want to provision a single shared NAT Gateway for the VPC"
  type        = bool
  default     = true  
}

variable "one_nat_gateway_per_az" {
  description = "Should be true if you want to provision a NAT Gateway per availability zone"
  type        = bool
  default     = false
}
