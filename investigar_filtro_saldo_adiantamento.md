# investigar_filtro_saldo_adiantamento

## Objetivo
Rastrear onde filtros de data do Extrato de Credito (Saldo Adiantamento) se perdem no fluxo UI -> browser/frame -> controller -> dao -> SQL.

## Roteiro de investigacao
1. Mapear campos de filtro no formulario/frame/browser.
2. Confirmar propagacao para controller (assinaturas, DTO/filtro).
3. Confirmar propagacao para DAO (parametros e bind).
4. Confirmar SQL final executado com datas.
5. Validar timezone/conversao de data/hora.
6. Produzir relatorio com arquivo/linha/snippet e causa provavel.

## Entregavel
Relatorio objetivo com:
- onde o filtro entra
- onde ele se perde
- patch sugerido minimo
- risco de regressao
