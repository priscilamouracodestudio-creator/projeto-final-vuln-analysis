# VULN-04 — Exposição de Versão do Framework em Mensagem de Erro 401

**Categoria:** Exposição de Dados / Configuração Insegura (OWASP A05:2021 – Security Misconfiguration)
**Severidade:** Baixa
**Status:** Documentado
**Data/horário do teste:** 25/10/2026, 17:52

## Ambiente
- Alvo: OWASP Juice Shop (bkimminich/juice-shop:latest, via Docker)
- URL: http://localhost:3000/rest/basket/1
- Ferramentas: Chromium (acesso direto via navegador)

## Descrição
Ao acessar um endpoint protegido sem fornecer o header de autorização, a aplicação retorna uma página de erro padrão do Express que expõe a versão exata do framework em uso (Express ^4.22.1) junto à mensagem de erro UnauthorizedError: No Authorization header was found.

## Passos de Reprodução
1. Acessar diretamente a URL http://localhost:3000/rest/basket/1 sem estar autenticado (sem header Authorization).
2. Observar a página de erro padrão exibida, contendo o cabeçalho "OWASP Juice Shop (Express ^4.22.1)" e o código de status 401.

## Evidências
- vuln04-01-erro-401-versao-express-exposta.png — página de erro exibindo a versão do Express e a mensagem de erro de autorização.

## Impacto
A exposição da versão exata do framework facilita o reconhecimento por parte de um atacante, que pode pesquisar vulnerabilidades conhecidas (CVEs) específicas dessa versão para planejar ataques direcionados.

## Recomendação
- Configurar páginas de erro customizadas que não exponham informações de stack, versão de frameworks ou detalhes de implementação.
- Definir NODE_ENV=production para desabilitar mensagens de erro detalhadas do Express.
- Revisar middlewares de tratamento de erro para garantir respostas genéricas em ambientes de produção.
