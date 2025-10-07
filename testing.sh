#!/usr/bin/bash

# Verifica se Apache Bench está instalado, se não, instale
if ! command -v ab &> /dev/null; then
    echo "Instalando Apache Bench"
    sudo apt-get update && sudo apt-get install -y apache2-utils
fi

# Rodando Teste de carga
echo "Rodando Teste de carga"

# itera pelos ids testando usando Apache Bench
ids=(1 2)
for id in "${ids[@]}"
do
  echo "Testing voting for user id: ${id}"
  ab -n 5000 -c 1000 -m PATCH "http://localhost:9999/api/participants/${id}/upvote"
  echo "============================================"
done