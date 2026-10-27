# VULN-06 — Bypass de Autenticação via JWT Forjado (alg: none)

**Categoria:** Falha Criptográfica / Quebra de Autenticação (OWASP A02/A07:2021)
**Severidade:** Crítica
**Data/horário:** 26/10/2026, 20:06 – 20:14

## Descrição
A aplicação usa JWT assinado com RS256, mas aceita tokens com `"alg":"none"` e assinatura vazia, autenticando qualquer identidade definida no payload sem validar a assinatura. Desafio oficial do OWASP Juice Shop.

## Técnica
1. Login com usuário comum, captura do cookie `token` original.
2. Forjado novo header `{"alg":"none","typ":"JWT"}` + payload alterado (email: jwtn3d@juice-sh.op, role: admin), via script Python (Base64URL sem padding, assinatura vazia).
3. Cookie substituído via Console: `document.cookie = "token=<forjado>; path=/"`.
4. Página recarregada.

## Resultado
- Bypass confirmado: menu de conta passou a exibir `jwtn3d@juice-sh.op`.
- Escalada bloqueada: acesso a `/administration` retornou 403, mesmo com role=admin no payload.

## Evidências
- vuln06-01-token-original-usuario-comum.png (20:06)
- vuln06-02-bypass-autenticacao-sucesso.png (20:13)
- vuln06-03-escalada-privilegio-bloqueada-403.png (20:14)

## Impacto
Atacante assume identidade de qualquer usuário sem credenciais válidas, explorando falha na validação do algoritmo do JWT. Risco crítico mesmo sem escalada total neste endpoint.

## Recomendação
- Nunca aceitar `alg: none`; usar allowlist de algoritmos na validação.
- Validar assinatura RS256 em toda requisição autenticada.
- Não confiar isoladamente no payload do JWT para autorização; revalidar no backend.
- Atualizar bibliotecas de JWT para versões que bloqueiam `alg: none` por padrão.
