# Data Source: Buscar VPC padrão ou a primeira disponível
data "aws_vpc" "selected" {
  default = var.use_default_vpc
  
  dynamic "filter" {
    for_each = var.use_default_vpc ? [] : [1]
    content {
      name   = "state"
      values = ["available"]
    }
  }
}

# Data Source: Buscar todas as subnets da VPC
data "aws_subnets" "available" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }
  
  filter {
    name   = "state"
    values = ["available"]
  }
}

# Subnet Group para o RDS
resource "aws_db_subnet_group" "this" {
  name       = var.db_subnet_group_name
  subnet_ids = data.aws_subnets.available.ids

  tags = {
    Name        = var.db_subnet_group_name
    Environment = var.environment
    Project     = "fiap-soat"
  }
}

# Security Group para o RDS
resource "aws_security_group" "this" {
  name        = var.security_group_name
  description = "Allow PostgreSQL traffic for FIAP SOAT - Clientes"
  vpc_id      = data.aws_vpc.selected.id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
    description = "PostgreSQL access"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = {
    Name        = var.security_group_name
    Environment = var.environment
    Project     = "fiap-soat"
  }
}

# Instância RDS PostgreSQL
resource "aws_db_instance" "this" {
  identifier              = var.db_identifier
  engine                  = "postgres"
  engine_version          = var.db_engine_version
  instance_class          = var.db_instance_class
  allocated_storage       = var.db_allocated_storage
  storage_type            = "gp2"

  db_name                 = var.db_name
  username                = var.db_username
  password                = var.db_password
  port                    = 5432

  publicly_accessible     = var.publicly_accessible
  vpc_security_group_ids  = [aws_security_group.this.id]
  db_subnet_group_name    = aws_db_subnet_group.this.name

  skip_final_snapshot     = true
  backup_retention_period = 0  # Sem backups para Lab
  monitoring_interval     = 0  # Desativa Enhanced Monitoring no AWS Academy Lab

  tags = {
    Name        = var.db_identifier
    Environment = var.environment
    Project     = "fiap-soat"
    Service     = "clientes"
  }
}
