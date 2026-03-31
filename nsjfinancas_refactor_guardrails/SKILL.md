---
name: nsjfinancas-refactor-guardrails
description: Regras e workflow para refatorar nsjFinancas com seguranca. Use quando precisar analisar units redundantes no dpr/dproj, validar impacto de dependencias do nsproj, definir modulo funcional (dao/dto/browser/ficha/frame/controller/constantes) e priorizar candidatos a package sem quebrar o build.
---

# NSJFinancas Refactor Guardrails

Executar este fluxo quando houver mudancas em `nsjFinancas.dpr`, `nsjFinancas.dproj`, `build/xmls/nsjfinancas.nsproj.xml` ou proposta de package.

## Fluxo obrigatorio
1. Ler [project-pattern.md](references/project-pattern.md).
2. Ler [redundant-units-safety.md](references/redundant-units-safety.md) antes de sugerir/remover unit.
3. Ler [package-candidates.md](references/package-candidates.md) para identificar modulo funcional completo.
4. Gerar analise em CSV (candidatas + justificativa).
5. Aplicar alteracoes em lote pequeno.
6. Rodar build completo apos cada lote.

## Regras de decisao
- Nunca remover unit apenas porque pertence a dependencia no `nsproj`.
- Tratar como candidata ate build validar.
- Definir modulo por dominio funcional transversal, nao por pasta tecnica isolada.
- Priorizar packages em modulos com multiplas camadas coesas e baixo acoplamento externo.

## Regras de dependencia (aprendidas)
- Dependencia no `nsproj.xml` garante ordem de build, mas NAO resolve `uses` do compilador.
- Para resolver unit faltando, existem 3 vias:
  1. Colocar a unit no mesmo package/projeto.
  2. Criar/usar package separado e depender dele.
  3. Adicionar o caminho no `DCC_UnitSearchPath`.
- Se a unit ja existe em algum package:
  - adicionar a dependencia do package correspondente (evitar `UnitSearchPath` longo).
- Se a unit existe somente no `financas`:
  - avaliar criar um novo package com o modulo completo (dao/dto/browser/ficha/frame/controller/constantes etc).

## Limitadores de build
- `DCC_UnitSearchPath` muito longo estoura o limite de linha do `dcc`.
- Evitar adicionar dezenas de caminhos; prefira packages/dependencias.
- Se precisar de alias, use `DCC_UnitAlias` (ex.: `ComObj=System.Win.ComObj`) ao inves de criar unit de compatibilidade.

## Saida minima esperada
- lista de units candidatas + risco
- lista de modulos candidatos a package + camadas encontradas
- resultado de build apos mudancas
