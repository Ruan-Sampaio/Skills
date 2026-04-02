---
name: migrar-units-package-incremental
description: Executa migracao incremental de units para package em Delphi legado, movendo uma unit por vez e validando build a cada passo. Use quando houver pedidos de extracao gradual com controle de risco, rollback da ultima unit e limite para expansao de DCC_UnitSearchPath.
---

# Migrar Units Package Incremental

Use esta skill quando a tarefa exigir mover units para package com validacao forte por etapa.

## Fluxo

1. Ler [migration-checklist.md](references/migration-checklist.md).
2. Definir ordem da migracao: primeiro units de interface/DTO e baixo acoplamento; depois ficheiros com controller/browser/ficha.
3. Antes de mover, registrar o estado atual (`git status --short`) e confirmar os arquivos-alvo.
4. Mover apenas 1 unit por vez.
5. Ajustar referencias minimas do passo:
   - `dpr`/`dproj` dos consumidores
   - `dpr`/`dproj` do package de destino
6. Rodar build isolado do package logo apos o passo.
7. Se build falhar, coletar causa raiz no log e fazer rollback apenas da unit movida no passo atual.
8. Seguir para a proxima unit apenas apos build verde.

## Regras de decisao

- Nao mover mais de uma unit por ciclo.
- Nao misturar refactor estrutural amplo com migracao incremental.
- Evitar crescimento de `DCC_UnitSearchPath`; preferir dependencia de package e ajustes locais.
- Se a correcao exigir muitos paths novos no `DCC_UnitSearchPath`, parar e consultar o usuario.
- Em erro de compilacao, tratar primeiro a causa real no log (`F2613`, `F2046`) antes de tentar nova movimentacao.
- Manter patch minimo e reversivel.

## Saida minima

- Unit movida no passo atual.
- Arquivos alterados no passo atual.
- Resultado do build.
- Em falha: causa raiz e status do rollback da ultima unit.
