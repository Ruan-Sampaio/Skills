# Skills

Este arquivo e o catalogo curto de descoberta de skills em `C:\@work\Skills`.
O `AGENTS.md` da raiz deve ler este arquivo no inicio de qualquer tarefa dentro de `C:\@work`.
Cada item abaixo diz quando usar a skill, quando nao usar e qual prioridade ela tem na combinacao com outras.

## Regras de leitura do catalogo
- Preferir sempre a skill mais especifica para a tarefa.
- Se houver mudanca em Delphi legado, combinar com `delphi-legado-guardrails`.
- Se houver mudanca estrutural no `nsjFinancas`, combinar com `nsjfinancas-padrao-projeto` ou `nsjfinancas-refactor-guardrails`.
- Quando uma skill de diagnostico identificar causa raiz e a correcao exigir outra skill mais especifica, trocar para a skill de execucao adequada.

## Atalhos de roteamento rapido
- `dpr`, `dproj`, `nsproj`, `commonfeature`, package, `F2046`, `F2613` -> verificar primeiro `nsjfinancas-refactor-guardrails`, `nsjfinancas-padrao-projeto`, `verificar-units-redundantes` ou `registrar-limpeza-modulos`
- bordero -> `migrar-bordero-package`
- saldo adiantamento com filtro de data ou divergencia tela/CSV -> `investigar-filtro-saldo-adiantamento`
- saldo adiantamento com estorno, quitacao, transferencia ou recalculo -> `financeiro-estorno-adiantamento-debug`
- regressao em function SQL de `financas` -> `forense-funcao-sql-financas`
- evoluir base local ou abrir log do `EvoluirBanco.bat` -> `bancos-evolucao-desktop`

## delphi-legado-guardrails
Path: `C:\@work\Skills\delphi-legado-guardrails\SKILL.md`
Use quando: houver manutencao ou revisao em Delphi VCL legado, especialmente em `erp-financas-servicos`.
Nao usar quando: a tarefa for puramente SQL ou operacional de banco sem alteracao Delphi.
Sinais de disparo: Delphi 10.1, VCL, `nsjFinancas`, GUID, ORM, `Windows-1252`, unit `.pas`, `.dfm`, `.dpr`, `.dproj`.
Repos mais comuns: `/financas-servicos`, `/components`, `/libraries`.
Prioridade: alta como guardrail de stack.

## nsjfinancas-padrao-projeto
Path: `C:\@work\Skills\nsjfinancas-padrao-projeto\SKILL.md`
Use quando: a tarefa envolver decisao arquitetural, contrato ERP/SQL, package, dependencia, `commonfeature`, `dpr`, `dproj` ou `nsproj` no `nsjFinancas`.
Nao usar quando: a tarefa for apenas depuracao localizada sem decisao estrutural.
Sinais de disparo: extracao de modulo, fronteira funcional, package, dependencia, relatorio SQL, consistencia entre ERP e SQL.
Repos mais comuns: `/financas-servicos`, `/bancos`.
Prioridade: alta como guardrail de projeto.

## nsjfinancas-refactor-guardrails
Path: `C:\@work\Skills\nsjfinancas-refactor-guardrails\SKILL.md`
Use quando: houver refactor estrutural no `nsjFinancas`, limpeza de referencias diretas, mitigacao de `F2046`, analise de packages ou revisao de risco antes de mover units.
Nao usar quando: a tarefa ja estiver claramente coberta por uma skill de execucao mais especifica e sem necessidade de guardrail estrutural.
Sinais de disparo: `F2046`, `F2613`, `commonfeature`, `package`, `DCCReference`, `DCC_UnitSearchPath`, `nsproj`.
Repos mais comuns: `/financas-servicos`.
Prioridade: alta como guardrail estrutural.

## verificar-units-redundantes
Path: `C:\@work\Skills\verificar-units-redundantes\SKILL.md`
Use quando: precisar auditar `nsjFinancas.dpr`, `nsjFinancas.dproj` e `build/xmls/nsjfinancas.nsproj.xml` para encontrar units candidatas a remocao.
Nao usar quando: a tarefa for definir modulo novo completo ou desenhar estrategia ampla de extracao.
Sinais de disparo: `uses`, `DCCReference`, `unit redundante`, `unit coberta por package`, `F2613`, `interface uses`, `implementation uses`.
Repos mais comuns: `/financas-servicos`.
Prioridade: muito alta quando a pergunta for sobre unit especifica.

## registrar-limpeza-modulos
Path: `C:\@work\Skills\registrar-limpeza-modulos\SKILL.md`
Use quando: precisar planejar migracao de modulo funcional inteiro de `financas.*` para package ou `commonfeature.*`.
Nao usar quando: a tarefa for apenas remover uma unit isolada ou depurar um erro SQL.
Sinais de disparo: modulo completo, browser, ficha, frame, controller, dao, dto, fronteira publica, ordem de migracao.
Repos mais comuns: `/financas-servicos`.
Prioridade: muito alta para planejamento de extracao por modulo.

## migrar-bordero-package
Path: `C:\@work\Skills\migrar-bordero-package\SKILL.md`
Use quando: a tarefa for especificamente extrair o fluxo de bordero para package proprio em `source/common`.
Nao usar quando: a tarefa for extracao de outro modulo ou apenas diagnostico generico do `nsjFinancas`.
Sinais de disparo: bordero, mover units de bordero, package de bordero, checkpoints de migracao, reduzir carga do compilador sem renomear units.
Repos mais comuns: `/financas-servicos`.
Prioridade: maxima quando o assunto for bordero.

## investigar-filtro-saldo-adiantamento
Path: `C:\@work\Skills\investigar-filtro-saldo-adiantamento\SKILL.md`
Use quando: o filtro de data do Extrato de Credito ou Saldo Adiantamento nao estiver sendo respeitado entre tela, controller, DAO e SQL.
Nao usar quando: a tarefa for apenas mapear status funcional do relatorio sem bug de filtro.
Sinais de disparo: filtro de data nao funciona, tela fora do periodo, divergencia entre Visualizar e CSV, `Saldo Adiantamento`, `Extrato de Credito`, `current_setting`.
Repos mais comuns: `/financas-servicos`, `/bancos`.
Prioridade: maxima para bug de filtro nesse fluxo.

## relatorio-saldo-credito-status
Path: `C:\@work\Skills\relatorio-saldo-credito-status\SKILL.md`
Use quando: precisar levantar o estado atual dos artefatos ERP e SQL do relatorio de saldo de credito e listar o que falta.
Nao usar quando: a tarefa ja for uma correcao pontual claramente localizada.
Sinais de disparo: sintetico, simplificado, analitico, status do relatorio, paridade tela e CSV, lacunas ERP/SQL, proxima etapa de entrega.
Repos mais comuns: `/financas-servicos`, `/bancos`.
Prioridade: muito alta para consolidacao de status.

## financeiro-estorno-adiantamento-debug
Path: `C:\@work\Skills\financeiro-estorno-adiantamento-debug\SKILL.md`
Use quando: houver divergencia de saldo, situacao ou recalculo em titulo de credito adiantado apos estorno, quitacao ou transferencia.
Nao usar quando: o problema for apenas filtro de relatorio ou migracao de package.
Sinais de disparo: `id_titulo_estorno`, `tipoestorno`, `saldoadiantamento`, `Em Debito`, `financas.atualiza_titulosadiantamentos`, titulo adiantado.
Repos mais comuns: `/financas-servicos`, `/bancos`.
Prioridade: maxima para bug de estorno em adiantamento.

## forense-funcao-sql-financas
Path: `C:\@work\Skills\forense-funcao-sql-financas\SKILL.md`
Use quando: uma function SQL de `financas` antes funcionava e parou, ou quando for necessario descobrir o commit provavel da regressao e validar a definicao ativa no banco.
Nao usar quando: a tarefa for apenas evoluir a base ou criar script novo sem investigacao historica.
Sinais de disparo: regressao SQL, historico Git da function, definicao ativa no banco, comparar commits, provar mudanca de comportamento.
Repos mais comuns: `/bancos`, `/financas-servicos`.
Prioridade: maxima para forense de function SQL.

## bancos-evolucao-desktop
Path: `C:\@work\Skills\bancos-evolucao-desktop\SKILL.md`
Use quando: precisar executar `EvoluirBanco.bat`, atualizar base local, localizar scripts gerados ou abrir log de erro da evolucao.
Nao usar quando: a tarefa for analise funcional de regra de negocio ou diagnostico de codigo Delphi.
Sinais de disparo: evoluir banco, `EvoluirBanco.bat`, `criaBancoErros.log`, atualizar base local, `acofer`, scripts gerados em `C:\@work\bancos\desktop\Scripts`.
Repos mais comuns: `/bancos`.
Prioridade: maxima para operacao de evolucao de banco.
