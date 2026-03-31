---
name: verificar-units-redundantes
description: Audita `nsjFinancas.dpr`, `nsjFinancas.dproj` e `build/xmls/nsjfinancas.nsproj.xml` para encontrar units potencialmente redundantes sem quebrar o build. Use quando limpar `uses`, remover `DCCReference`, investigar erro `F2613`, validar se uma unit ja vem de package/dependencia, ou preparar uma remocao incremental com build obrigatorio.
---

# Verificar Units Redundantes

Executar este fluxo ao analisar units do `nsjFinancas` que parecem cobertas por dependencias, mas ainda podem ser exigidas pelo compilador no estado atual do projeto.

## Fluxo

1. Ler [workflow.md](references/workflow.md).
2. Mapear `projectName -> projectPath` a partir de `build/xmls/*.nsproj.xml`.
3. Ler dependencias de `build/xmls/nsjfinancas.nsproj.xml`.
4. Extrair units do `.dpr` e do `.dproj`.
5. Resolver qual projeto ou package contem cada unit.
6. Marcar a unit apenas como `candidata`.
7. Remover em lote pequeno e exigir build completo antes de prosseguir.

## Regras de decisao

- Nunca remover unit apenas porque ela aparece coberta por uma dependencia no `nsproj`.
- Tratar `nsproj` como ordem de build, nao como garantia de resolucao de `uses`.
- Preferir dependencia de package a expandir `DCC_UnitSearchPath`.
- Se uma remocao falhar com `F2613`, restaurar o lote e investigar search path, package dono e aliases.

## Saida minima

- Tabela ou CSV com `unit`, `arquivo_origem`, `projeto_dono`, `package_dono`, `e_dependencia`, `e_candidata`, `risco`.
- Lote proposto para remocao.
- Resultado do build apos cada lote.
