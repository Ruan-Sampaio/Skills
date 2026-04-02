---
name: migrar-bordero-package
description: Guia especializado para extrair o fluxo de bordero para package proprio em `source/common`, mantendo os nomes das units e migrando em fases de baixo risco. Use quando a tarefa for especificamente mover units de bordero do `nsjFinancas.dpr/.dproj`, registrar dependencia no `nsproj` e enxugar `DCC_UnitSearchPath`; nao use para extracao generica de outros modulos.
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
- Criar package novo para bordero; nao reutilizar o package `bancosbordero`.
- Sempre mover `.pas` junto com `.dfm` quando existir form/frame/datamodule.
- Nao remover em massa do `dpr/.dproj`; usar lotes pequenos por fase.
- Toda migracao deve fechar o trio:
  1. package novo ou atualizado contem as units
  2. `build/xmls/nsjfinancas.nsproj.xml` contem a dependencia
  3. `nsjFinancas.dpr` e `nsjFinancas.dproj` removem as units migradas
- Dependencia no `nsproj` so controla ordem de build; unit fora do package ainda precisa estar resolvida por package/projeto/search path.
- Antes de cada fase, checar risco de dependencia circular entre o package de bordero e packages ja existentes.
- Se o build quebrar durante a migracao, seguir esta ordem obrigatoria:
  1. Verificar se a unit ja pertence a algum package; se pertencer, adicionar esse package como dependencia no XML do package de bordero.
  2. Verificar se a unit (ou a causa da quebra) pode ser trazida para dentro do package de bordero sem duplicar metodos.
  3. Usar `DCC_UnitSearchPath` apenas como ultimo caso, depois de verificar outras alternativas.

## Resultado minimo esperado

- Lista de units migradas na fase.
- Diff de `dpr/.dproj/nsproj`.
- Checkpoint preenchido para retomada.
