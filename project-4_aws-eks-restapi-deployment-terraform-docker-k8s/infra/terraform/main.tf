terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.0" # Relaxed AWS provider version to allow any 5.x.x version
    }
  }
}

provider "aws" {
  region = var.region
}

# VPC (public+private subnets)
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0" # Add version constraint for VPC module for consistency

  name = "eks-restapi"
  cidr = "10.0.0.0/16"
  azs  = ["us-east-1a", "us-east-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.11.0/24", "10.0.12.0/24"]
  enable_nat_gateway = true
  single_nat_gateway = true
  tags = { Project = "eks-restapi" }
}

# EKS
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.1.0" # Updated module version for better 1.29 compatibility

  cluster_name    = "eks-restapi"
  cluster_version = "1.29"
  subnet_ids      = module.vpc.private_subnets
  vpc_id          = module.vpc.vpc_id
  eks_managed_node_groups = {
    default = { desired_size = 2, min_size = 2, max_size = 4, instance_types = ["t3.small"] }
  }
  tags = { Project = "eks-restapi" }
}

# ECR
resource "aws_ecr_repository" "api" {
  name = "rest-api"
  image_scanning_configuration { scan_on_push = true }
  image_tag_mutability = "IMMUTABLE"
  tags = { Project = "eks-restapi" }
}

# RDS (PostgreSQL)
module "db" {
  source = "terraform-aws-modules/rds/aws"
  version = "~> 6.0" # Added version constraint for RDS module for consistency

  identifier = "restapi-db"
  engine = "postgres"
  engine_version = "16"
  family = "postgres16" # <--- Added missing 'family' argument
  instance_class = "db.t4g.micro"
  allocated_storage = 20
  db_name  = "restapidb"
  username = var.db_username
  password = var.db_password
  multi_az = false
  publicly_accessible = false
  vpc_security_group_ids = []
  db_subnet_group_name = module.vpc.database_subnet_group
  skip_final_snapshot = true
  tags = { Project = "eks-restapi" }
}

output "ecr_url" { value = aws_ecr_repository.api.repository_url }
output "cluster_name" { value = module.eks.cluster_name }
output "region" { value = var.region }
output "db_endpoint" { value = module.db.db_instance_address }
