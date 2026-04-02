# Workflow

## Objetivo

Rastrear onde filtros de data do Extrato de Credito ou Saldo Adiantamento se perdem no fluxo UI -> browser/frame -> controller -> DAO -> SQL.

## Passos

1. Reproduzir o problema e identificar o frame ou form real usado no fluxo.
2. Verificar eventos de aplicacao de filtro no frame/browser e quais controles de data sao lidos.
3. Confirmar propagacao para controller, incluindo assinatura e construcao de DTO/filtro.
4. Confirmar propagacao para DAO, incluindo parametros, nomes e binds.
5. Confirmar assinatura da function SQL usada no schema `financas`.
6. Verificar se a function depende de `current_setting` e se a sessao e configurada antes da chamada.
7. Testar a function diretamente no banco com valores controlados.
8. Validar timezone, conversao `date` versus `datetime` e defaults.
9. Produzir relatorio com arquivo, linha, causa provavel e patch minimo.

## Perguntas obrigatorias

- O filtro some antes do controller ou ja entra errado na UI?
- O controller propaga o valor sem sobrescrever?
- O DAO usa o mesmo nome e tipo do parametro?
- O SQL aplica o filtro na data correta?
- Existe fallback que troca `data_inicial`, `data_final` ou `tipo_de_selecao`?
- A consulta mistura receber e pagar por falta de `sinal`?
