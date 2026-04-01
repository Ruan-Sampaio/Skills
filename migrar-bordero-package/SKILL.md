---
name: migrar-bordero-package
description: Guia para extrair o fluxo de bordero para package proprio em `source/common`, mantendo os nomes das units e migrando em fases de baixo risco. Use quando mover units de bordero do `nsjFinancas.dpr/.dproj`, registrar dependencia no `nsproj`, enxugar `DCC_UnitSearchPath`, e manter checkpoints para retomada quando o contexto acabar.
---

# Migrar Bordero para Package

Use esta skill quando a meta for reduzir carga do compilador no `nsjFinancas` movendo o fluxo de bordero para package separado, sem renomear units.

## Ordem obrigatoria

1. Ler [references/workflow.md](references/workflow.md).
2. Ler [references/escopo-units.md](references/escopo-units.md).
3. Executar uma fase por vez.
4. Ao fim de cada fase, registrar checkpoint em [references/checkpoint-template.md](references/checkpoint-template.md).

## Regras fixas

- Manter nome das units como estao.
- Pode mudar apenas localizacao fisica e referencias do projeto/package.
- Sempre mover `.pas` junto com `.dfm` quando existir form/frame/datamodule.
- Nao remover em massa do `dpr/.dproj`; usar lotes pequenos por fase.
- Toda migracao deve fechar o trio:
  1. package novo ou atualizado contem as units
  2. `build/xmls/nsjfinancas.nsproj.xml` contem a dependencia
  3. `nsjFinancas.dpr` e `nsjFinancas.dproj` removem as units migradas

## Resultado minimo esperado

- Lista de units migradas na fase.
- Diff de `dpr/.dproj/nsproj`.
- Checkpoint preenchido para retomada.
