# VULN-02 — Cross-Site Scripting (XSS) Refletido no Campo de Busca

**Categoria:** Cross-Site Scripting (OWASP A03:2021 – Injection)
**Severidade:** Alta
**Status:** Documentado
**Data/horário do teste:** 25/10/2026, 17:34 (disparo) e 17:38 (confirmação do payload na URL)

## Ambiente
- Alvo: OWASP Juice Shop (bkimminich/juice-shop:latest, via Docker)
- URL: http://localhost:3000
- Ferramentas: Chromium (DevTools)

## Descrição
O campo de busca de produtos reflete o parâmetro q da URL diretamente na página sem sanitização, permitindo a injeção de HTML/JavaScript arbitrário que é executado no contexto do navegador da vítima.

## Payload utilizado
```html
<iframe src="javascript:alert('XSS por Priscila')">
```

## Passos de Reprodução
1. Acessar a página de busca de produtos (/#/search).
2. Inserir o payload acima no campo de busca.
3. Observar a execução do JavaScript (pop-up de alerta) imediatamente após a submissão.
4. Confirmar que o payload permanece refletido no parâmetro q da URL, podendo ser compartilhado como link malicioso.

## Evidências
- vuln02-01-xss-alert-disparado.png — pop-up "XSS por Priscila" disparado via payload no campo de busca (17:34).
- vuln02-02-xss-payload-url-confirmado.png — payload refletido na URL/campo de busca, confirmando a reprodutibilidade (17:38).

## Impacto
Execução de código arbitrário no navegador de qualquer usuário que acesse um link malicioso contendo o payload, podendo levar a roubo de sessão (cookies/tokens), phishing in-page ou redirecionamento malicioso.

## Recomendação
- Sanitizar e codificar (output encoding) todo conteúdo refletido na página (ex: encodeURIComponent + escaping de HTML).
- Implementar Content Security Policy (CSP) restritiva.
- Utilizar bibliotecas de template que escapam automaticamente conteúdo dinâmico.
