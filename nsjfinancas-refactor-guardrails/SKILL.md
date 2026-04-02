---
name: nsjfinancas-refactor-guardrails
description: Regras e workflow operacional para refatorar `nsjFinancas` com seguranca e previsibilidade. Use quando a tarefa envolver referencias diretas no `dpr/dproj`, impacto real de dependencias no `nsproj.xml`, mitigacao de `F2046`, `F2613`, search path ou execucao de extracoes para `commonfeature`; combine com skills mais especificas quando o modulo ou sintoma ja estiver claro.
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
   - [migrar-units-package-incremental](..\migrar-units-package-incremental\SKILL.md)
   - [investigar-filtro-saldo-adiantamento](..\investigar-filtro-saldo-adiantamento\SKILL.md)
   - [relatorio-saldo-credito-status](..\relatorio-saldo-credito-status\SKILL.md)
   - [nsjfinancas-padrao-projeto](..\nsjfinancas-padrao-projeto\SKILL.md)
5. Gerar analise em tabela objetiva com candidatas e justificativa.
6. Antes de criar package novo (`.dpr/.dproj`), validar se existe dependencia circular de codigo entre modulo candidato e modulo consumidor.
7. Se houver risco de ciclo, quebrar primeiro o acoplamento por contrato minimo (ex.: depender de tipo base comum) e somente depois criar/ligar package.
8. Aplicar alteracoes em lote pequeno.
9. Rodar build isolado por package antes de build amplo quando houver `F2046`.
10. Rodar build completo apos cada lote viavel.

## Regras de decisao

- Nunca remover unit apenas porque pertence a dependencia no `nsproj`.
- Tratar como candidata ate build validar.
- Definir modulo por dominio funcional transversal, nao por pasta tecnica isolada.
- Priorizar packages em modulos com multiplas camadas coesas e baixo acoplamento externo.
- Para extracao de `financas`, priorizar primeiro blocos de cadastro ou leitura com baixo acoplamento.
- Quando houver impacto em SQL, herdar as restricoes do projeto: `PostgreSQL 9.3`, sem `jsonb`, sem `to_jsonb` e sem `FILTER (...)`.
- Se o build falhar por unit faltando, verificar primeiro se a unit ja existe em package antes de mover novo bloco de codigo.

## Regras de dependencia

- Dependencia no `nsproj.xml` garante ordem de build, mas nao resolve `uses` do compilador.
- Dependencia no `nsproj.xml` nao "puxa" unit solta; o compilador so resolve unit visivel no projeto/package ou no `DCC_UnitSearchPath`.
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
- Antes de extrair modulo para package novo, validar dependencias cruzadas para evitar ciclo entre packages.
- Se o modulo A usa unit de B e B usa unit de A, tratar como ciclo de origem; quebrar esse acoplamento antes de concluir extracao.
- Evitar mover unit de dominio sem necessidade so para fechar ciclo; priorizar reduzir acoplamento por interface/tipo base compartilhado.

## Padrao de GUID

- Sempre seguir o padrao do projeto para conversao/validacao de GUID em `E:\Nasajon\ManipulaçãoGuid.txt`.
- Evitar `TryStringToGUID` no fluxo legado de `financas/common`; preferir `TManipuladorGUID.*` (`IsValidGuid`, `FromString`, `EmptyGuid`).

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
- Quando aparecer cascata de `F2613`, tratar por grupo funcional (pasta/modulo) e decidir rapido: adicionar package/dependencia ou adicionar caminho temporario em lote.

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
