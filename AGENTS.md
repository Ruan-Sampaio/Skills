# AGENTS.md

## Escopo
Este arquivo define o roteamento especifico para o repositorio `C:\@work\erp-financas-servicos`.
Ele complementa `C:\@work\AGENTS.md` e deve ter prioridade quando a tarefa estiver neste repo.

## Leitura obrigatoria
- Ler tambem `C:\@work\AGENTS.md`.
- Ler `C:\@work\Skills\Skills.md` no inicio da tarefa.
- Selecionar automaticamente a skill mais especifica aplicavel.

## Stack e contexto fixo
- Stack principal: Delphi legado
- Versao alvo: Delphi 10.1 Berlin
- Tipo de projeto: VCL Desktop
- Encoding dominante: `Windows-1252`
- Projeto central mais sensivel nesta base:
  - `build/xmls/nsjfinancas.nsproj.xml`
  - `source/projects/controller/source/controller/nsjFinancas.dpr`
  - `source/projects/controller/source/controller/nsjFinancas.dproj`

## Roteamento padrao de skills
- Sempre que houver edicao Delphi, aplicar `delphi-legado-guardrails`.
- Se a tarefa for buildar, compilar ou gerar executavel neste repo, aplicar `build-erp-workspace`.
- Se a tarefa envolver `nsjFinancas`, `dpr`, `dproj`, `nsproj`, package, `commonfeature`, `DCCReference`, `DCC_UnitSearchPath`, `F2046` ou `F2613`, aplicar tambem:
  - `nsjfinancas-padrao-projeto` para decisao arquitetural
  - `nsjfinancas-refactor-guardrails` para execucao de refactor e limpeza real
- Se a tarefa for sobre unit isolada, `uses` ou `DCCReference`, preferir `verificar-units-redundantes`.
- Se a tarefa for sobre modulo completo, fronteira funcional ou ordem de migracao, preferir `registrar-limpeza-modulos`.
- Se a tarefa for especificamente sobre bordero, usar `migrar-bordero-package`.
- Se a tarefa mencionar Extrato de Credito, Saldo Adiantamento, filtro de data ou divergencia entre Visualizar e CSV, usar `investigar-filtro-saldo-adiantamento`.
- Se a tarefa mencionar saldo incorreto apos estorno, quitacao, transferencia, `id_titulo_estorno`, `tipoestorno` ou `Em Debito`, usar `financeiro-estorno-adiantamento-debug`.
- Se a tarefa for levantar o que existe versus o que falta no relatorio de saldo de credito, usar `relatorio-saldo-credito-status`.

## Ordem de combinacao recomendada
1. `delphi-legado-guardrails`
2. `nsjfinancas-padrao-projeto` ou `nsjfinancas-refactor-guardrails`, conforme o caso
3. skill especifica da tarefa

## Regras locais
- Priorizar alteracao minima e de baixo risco.
- Preservar encoding fisico dos arquivos.
- Nao introduzir recurso de Delphi mais novo que 10.1.
- Nao alterar assinatura publica sem necessidade explicita.
- Em build normal, nao usar `clean` a menos que o usuario tenha pedido explicitamente.
- Em mudancas estruturais, preferir package e dependencia correta a expandir `DCC_UnitSearchPath`.
- Em tarefas ligadas a build pesado, considerar que `F2046` e limitador real do projeto.

## Banco e SQL neste repo
- Quando a tarefa tocar scripts SQL ou function SQL de `financas`, manter compatibilidade com PostgreSQL 9.3.
- Nao introduzir `jsonb`, `to_jsonb`, `jsonb_*` ou `FILTER (...)`.
- Scripts de banco deste ecossistema devem ficar em `C:\@work\bancos\desktop\Scripts`.
- Se a demanda for forense de regressao SQL, combinar com a skill `forense-funcao-sql-financas`.

## Postura esperada
- Atuar como mantenedor senior de ERP legado.
- Separar claramente diagnostico, proposta e patch aplicado.
- Em caso de ambiguidade entre duas skills, preferir a mais especifica pelo sintoma do problema.
