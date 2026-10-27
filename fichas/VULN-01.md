# VULN-01 — SQL Injection no Login (Bypass de Autenticação)

**Categoria:** Injeção de SQL (OWASP A03:2021 – Injection)
**Severidade:** Crítica
**Status:** Documentado
**Data/horário do teste:** 25/10/2026, 17:05 – 17:07

## Ambiente
- Alvo: OWASP Juice Shop (bkimminich/juice-shop:latest, via Docker)
- URL: http://localhost:3000
- Ferramentas: Chromium (DevTools), Burp Suite Community Edition

## Descrição
O endpoint de login (POST /rest/user/login) não trata corretamente o campo email, permitindo a injeção de uma condição sempre verdadeira (' OR 1=1-- ) que burla a validação de credenciais e autentica o atacante como o primeiro usuário da base (administrador).

## Payload utilizado
```json
{
  "email": "' OR 1=1-- ",
  "password": "123456"
}
```

## Passos de Reprodução
1. Acessar a tela de login da aplicação.
2. No campo de e-mail, inserir o payload ' OR 1=1--  (qualquer senha).
3. Submeter o formulário.
4. Observar o redirecionamento com sessão autenticada como administrador (admin@juice-sh.op).

## Evidências
- vuln01-01-login-bypass-sucesso.png — banner "You successfully solved a challenge: Login Admin", confirmando o bypass.
- vuln01-02-sessao-admin-confirmada.png — menu de conta exibindo a sessão logada como admin@juice-sh.op.
- vuln01-03-payload-burp-requisicao.png — requisição capturada no Burp Suite (POST /rest/user/login) com o payload exato.

## Impacto
Acesso administrativo completo à aplicação sem conhecimento de credenciais válidas, permitindo visualização e manipulação de dados de qualquer usuário, pedidos, e funcionalidades restritas.

## Recomendação
- Utilizar consultas parametrizadas (prepared statements) ou ORM com binding seguro de parâmetros.
- Nunca concatenar entrada do usuário diretamente em queries SQL.
- Implementar validação de entrada e WAF como camada adicional de defesa.
