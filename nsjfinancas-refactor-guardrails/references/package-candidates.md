# Package Candidates

## Candidatos com boa coesao

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

- cadastro bancario basico: `api_agencia*` e `api_banco*`
- `api_tipoconta*`
- `api_layoutimpressoracheque*`
- `relatorio_*` quando a separacao for apenas de leitura

## Candidatos coesos, mas nao simples

- `chequecustodia*`

Motivo:

- toca fluxos e tabelas centrais, como `lancamentoscontas`, `baixas`, `rateiosfinanceiros` e historicos

## Criterio

Priorizar modulo com:

1. pelo menos 3 camadas presentes
2. baixo acoplamento externo
3. build verde apos extracao incremental
