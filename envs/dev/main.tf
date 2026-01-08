terraform {
  required_version = ">= 1.5.0"
}

provider "aws" {
  region = "us-east-1"
}

module "rds" {
  source = "../../modules/rds"

  # Database Configuration
  db_name              = "fiapdb_clientes"
  db_username          = "postgresadmin"
  db_password          = var.db_password
  db_instance_class    = "db.t3.micro"
  db_allocated_storage = 20
  db_engine_version    = "17.4"

  # Network Configuration (usa VPC padrão do Lab)
  use_default_vpc      = true
  
  # Security
  allowed_cidr_blocks  = ["0.0.0.0/0"]  # Lab apenas
  publicly_accessible  = false
  
  # Naming
  db_identifier        = "fiap-soat-db-clientes"
  environment          = "dev"
}

