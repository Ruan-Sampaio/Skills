# Project Pattern (nsjFinancas)

## Definicao de modulo
Modulo funcional = conjunto de unidades de um mesmo dominio com camadas:
- UI: browser/ficha/frame
- aplicacao: controller
- dados: dao/dto/constantes (e enum/service/mapper quando houver)

## Regra pratica
- `mvc/*` e pasta tecnica.
- nome do modulo vem do dominio da unit (ex.: `Financas.DAO.OcorrenciaContrato`, `Financas.Browser.OcorrenciaContrato`).

## Nao fazer
- assumir que pasta `mvc/dao` ou `mvc/dto` representa modulo completo.
