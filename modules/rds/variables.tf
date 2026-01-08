variable "db_identifier" {
  description = "Identificador único da instância RDS"
  type        = string
  default     = "fiap-soat-db-clientes"
}

variable "db_name" {
  description = "Nome do banco de dados"
  type        = string
}

variable "db_username" {
  description = "Username do banco PostgreSQL"
  type        = string
}

variable "db_password" {
  description = "Senha do banco PostgreSQL"
  type        = string
  sensitive   = true
}

variable "db_instance_class" {
  description = "Classe da instância RDS"
  type        = string
  default     = "db.t3.micro"
}

variable "db_allocated_storage" {
  description = "Armazenamento alocado em GB"
  type        = number
  default     = 20
}

variable "db_engine_version" {
  description = "Versão do PostgreSQL"
  type        = string
  default     = "17.4"
}

variable "publicly_accessible" {
  description = "Se o RDS deve ser publicamente acessível"
  type        = bool
  default     = false
}

variable "use_default_vpc" {
  description = "Se deve usar a VPC padrão do AWS Academy Lab"
  type        = bool
  default     = true
}

variable "db_subnet_group_name" {
  description = "Nome do DB Subnet Group"
  type        = string
  default     = "fiap-soat-clientes-subnet-group"
}

variable "security_group_name" {
  description = "Nome do Security Group"
  type        = string
  default     = "fiap-soat-clientes-rds-sg"
}

variable "allowed_cidr_blocks" {
  description = "Lista de CIDR blocks permitidos para acessar o RDS"
  type        = list(string)
  default     = ["0.0.0.0/0"]  # Para Lab apenas, restrinja em produção
}

variable "environment" {
  description = "Ambiente (dev, staging, prod)"
  type        = string
  default     = "dev"
}
