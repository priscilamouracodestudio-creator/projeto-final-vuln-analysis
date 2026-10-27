# VULN-03 — Broken Access Control / IDOR no Endpoint do Carrinho

**Categoria:** Controle de Acesso Quebrado (OWASP A01:2021 – Broken Access Control)
**Severidade:** Alta
**Status:** Documentado
**Data/horário do teste:** 25/10/2026, 17:58 – 18:00

## Ambiente
- Alvo: OWASP Juice Shop (bkimminich/juice-shop:latest, via Docker)
- URL: http://localhost:3000
- Ferramentas: Burp Suite Community Edition, DevTools (Console)

## Descrição
O endpoint /rest/basket/{id} não valida se o token de autenticação do usuário autenticado corresponde ao dono do carrinho solicitado (ausência de verificação de propriedade do recurso / IDOR). Qualquer usuário autenticado consegue acessar o carrinho de outro usuário apenas alterando o ID na URL.

## Passos de Reprodução
1. Capturar o token de autenticação (Bearer) válido via Burp Suite durante uma requisição legítima (GET /rest/products/search).
2. No Console do navegador, executar uma requisição ao próprio carrinho para validar o token:
```js
fetch('/rest/basket/1', { headers: { Authorization: 'Bearer ' + localStorage.getItem('token') } }).then(r => r.json()).then(data => console.log(data))
```
3. Alterar o ID do carrinho na requisição para o de outro usuário:
```js
fetch('/rest/basket/3', { headers: { Authorization: 'Bearer ' + localStorage.getItem('token') } }).then(r => r.json()).then(data => console.log(data))
```
4. Observar retorno status: "success" com os dados do carrinho de outro usuário (UserId: 3), mesmo autenticado com o token do usuário original.
5. A aplicação confirma automaticamente o desafio "View Basket (View another user's shopping basket)".

## Evidências
- vuln03-01-burp-token-capturado.png — requisição capturada no Burp Suite com o token Bearer de sessão.
- vuln03-02-console-fetch-carrinho-outro-usuario.png — requisição no console retornando com sucesso os dados do carrinho de outro usuário (UserId: 3).
- vuln03-03-confirmacao-final-view-basket.png — banner de confirmação "You successfully solved a challenge: View Basket".

## Impacto
Qualquer usuário autenticado pode visualizar (e, potencialmente, manipular) o carrinho de compras de outros usuários apenas enumerando IDs sequenciais, violando a confidencialidade dos dados de todos os usuários da plataforma.

## Recomendação
- Implementar verificação de propriedade do recurso no backend: validar que o UserId do token corresponde ao dono do carrinho solicitado antes de retornar os dados.
- Evitar expor identificadores sequenciais previsíveis; considerar UUIDs.
- Aplicar o princípio de "fail closed": negar acesso por padrão quando a propriedade não puder ser confirmada.
