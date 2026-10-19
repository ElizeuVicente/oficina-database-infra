variable "region" {
  type    = string
  default = "us-east-1"
}

variable "vpc_id" {
  description = "Output vpc_id do Terraform de Kubernetes."
  type        = string
}

variable "private_subnet_ids" {
  description = "Outputs private_subnet_ids do Terraform de Kubernetes."
  type        = list(string)

  validation {
    condition     = length(var.private_subnet_ids) >= 2
    error_message = "RDS requer duas subnets privadas em AZs distintas."
  }
}

variable "eks_security_group_id" {
  description = "Output cluster_security_group_id do EKS, associado aos nós gerenciados."
  type        = string
}

variable "db_password" {
  description = "Senha do banco; use TF_VAR_db_password no ambiente, nunca Git/CLI."
  type        = string
  sensitive   = true

  validation {
    condition     = length(var.db_password) >= 16
    error_message = "Use senha de banco com pelo menos 16 caracteres."
  }
}

variable "db_instance_class" {
  type    = string
  default = "db.t3.micro"
}
