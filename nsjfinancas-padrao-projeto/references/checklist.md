# Checklist

## Checklist de decisao

1. A mudanca preserva fronteira de modulo funcional?
2. A resolucao de unit foi tratada por package antes de search path?
3. Existe risco de quebra por contrato ERP x SQL?
4. O plano esta dividido em lotes pequenos?
5. Existe criterio objetivo de validacao apos cada lote?

## Template de saida

- `tipo_mudanca`: modulo | dependencia | relatorio_sql | build
- `alvo`: arquivo, funcao, package ou modulo
- `decisao`: fazer | adiar | fatiar
- `justificativa`: tecnica e objetiva
- `riscos`: compilacao, regressao funcional, acoplamento
- `mitigacoes`: build, smoke test, rollback de lote
- `proximo_lote`: primeira alteracao concreta
