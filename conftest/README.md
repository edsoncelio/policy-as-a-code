# Demo - Conftest
Política para validar as tags `name` e `env` em recursos Terraform.

1. Inicializar e criar o plan:
```shell
$ terraform init
$ terraform plan -out=tfplan
$ terraform show -json ./plan > plan.json

```
2. Validar as políticas (com Docker):
```shell
$ docker run --rm -v $(pwd):/app openpolicyagent/conftest test ./plan.json -o table
```