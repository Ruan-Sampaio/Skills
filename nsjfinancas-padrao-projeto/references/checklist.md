# Checklist

## Checklist de decisao

1. A mudanca preserva fronteira de modulo funcional?
2. A resolucao de unit foi tratada por package antes de search path?
3. Existe risco de quebra por contrato ERP x SQL?
4. O plano esta dividido em lotes pequenos?
5. Existe criterio objetivo de validacao apos cada lote?
6. A alteracao manteve `Windows-1252` sem corromper caracteres?
7. Numeros magicos foram movidos para `constantes`?
8. Componente novo respeita padrao `TCX`?
9. Se houve cast de GUID, foi usado o guia `E:\Nasajon\ManipulacaoGuid.txt`?
10. Se houve mudanca SQL, ela continua compativel com `PostgreSQL 9.3`?
11. A mudanca SQL evitou `jsonb`, `to_jsonb` e `FILTER (...)`?

## Template de saida

- `tipo_mudanca`: modulo | dependencia | relatorio_sql | build
- `alvo`: arquivo, funcao, package ou modulo
- `decisao`: fazer | adiar | fatiar
- `justificativa`: tecnica e objetiva
- `riscos`: compilacao, regressao funcional, acoplamento
- `mitigacoes`: build, smoke test, rollback de lote
- `proximo_lote`: primeira alteracao concreta
