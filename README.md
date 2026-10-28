# 🔐 Análise de Vulnerabilidades Web: OWASP Juice Shop

> **EN:** Web application penetration test against OWASP Juice Shop (an intentionally vulnerable app) in an isolated lab (Docker inside a Kali Linux VM). Six findings documented with evidence, severity rating and recommended remediation, plus a full technical report (PDF, in Portuguese).

**Autora:** Priscila Moura · **Curso:** Escola de Cibersegurança, Uníntese
**Alvo:** OWASP Juice Shop · **Ambiente:** Docker em VM Kali Linux (VirtualBox)
**Entrega e apresentação:** 27/10/2026

---

## 📌 Resumo

Exercício de análise de vulnerabilidades web contra uma aplicação **intencionalmente vulnerável**, executada localmente e isolada. O objetivo foi identificar, explorar e documentar falhas de segurança seguindo boas práticas de pentest e de elaboração de relatório técnico.

**Resultado:** 6 vulnerabilidades documentadas (3 críticas, 2 altas e 1 baixa), cada uma com ficha técnica, evidências e mitigação recomendada.

## 🛠️ Ambiente e ferramentas

- Docker (aplicação-alvo) dentro de VM Kali Linux no VirtualBox
- Burp Suite e testes manuais
- Referência: OWASP Top 10

## 🧪 Metodologia

Testes manuais e com ferramentas, buscando falhas comuns do OWASP Top 10. Cada achado foi registrado com data, hora, passo a passo e evidências em print, o que permite que outra pessoa reproduza e valide o resultado.

## 🐞 Vulnerabilidades encontradas

| ID | Vulnerabilidade | Categoria OWASP Top 10 (2021) | Severidade | Mitigação recomendada |
|---|---|---|---|---|
| [VULN-01](fichas/VULN-01.md) | SQL Injection no login (bypass de autenticação) | A03: Injection | 🔴 Crítica | Consultas parametrizadas e validação de entrada |
| [VULN-02](fichas/VULN-02.md) | XSS refletido no campo de busca | A03: Injection | 🟠 Alta | Codificação de saída e Content-Security-Policy |
| [VULN-03](fichas/VULN-03.md) | Broken Access Control / IDOR no carrinho | A01: Broken Access Control | 🟠 Alta | Verificar no servidor se o usuário é dono do recurso |
| [VULN-04](fichas/VULN-04.md) | Exposição de versão do framework (erro 401) | A05: Security Misconfiguration | 🟢 Baixa | Mensagens de erro genéricas, sem versão nem stack |
| [VULN-05](fichas/VULN-05.md) | Diretório `/ftp` exposto (arquivo confidencial) | A05: Security Misconfiguration | 🔴 Crítica | Remover listagem de diretório e arquivos sensíveis do servidor |
| [VULN-06](fichas/VULN-06.md) | Bypass de autenticação via JWT forjado (`alg: none`) | A07: Identification and Authentication Failures | 🔴 Crítica | Validar a assinatura e permitir só algoritmos aprovados |

O passo a passo e as evidências de cada falha estão nas fichas da pasta [`fichas/`](fichas/).

## 📄 Relatório completo

O relatório técnico consolidado (introdução, metodologia, resumo executivo e matriz de severidade) está em [`Relatorio_Final_Ciberseguranca_Priscila_Moura.pdf`](Relatorio_Final_Ciberseguranca_Priscila_Moura.pdf).

## ▶️ Como reproduzir o ambiente

Use somente em uma máquina própria ou VM isolada:

```bash
docker run --rm -p 127.0.0.1:3000:3000 bkimminich/juice-shop
```

Depois acesse `http://localhost:3000`. O parâmetro `127.0.0.1` mantém a aplicação acessível só pela sua própria máquina.

## 📂 Estrutura do repositório

```
├── README.md
├── Relatorio_Final_Ciberseguranca_Priscila_Moura.pdf
├── fichas/        # uma ficha técnica por vulnerabilidade (VULN-01 a VULN-06)
└── evidencias/    # prints organizados por vulnerabilidade (vul01 a vul06)
```

## 📚 O que aprendi

- Mapear falhas ao OWASP Top 10 e classificar a severidade de cada uma
- Documentar achados de forma reprodutível (data, hora, passos e evidências)
- Pensar também do lado da defesa: para cada falha, propor uma mitigação

## ⚠️ Aviso

Projeto educacional. Todos os testes foram realizados em ambiente controlado e isolado (Docker local), contra uma aplicação feita para ser testada, sem impacto em sistemas de terceiros.
