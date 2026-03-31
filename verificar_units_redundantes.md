# verificar_units_redundantes

## Objetivo
Analisar `nsjFinancas.dpr`/`nsjFinancas.dproj` contra `build/xmls/nsjfinancas.nsproj.xml` para detectar units cobertas por dependencia.

## Regra critica (aprendida)
Unit coberta por dependencia NAO pode ser removida automaticamente.
Antes de remover, executar build completo e validar search path/package.
Dependencia no `nsproj.xml` nao resolve `uses`; apenas ordena build.

## Limitador real
`DCC_UnitSearchPath` muito longo estoura o limite do `dcc` (linha de comando).
Evitar expandir paths; prefira packages/dependencias.

## Fluxo recomendado
1. Mapear `projectName -> projectPath` por `build/xmls/*.nsproj.xml`.
2. Ler dependencias de `build/xmls/nsjfinancas.nsproj.xml`.
3. Extrair units do `.dpr` (bloco `uses`) e do `.dproj` (`DCCReference`).
4. Resolver arquivo `.pas` e projeto dono da unit.
5. Marcar apenas como `candidata` (nao remover ainda).
6. Gerar CSV com `unit`, `projetoDono`, `eDependencia`, `eCandidata`.
7. Remover em lote pequeno e rodar build.

## Caso conhecido
As units abaixo aparecem como cobertas por dependencia (`nsjchequeimplementacao`), mas a remocao quebrou build:
- `SchtNS20`
- `CheqDef`
- `chqDLLS`
Erro observado: `F2613 Unit 'chqDLLS' not found`.

## Saidas esperadas
- lista de candidatas
- plano de remocao incremental
- resultado do build apos cada lote
