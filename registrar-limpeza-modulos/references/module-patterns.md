# Module Patterns

## Definicao de modulo

Modulo funcional = conjunto de unidades de um mesmo dominio com varias camadas:

- UI: browser, ficha, frame
- aplicacao: controller
- dados: dao, dto, constantes
- variantes: enum, service, mapper

Nao agrupar por pasta tecnica isolada como `mvc/dao`.

## Candidatos iniciais com boa coesao

- `financas.chequescustodias`
- `ocorrenciacontrato`
- `documentoajusterateio`
- `renegociacaocontrato`
- `cancelamentoparcialtitulo`
- `reguacobranca`
- `descontoduplicata`
- `titulocoberturaconta`
- `lancamentoconta`
- `commonfeature.terceiros_lcdpr`
- `commonfeature.tipos_terceiros_lcdpr`
- `commonfeature.tipos_exploracao_imovel_lcdpr`
- `commonfeature.contratosorcamentospagar`

## Candidatos simples observados em analise recente

- cadastro bancario basico: familias `api_agencia*` e `api_banco*`
- `api_tipoconta*`
- `api_layoutimpressoracheque*`
- `relatorio_*` como extracao de leitura, se o objetivo for separar consultas sem mover as tabelas

## Candidatos que parecem modulares, mas exigem cuidado

- `chequecustodia*`

Motivo:

- o grupo e coeso, mas escreve em varios artefatos centrais, como `lancamentoscontas`, `baixas`, `rateiosfinanceiros` e historicos

## Checklist de extracao

1. Confirmar pelo menos 3 camadas presentes.
2. Identificar dependencias externas inevitaveis.
3. Medir se a API publica do modulo cabe em poucas interfaces/DTOs.
4. Validar se o build fica verde apos extracao incremental.
