#!/bin/bash

DATA=$(date '+%d/%m/%Y %H:%M:%S')

echo "======================================"
echo "   VERIFICACAO DOS SERVICOS DO SIEM"
echo "======================================"
echo "Data e hora: $DATA"
echo

SERVICOS=("elasticsearch" "kibana" "filebeat")

for SERVICO in "${SERVICOS[@]}"; do
    if systemctl is-active --quiet "$SERVICO"; then
        echo "[OK] $SERVICO esta em execucao."
    else
        echo "[ERRO] $SERVICO nao esta em execucao."
    fi
done

echo
echo "Verificacao finalizada."
echo "======================================"
