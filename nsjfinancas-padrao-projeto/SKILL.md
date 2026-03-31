---
name: nsjfinancas-padrao-projeto
description: Padroniza decisoes de arquitetura no nsjFinancas para manter fronteira de modulo funcional, estrategia correta de package/dependencia e consistencia entre ERP e SQL. Use quando desenhar refactor, revisar proposta tecnica, avaliar impacto de extracao de modulo, alinhar contrato de funcoes SQL de relatorio, ou definir guardrails antes de mudar dpr/dproj/nsproj.
---

# NSJFinancas Padrao de Projeto

Aplicar esta skill antes de implementar mudancas estruturais no `nsjFinancas`.

## Fluxo

1. Ler [standards.md](references/standards.md).
2. Ler [checklist.md](references/checklist.md).
3. Classificar a mudanca: `modulo`, `dependencia`, `relatorio_sql`, `build`.
4. Validar a mudanca contra os guardrails do tipo classificado.
5. Produzir decisao tecnica com risco, impacto e ordem de execucao.
6. Aplicar em lote pequeno e exigir build completo.

## Regras

- Definir modulo por dominio funcional completo, nao por pasta tecnica.
- Preferir dependencia de package a aumentar `DCC_UnitSearchPath`.
- Tratar unit como candidata ate build validar.
- Manter assinatura de funcoes SQL estavel quando o layout ERP depende de campos fixos.
- Registrar diferenca entre `layout usa campo` e `funcao retorna campo`.

## Saida minima

- `decisao_tecnica`
- `alternativas_descartadas`
- `riscos`
- `plano_em_lotes`
- `validacao_pos_mudanca`
