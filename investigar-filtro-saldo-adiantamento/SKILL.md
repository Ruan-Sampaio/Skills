---
name: investigar-filtro-saldo-adiantamento
description: Rastreia perda de filtro de data no fluxo do Extrato de Credito ou Saldo Adiantamento da UI ate o SQL. Use quando o usuario relatar que o filtro nao respeita data inicial/final, quando houver divergencia entre tela e banco, ou quando precisar localizar em qual camada o parametro se perde entre frame/browser, controller, dao e SQL.
---

# Investigar Filtro de Saldo Adiantamento

Executar este fluxo ao depurar filtros de data ou tipo de selecao ligados ao saldo de adiantamento.

## Fluxo

1. Ler [workflow.md](references/workflow.md).
2. Localizar o ponto de entrada do filtro na UI.
3. Seguir o valor pelo browser ou frame ate o controller.
4. Confirmar DTO ou estrutura de filtro.
5. Confirmar parametros passados ao DAO.
6. Confirmar o SQL final e os binds.
7. Verificar conversoes de data, timezone e defaults.
8. Registrar a camada onde o filtro se perde e propor patch minimo.

## Regras de investigacao

- Nao assumir que o erro esta no SQL; confirmar o caminho inteiro.
- Capturar nomes de campos, assinaturas e tipos em cada camada.
- Diferenciar claramente `nao foi enviado`, `foi enviado nulo` e `foi sobrescrito`.
- Se houver fallback em banco, registrar o comportamento exato.

## Saida minima

- Onde o filtro entra.
- Onde ele se perde.
- Causa provavel.
- Patch minimo sugerido.
- Risco de regressao.
