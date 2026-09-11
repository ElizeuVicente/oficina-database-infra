# Oficina Database Infra

Banco PostgreSQL de desenvolvimento gratuito para a Oficina. Este repositório contém somente o runtime local; as migrations Flyway pertencem à aplicação enquanto o schema ainda evolui junto do domínio.

```bash
cp .env.example .env
# defina POSTGRES_PASSWORD
docker compose up -d
```

O módulo Terraform será preenchido para o banco gerenciado somente se houver uma escolha de nuvem e orçamento aprovados. Não há `apply` ou recursos pagos configurados.
