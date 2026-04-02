---
name: investigar-filtro-saldo-adiantamento
description: Investiga por que o filtro de data do Extrato de Credito ou Saldo Adiantamento nao e respeitado entre UI, controller, DAO e SQL. Use quando a tela listar dados fora do periodo, quando houver divergencia entre Visualizar e CSV, ou quando precisar identificar em qual camada o parametro de data ou periodo se perde; nao use para bugs de estorno ou regressao historica de function SQL.
---

# Investigar Filtro de Saldo Adiantamento

Executar este fluxo ao depurar filtros de data, selecao e sinal ligados ao saldo de adiantamento.

## Fluxo

1. Ler [workflow.md](references/workflow.md).
2. Reproduzir no frame de origem e confirmar os controles de data usados.
3. Seguir o valor de data no browser ou frame ate o controller.
4. Confirmar a estrutura de filtro e os parametros enviados ao DAO.
5. Confirmar assinatura da function SQL e binds executados em runtime.
6. Verificar fallback via `current_setting` ou configuracao de sessao.
7. Testar a function diretamente no banco com e sem parametros.
8. Registrar a camada onde o filtro se perde e propor patch minimo.

## Regras de investigacao

- Nao assumir que o erro esta no SQL; confirmar o caminho inteiro.
- Capturar nomes de campos, assinaturas e tipos em cada camada.
- Diferenciar claramente `nao foi enviado`, `foi enviado nulo` e `foi sobrescrito`.
- Se houver fallback em banco, registrar o comportamento exato.
- Se a investigacao tocar SQL, validar compatibilidade com `PostgreSQL 9.3` antes de propor patch.
- Nao propor `jsonb`, `to_jsonb`, `jsonb_*` ou `FILTER (...)` em correcao SQL desse projeto.
- Se houver necessidade de filtro condicional em agregacao, preferir `CASE WHEN`.
- Preservar encoding fisico dos arquivos alterados; nao converter automaticamente.

## Saida minima

- Onde o filtro entra.
- Onde ele se perde.
- Causa provavel.
- Patch minimo sugerido.
- Risco de regressao.
