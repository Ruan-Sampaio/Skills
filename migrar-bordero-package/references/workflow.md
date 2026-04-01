# Workflow de migracao (bordero)

## Fase 0 - Inventario

1. Mapear units de bordero no `nsjFinancas.dpr` e `nsjFinancas.dproj`.
2. Classificar por grupo:
   - nucleo (`units/sistemaBorderoEletronico/*` sem UI)
   - UI (`uFrm*`, `uFrame*`, `uDM*`)
   - relatorios e integrações
3. Confirmar dependencias ja existentes no `nsproj`.

## Fase 1 - Package scaffolding

1. Criar pasta em `source/common/<package-bordero>/package`.
2. Criar `.dpr/.dproj` do package com primeiro lote pequeno.
3. Ajustar search path do package, nao do projeto principal.

## Fase 2 - Migracao do nucleo

1. Mover lote pequeno de units de nucleo.
2. Atualizar `Include` no `.dproj` do package.
3. Adicionar dependencia no `nsjfinancas.nsproj.xml`.
4. Remover as mesmas units do `nsjFinancas.dpr/.dproj`.

## Fase 3 - Migracao de UI

1. Mover forms/frames/datamodules com seus `.dfm`.
2. Validar resources e formularios no package.
3. Remover referencias equivalentes do projeto principal.

## Fase 4 - Dieta final

1. Remover caminhos legados do `DCC_UnitSearchPath` no `nsjFinancas.dproj`.
2. Manter apenas o necessario para codigo realmente local.
3. Priorizar dependencia de package em vez de expandir path.

## Regra de rollback

- Se um lote quebrar, reverter apenas o lote da fase atual.
- Nao misturar rollback com novas mudancas no mesmo commit/lote.
