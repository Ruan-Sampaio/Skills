---
name: nsjfinancas-refactor-guardrails
description: Regras e workflow para refatorar `nsjFinancas` com seguranca. Use quando precisar analisar units redundantes no `dpr/dproj`, validar impacto de dependencias do `nsproj`, definir fronteira de modulo funcional, priorizar candidatos a package, mitigar `F2046 Out of memory` no Delphi Win32, ou escolher extracoes de baixo risco a partir do schema `financas` sem quebrar build.
---

# NSJFinancas Refactor Guardrails

Executar este fluxo quando houver mudancas em `nsjFinancas.dpr`, `nsjFinancas.dproj`, `build/xmls/nsjfinancas.nsproj.xml`, proposta de package, plano de extracao de modulo, ou falha de build com `F2046`.

## Fluxo obrigatorio

1. Ler [project-pattern.md](references/project-pattern.md).
2. Ler [redundant-units-safety.md](references/redundant-units-safety.md) antes de sugerir ou remover unit.
3. Ler [package-candidates.md](references/package-candidates.md) para identificar modulo funcional completo.
4. Se o trabalho for focado, preferir a skill especializada correspondente:
   - [verificar-units-redundantes](..\verificar-units-redundantes\SKILL.md)
   - [registrar-limpeza-modulos](..\registrar-limpeza-modulos\SKILL.md)
   - [investigar-filtro-saldo-adiantamento](..\investigar-filtro-saldo-adiantamento\SKILL.md)
   - [relatorio-saldo-credito-status](..\relatorio-saldo-credito-status\SKILL.md)
   - [nsjfinancas-padrao-projeto](..\nsjfinancas-padrao-projeto\SKILL.md)
5. Gerar analise em CSV ou tabela objetiva com candidatas e justificativa.
6. Aplicar alteracoes em lote pequeno.
7. Rodar build completo apos cada lote.

## Regras de decisao

- Nunca remover unit apenas porque pertence a dependencia no `nsproj`.
- Tratar como candidata ate build validar.
- Definir modulo por dominio funcional transversal, nao por pasta tecnica isolada.
- Priorizar packages em modulos com multiplas camadas coesas e baixo acoplamento externo.
- Para extracao de `financas`, priorizar primeiro blocos de cadastro ou leitura com baixo acoplamento.
- Quando houver impacto em SQL, herdar as restricoes do projeto: `PostgreSQL 9.3`, sem `jsonb`, sem `to_jsonb` e sem `FILTER (...)`.

## Regras de dependencia

- Dependencia no `nsproj.xml` garante ordem de build, mas nao resolve `uses` do compilador.
- Em migracao para package, validar sempre o trio:
  1. `build/xmls/nsjfinancas.nsproj.xml` contem `<dependencia>` do package
  2. `nsjFinancas.dpr` removeu as units legadas equivalentes
  3. `nsjFinancas.dproj` removeu os `DCCReference` equivalentes
- Se o package foi criado, mas o `dpr/dproj` principal ainda lista as units `u*` legadas, o compilador continua puxando o caminho antigo.
- Para resolver unit faltando, existem 3 vias:
  1. colocar a unit no mesmo package ou projeto
  2. criar ou usar package separado e depender dele
  3. adicionar o caminho no `DCC_UnitSearchPath`
- Se a unit ja existe em package, preferir dependencia de package.
- Se a unit existe somente no `financas`, avaliar criar um package com o modulo completo.

## Mitigacao de F2046 (Win32)

- Tratar `F2046` como limite de memoria do `dcc32`, nao apenas falta de RAM da maquina.
- 1º remover units desnecessarias no `uses` (principalmente em units de alto fan-out como `browser base`, `controller base`, `dao base`).
- 2º limpar o `interface uses`: manter apenas dependencias exigidas por assinaturas publicas, heranca e tipos de campo/propriedade; mover o restante para `implementation uses`.
- Em blocos `{$IFDEF}`, validar separadores para evitar virgula orfa.
- Em arquivos com `uses` muito longos, validar itens inline no mesmo trecho (`, UnitX, UnitY,`) antes de remover; remocao so por inicio de linha pode deixar lixo.
- Executar build completo a cada lote e registrar a unit alvo do erro na IDE quando houver.

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
