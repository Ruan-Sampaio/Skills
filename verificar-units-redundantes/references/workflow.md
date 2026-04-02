# Workflow

## Objetivo

Analisar `nsjFinancas.dpr` e `nsjFinancas.dproj` contra `build/xmls/nsjfinancas.nsproj.xml` para detectar units possivelmente redundantes sem assumir que a dependencia resolve o compilador.

## Procedimento

1. Mapear `projectName -> projectPath` pelos `build/xmls/*.nsproj.xml`.
2. Ler dependencias declaradas em `build/xmls/nsjfinancas.nsproj.xml`.
3. Extrair units do bloco `uses ... begin` do `.dpr`, limpando comentarios `{...}` e tratando `in 'path\arquivo.pas'`.
4. Extrair `DCCReference` do `.dproj` e usar os nomes de arquivo como units.
5. Para cada unit, tentar localizar o `.pas`:
   - usar o path do `in '...'` quando existir
   - senao buscar por `UnitName.pas`
   - senao buscar pelo ultimo segmento do nome da unit
6. Determinar o projeto dono do arquivo comparando o caminho do `.pas` com o diretorio do `.dproj` de cada projeto mapeado.
7. Marcar a unit como candidata apenas se houver evidencias de cobertura por package ou dependencia.
8. Se houver migracao para package, validar o trio:
   - dependencia do package no `build/xmls/nsjfinancas.nsproj.xml`
   - remocao da unit legada no `nsjFinancas.dpr`
   - remocao do `DCCReference` equivalente no `nsjFinancas.dproj`
9. Validar referencia cruzada: package extraido nao deve depender de unit do modulo consumidor sem contrato estavel.
10. Gerar tabela ou CSV de analise, mas nao alterar automaticamente sem revisao.
11. Propor remocao em lote pequeno.
12. Rodar build completo.
13. Se quebrar, restaurar o lote e registrar a causa.

## Guardrails

- Dependencia no `nsproj.xml` nao resolve `uses`; ela so ajuda na ordem de build.
- Dependencia no `nsproj.xml` nao resolve unit solta fora do package ou projeto; para compilar, a unit precisa estar em package dependente, no projeto atual ou no `DCC_UnitSearchPath`.
- Se o `dpr/dproj` principal ainda lista unit legada, tratar como migracao incompleta, mesmo com package criado.
- `DCC_UnitSearchPath` longo demais pode estourar o limite do `dcc`.
- Se a unit ja existe em package, preferir dependencia de package.
- Se a unit for necessaria so por compatibilidade, avaliar `DCC_UnitAlias` antes de criar gambiarra.
- Em cascata de `F2613`, corrigir por lote funcional para reduzir tentativa e erro unit a unit.
- Antes de extrair modulo para package novo, checar se nao cria dependencia circular entre packages.
- Se aparecer ciclo entre package extraido e consumidor, quebrar acoplamento primeiro e so depois remover unit do `dpr/dproj`.

## Caso conhecido

As units abaixo apareciam como cobertas por `nsjchequeimplementacao`, mas a remocao quebrou o build:

- `SchtNS20`
- `CheqDef`
- `chqDLLS`

Erro observado:

- `F2613 Unit 'chqDLLS' not found`
