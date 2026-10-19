output "db_endpoint" {
  value = aws_db_instance.oficina.address
}

output "db_port" {
  value = aws_db_instance.oficina.port
}

output "database_security_group_id" {
  value = aws_security_group.database.id
}

output "lambda_security_group_id" {
  value = aws_security_group.lambda.id
}
