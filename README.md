# Projeto Final — Análise de Vulnerabilidades Web (Cibersegurança)

**Aluna:** Priscila Moura
**Curso:** Escola de Cibersegurança — Uníntese
**Alvo:** OWASP Juice Shop
**Ambiente:** Docker, rodando em VM Kali Linux (VirtualBox)
**Entrega/Apresentação:** 27/10/2026

## Sobre o projeto

Este repositório documenta um exercício de análise de vulnerabilidades web realizado contra a aplicação intencionalmente vulnerável **OWASP Juice Shop**, rodando localmente via Docker em uma máquina virtual Kali Linux. O objetivo foi identificar, explorar e documentar falhas de segurança seguindo boas práticas de pentest e elaboração de relatório técnico.

## Metodologia

Foram realizados testes manuais e com ferramentas como Burp Suite, explorando o Juice Shop em busca de falhas comuns do OWASP Top 10, com documentação detalhada de cada etapa (data, hora, passo a passo e evidências em print).

## Vulnerabilidades encontradas

| ID | Nome | Severidade |
|---|---|---|
| VULN-01 | SQL Injection no login (bypass de autenticação) | Crítica |
| VULN-02 | XSS refletido no campo de busca | Alta |
| VULN-03 | Broken Access Control / IDOR no carrinho | Alta |
| VULN-04 | Exposição de versão do framework (erro 401) | Baixa |
| VULN-05 | Diretório /ftp exposto (arquivo confidencial) | Crítica |
| VULN-06 | Bypass de autenticação via JWT forjado (alg: none) | Crítica |

Detalhes completos de cada vulnerabilidade (passo a passo de exploração e evidências) estão nas fichas técnicas, na pasta [`fichas/`](./fichas).

## Estrutura do repositório
├── README.md
├── Relatorio_Final_Cibersegurança_Priscila_Moura.pdf
├── fichas/
│ ├── VULN-01.md
│ ├── VULN-02.md
│ ├── VULN-03.md
│ ├── VULN-04.md
│ ├── VULN-05.md
│ └── VULN-06.md
└── evidencias/
├── vul01/
├── vul02/
├── vul03/
├── vul04/
├── vul05/
└── vul06/

## Relatório completo

O relatório técnico consolidado, com introdução, metodologia, resumo executivo e matriz de severidade, está disponível em [`Relatorio_Final_Cibersegurança_Priscila_Moura.pdf`](./Relatorio_Final_Cibersegurança_Priscila_Moura.pdf).

## Observação

Todos os testes foram realizados em ambiente controlado e isolado (Docker local), sem impacto em sistemas de terceiros, exclusivamente para fins educacionais.
