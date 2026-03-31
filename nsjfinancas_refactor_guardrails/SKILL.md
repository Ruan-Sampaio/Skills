---
name: nsjfinancas-refactor-guardrails
description: Regras e workflow para refatorar `nsjFinancas` com seguranca. Use quando precisar analisar units redundantes no `dpr/dproj`, validar impacto de dependencias do `nsproj`, definir fronteira de modulo funcional, priorizar candidatos a package, ou escolher extracoes de baixo risco a partir do schema `financas` sem quebrar build.
---

# NSJFinancas Refactor Guardrails

Executar este fluxo quando houver mudancas em `nsjFinancas.dpr`, `nsjFinancas.dproj`, `build/xmls/nsjfinancas.nsproj.xml`, proposta de package, ou plano de extracao de modulo.

## Fluxo obrigatorio

1. Ler [project-pattern.md](references/project-pattern.md).
2. Ler [redundant-units-safety.md](references/redundant-units-safety.md) antes de sugerir ou remover unit.
3. Ler [package-candidates.md](references/package-candidates.md) para identificar modulo funcional completo.
4. Se o trabalho for focado, preferir a skill especializada correspondente:
   - [verificar-units-redundantes](..\verificar-units-redundantes\SKILL.md)
   - [registrar-limpeza-modulos](..\registrar-limpeza-modulos\SKILL.md)
   - [investigar-filtro-saldo-adiantamento](..\investigar-filtro-saldo-adiantamento\SKILL.md)
   - [relatorio-saldo-credito-status](..\relatorio-saldo-credito-status\SKILL.md)
5. Gerar analise em CSV ou tabela objetiva com candidatas e justificativa.
6. Aplicar alteracoes em lote pequeno.
7. Rodar build completo apos cada lote.

## Regras de decisao

- Nunca remover unit apenas porque pertence a dependencia no `nsproj`.
- Tratar como candidata ate build validar.
- Definir modulo por dominio funcional transversal, nao por pasta tecnica isolada.
- Priorizar packages em modulos com multiplas camadas coesas e baixo acoplamento externo.
- Para extracao de `financas`, priorizar primeiro blocos de cadastro ou leitura com baixo acoplamento.

## Regras de dependencia

- Dependencia no `nsproj.xml` garante ordem de build, mas nao resolve `uses` do compilador.
- Para resolver unit faltando, existem 3 vias:
  1. colocar a unit no mesmo package ou projeto
  2. criar ou usar package separado e depender dele
  3. adicionar o caminho no `DCC_UnitSearchPath`
- Se a unit ja existe em package, preferir dependencia de package.
- Se a unit existe somente no `financas`, avaliar criar um package com o modulo completo.

## Limitadores de build

- `DCC_UnitSearchPath` muito longo estoura o limite de linha do `dcc`.
- Evitar adicionar dezenas de caminhos; prefira packages e dependencias.
- Se precisar de alias, usar `DCC_UnitAlias` em vez de criar unit de compatibilidade.

## Candidatos de menor risco observados

- familias `api_agencia*` e `api_banco*`
- `api_tipoconta*`
- `api_layoutimpressoracheque*`
- `relatorio_*` se a meta for separar leitura antes de mover tabelas

## Candidatos que exigem mais cuidado

- `chequecustodia*`, por tocar `lancamentoscontas`, `baixas`, `rateiosfinanceiros` e historicos

## Saida minima esperada

- lista de units candidatas com risco
- lista de modulos candidatos a package com camadas encontradas
- estrategia proposta por modulo: package existente, package novo ou adiar
- resultado de build apos mudancas
