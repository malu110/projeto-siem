#!/bin/bash

DATA=$(date '+%d/%m/%Y %H:%M:%S')
TOTAL=0
ATIVOS=0
FALHAS=0

echo "======================================"
echo "   VERIFICACAO DOS SERVICOS DO SIEM"
echo "======================================"
echo "Data e hora: $DATA"
echo

SERVICOS=("elasticsearch" "kibana" "filebeat")

for SERVICO in "${SERVICOS[@]}"; do
    TOTAL=$((TOTAL + 1))

    if systemctl is-active --quiet "$SERVICO"; then
        echo "[OK] $SERVICO esta em execucao."
        ATIVOS=$((ATIVOS + 1))
    else
        echo "[ERRO] $SERVICO nao esta em execucao."
        FALHAS=$((FALHAS + 1))
    fi
done

echo
echo "RESUMO DA VERIFICACAO"
echo "Total de servicos: $TOTAL"
echo "Servicos ativos: $ATIVOS"
echo "Servicos com falha: $FALHAS"
echo "Verificacao finalizada."
echo "======================================"

if [ "$FALHAS" -gt 0 ]; then
    exit 1
fi

exit 0
