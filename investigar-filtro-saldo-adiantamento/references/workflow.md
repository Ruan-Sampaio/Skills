# Workflow

## Objetivo

Rastrear onde filtros de data do Extrato de Credito ou Saldo Adiantamento se perdem no fluxo UI -> browser/frame -> controller -> dao -> SQL.

## Passos

1. Mapear campos de filtro no formulario, frame ou browser.
2. Confirmar propagacao para controller, incluindo assinatura e construcao de DTO/filtro.
3. Confirmar propagacao para DAO, incluindo parametros e binds.
4. Confirmar o SQL final executado e as datas realmente usadas.
5. Validar timezone, conversao `date` versus `datetime` e defaults.
6. Produzir relatorio com arquivo, linha, snippet, causa provavel e patch minimo.

## Perguntas obrigatorias

- O filtro some antes do controller ou ja entra errado na UI?
- O controller propaga o valor sem sobrescrever?
- O DAO usa o mesmo nome e tipo do parametro?
- O SQL aplica o filtro na data correta?
- Existe fallback que troca `data_inicial`, `data_final` ou `tipo_de_selecao`?
