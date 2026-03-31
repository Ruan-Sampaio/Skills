# Workflow

## Objetivo

Analisar `nsjFinancas.dpr` e `nsjFinancas.dproj` contra `build/xmls/nsjfinancas.nsproj.xml` para detectar units possivelmente redundantes sem assumir que a dependencia resolve o compilador.

## Procedimento

1. Mapear `projectName -> projectPath` pelos `build/xmls/*.nsproj.xml`.
2. Ler dependencias declaradas em `build/xmls/nsjfinancas.nsproj.xml`.
3. Extrair units do bloco `uses` do `.dpr`.
4. Extrair `DCCReference` do `.dproj`.
5. Resolver o arquivo `.pas` e o projeto dono de cada unit.
6. Marcar a unit como candidata apenas se houver evidencias de cobertura por package/dependencia.
7. Propor remocao em lote pequeno.
8. Rodar build completo.
9. Se quebrar, restaurar o lote e registrar a causa.

## Guardrails

- Dependencia no `nsproj.xml` nao resolve `uses`; ela so ajuda na ordem de build.
- `DCC_UnitSearchPath` longo demais pode estourar o limite do `dcc`.
- Se a unit ja existe em package, preferir dependencia de package.
- Se a unit for necessaria so por compatibilidade, avaliar `DCC_UnitAlias` antes de criar gambiarra.

## Caso conhecido

As units abaixo apareciam como cobertas por `nsjchequeimplementacao`, mas a remocao quebrou o build:

- `SchtNS20`
- `CheqDef`
- `chqDLLS`

Erro observado:

- `F2613 Unit 'chqDLLS' not found`
