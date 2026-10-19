resource "aws_db_subnet_group" "oficina" {
  name       = "oficina-fase3-private"
  subnet_ids = var.private_subnet_ids
  tags       = { Name = "oficina-fase3-private" }
}

resource "aws_security_group" "database" {
  name_prefix = "oficina-fase3-db-"
  description = "PostgreSQL privado para a API EKS e Lambda"
  vpc_id      = var.vpc_id
  tags        = { Name = "oficina-fase3-db" }
}

resource "aws_security_group" "lambda" {
  name_prefix = "oficina-fase3-auth-lambda-"
  description = "Cliente PostgreSQL da Lambda de autenticacao"
  vpc_id      = var.vpc_id
  tags        = { Name = "oficina-fase3-auth-lambda" }
}

resource "aws_vpc_security_group_ingress_rule" "from_eks" {
  security_group_id            = aws_security_group.database.id
  referenced_security_group_id = var.eks_security_group_id
  from_port                    = 5432
  to_port                      = 5432
  ip_protocol                  = "tcp"
  description                  = "API no EKS"
}

resource "aws_vpc_security_group_ingress_rule" "from_lambda" {
  security_group_id            = aws_security_group.database.id
  referenced_security_group_id = aws_security_group.lambda.id
  from_port                    = 5432
  to_port                      = 5432
  ip_protocol                  = "tcp"
  description                  = "Lambda de CPF"
}

resource "aws_vpc_security_group_egress_rule" "lambda_to_db" {
  security_group_id            = aws_security_group.lambda.id
  referenced_security_group_id = aws_security_group.database.id
  from_port                    = 5432
  to_port                      = 5432
  ip_protocol                  = "tcp"
  description                  = "Somente PostgreSQL"
}

resource "aws_db_instance" "oficina" {
  identifier                 = "oficina-fase3-postgres"
  engine                     = "postgres"
  instance_class             = var.db_instance_class
  allocated_storage          = 20
  storage_type               = "gp2"
  storage_encrypted          = true
  db_name                    = "oficina"
  username                   = "oficina"
  password                   = var.db_password
  db_subnet_group_name       = aws_db_subnet_group.oficina.name
  vpc_security_group_ids     = [aws_security_group.database.id]
  publicly_accessible        = false
  multi_az                   = false
  backup_retention_period    = 1
  deletion_protection        = false
  skip_final_snapshot        = true
  apply_immediately          = true
  auto_minor_version_upgrade = true
  tags                       = { Name = "oficina-fase3-postgres" }
}
