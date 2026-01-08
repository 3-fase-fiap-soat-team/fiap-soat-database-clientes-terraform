output "db_instance_endpoint" {
  description = "Endpoint da instância RDS"
  value       = aws_db_instance.this.endpoint
}

output "db_instance_id" {
  description = "ID da instância RDS"
  value       = aws_db_instance.this.id
}

output "db_instance_arn" {
  description = "ARN da instância RDS"
  value       = aws_db_instance.this.arn
}

output "db_instance_address" {
  description = "Endereço (hostname) da instância RDS"
  value       = aws_db_instance.this.address
}

output "db_instance_port" {
  description = "Porta da instância RDS"
  value       = aws_db_instance.this.port
}

output "db_name" {
  description = "Nome do banco de dados"
  value       = aws_db_instance.this.db_name
}

output "security_group_id" {
  description = "ID do Security Group do RDS"
  value       = aws_security_group.this.id
}

output "db_subnet_group_name" {
  description = "Nome do DB Subnet Group"
  value       = aws_db_subnet_group.this.name
}

output "vpc_id" {
  description = "ID da VPC utilizada"
  value       = data.aws_vpc.selected.id
}

output "subnet_ids" {
  description = "IDs das subnets utilizadas"
  value       = data.aws_subnets.available.ids
}
