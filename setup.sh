#!/bin/bash
# setup.sh — organiza a estrutura de pastas do projeto de análise de vulnerabilidades
# Uso: bash setup.sh

echo "Verificando/criando estrutura do projeto..."

mkdir -p fichas
mkdir -p evidencias/vul01
mkdir -p evidencias/vul02
mkdir -p evidencias/vul03
mkdir -p evidencias/vul04
mkdir -p evidencias/vul05
mkdir -p evidencias/vul06

echo "Estrutura pronta:"
echo "  fichas/"
echo "  evidencias/vul01 a vul06"
echo ""
echo "Lembre-se de adicionar as fichas técnicas (VULN-01.md a VULN-06.md) em fichas/"
echo "e os prints de evidência nas respectivas pastas em evidencias/"
