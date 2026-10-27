# VULN-05 — Diretório /ftp Exposto com Arquivo Confidencial

**Categoria:** Configuração Insegura / Exposição de Dados Sensíveis (OWASP A05:2021 – Security Misconfiguration)
**Severidade:** Crítica
**Status:** Documentado
**Data/horário do teste:** 25/10/2026, 18:05

## Ambiente
- Alvo: OWASP Juice Shop (bkimminich/juice-shop:latest, via Docker)
- URL: http://localhost:3000/ftp/acquisitions.md
- Ferramentas: Chromium (acesso direto via navegador)

## Descrição
A aplicação expõe publicamente, sem qualquer controle de acesso, um diretório /ftp contendo arquivos internos. Um dos arquivos encontrados (acquisitions.md) contém informação explicitamente marcada como confidencial ("Planned Acquisitions... This document is confidential! Do not distribute!"), incluindo detalhes sobre planos de aquisição de concorrentes com potencial impacto no mercado de ações.

## Passos de Reprodução
1. Acessar diretamente a URL http://localhost:3000/ftp/acquisitions.md no navegador.
2. Observar que o conteúdo do arquivo é exibido sem qualquer autenticação ou controle de acesso.

## Evidências
- vuln05-01-ftp-acquisitions-exposto.png — conteúdo do arquivo acquisitions.md exibido publicamente, com o aviso de confidencialidade visível.

## Impacto
Vazamento de informações estratégicas/confidenciais da empresa (planos de aquisição), que poderiam ser utilizadas para vantagem competitiva indevida, manipulação de mercado ou engenharia social contra a organização.

## Recomendação
- Remover ou restringir o acesso público ao diretório /ftp (e a qualquer diretório de arquivos estáticos que não deveria ser público).
- Implementar controle de acesso adequado (autenticação + autorização) para qualquer recurso que contenha dados sensíveis.
- Realizar varredura periódica de diretórios e arquivos expostos publicamente no ambiente de produção.
