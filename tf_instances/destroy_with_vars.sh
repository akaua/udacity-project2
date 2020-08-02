#!/bin/bash

echo "Criando plano de execução..."
terraform plan -destroy -out="/tmp/tfplan" -input=false -var-file="vars/dev/main.tfvars"
echo "Plano de execução salvo no path /tmp/tfplan "
echo "Para visualizar o plano, execute o comando terraform show /tmp/tfplan"

echo "Aplicando plano de execução..."
terraform destroy -var-file="vars/dev/main.tfvars"
echo "Execução finalizada."