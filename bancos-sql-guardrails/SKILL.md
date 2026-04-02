---
name: bancos-sql-guardrails
description: Define guardrails para criar, revisar e manter scripts SQL no repositorio `C:\@work\bancos` com compatibilidade `PostgreSQL 9.3` e padrao legado. Use quando a tarefa envolver `function`, `view`, `type`, `trigger`, `RTM`, tabela, coluna, `INSERT`, `UPDATE`, `DELETE` ou qualquer script SQL novo ou alterado no repo Bancos.
---

# Bancos SQL Guardrails

Aplicar esta skill antes de criar, revisar ou alterar scripts SQL no repositorio `bancos`.

## Fluxo

1. Ler [sql-rules.md](references/sql-rules.md).
2. Classificar o artefato: `function`, `view`, `table`, `column`, `type`, `trigger`, `rtm`, `crud`.
3. Confirmar a pasta correta e a forma de versionamento do script.
4. Validar compatibilidade com `PostgreSQL 9.3` e encoding esperado.
5. Identificar se a mudanca e sensivel e precisa ser sinalizada para aprovacao.
6. So depois propor ou aplicar o patch SQL.

## Regras principais

- Preservar `win1252` quando o script exigir esse encoding.
- Salvar scripts SQL somente em `C:\@work\bancos\desktop\Scripts` ou subpastas apropriadas.
- Nao usar comandos proibidos para desativar verificacao de constraints ou triggers globalmente.
- Nao excluir nem renomear colunas.
- Nao excluir types nem remover atributos existentes.
- Preferir mudancas incrementais, idempotentes e seguras.

## Saida minima

- Tipo de artefato.
- Pasta correta.
- Riscos de compatibilidade ou aprovacao.
- Regras obrigatorias que impactam o script.
