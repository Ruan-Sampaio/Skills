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
7. Se houver migracao para package, validar o trio:
   - dependencia do package no `build/xmls/nsjfinancas.nsproj.xml`
   - remocao da unit legada no `nsjFinancas.dpr`
   - remocao do `DCCReference` equivalente no `nsjFinancas.dproj`
8. Propor remocao em lote pequeno.
9. Rodar build completo.
10. Se quebrar, restaurar o lote e registrar a causa.

## Guardrails

- Dependencia no `nsproj.xml` nao resolve `uses`; ela so ajuda na ordem de build.
- Dependencia no `nsproj.xml` nao resolve unit solta fora do package/projeto; para compilar, a unit precisa estar em package dependente, no projeto atual ou no `DCC_UnitSearchPath`.
- Se o `dpr/dproj` principal ainda lista unit legada, tratar como migracao incompleta, mesmo com package criado.
- `DCC_UnitSearchPath` longo demais pode estourar o limite do `dcc`.
- Se a unit ja existe em package, preferir dependencia de package.
- Se a unit for necessaria so por compatibilidade, avaliar `DCC_UnitAlias` antes de criar gambiarra.
- Em cascata de `F2613`, corrigir por lote funcional (mesma pasta/modulo) para reduzir tentativa e erro unit a unit.
- Antes de extrair modulo para package novo, checar se nao cria dependencia circular entre packages.

## Caso conhecido

As units abaixo apareciam como cobertas por `nsjchequeimplementacao`, mas a remocao quebrou o build:

- `SchtNS20`
- `CheqDef`
- `chqDLLS`

Erro observado:

- `F2613 Unit 'chqDLLS' not found`
