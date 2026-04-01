---
name: relatorio-saldo-credito-status
description: Mapeia o estado atual dos artefatos ERP e SQL do relatorio de saldo de credito e aponta lacunas entre o que existe e o que ainda falta. Use quando precisar levantar formularios, browsers, controllers, DAOs, DTOs, scripts SQL, filtros e diferencas entre versoes sintetica, simplificada e analitica.
---

# Relatorio Saldo Credito Status

Executar este fluxo para diagnosticar cobertura atual do relatorio de saldo de credito antes de codar ou corrigir.

## Fluxo

1. Ler [workflow.md](references/workflow.md).
2. Listar artefatos ERP relacionados.
3. Listar scripts SQL, functions e views envolvidos.
4. Confirmar parametros, filtros e ordenacao usados hoje.
5. Comparar o existente com o alvo esperado.
6. Registrar lacunas por prioridade e impacto.

## Regras de analise

- Separar claramente `existe`, `parcial` e `falta`.
- Distinguir artefato de UI, camada de aplicacao e camada SQL.
- Se houver mais de uma versao do relatorio, comparar comportamento e nao apenas nomes.
- Registrar caminho absoluto do artefato e papel de cada um.
- Na camada SQL, registrar explicitamente incompatibilidades com `PostgreSQL 9.3`.
- Tratar `jsonb`, `to_jsonb` e `FILTER (...)` como incompatibilidades objetivas.
- Nao marcar `json`, `json_array_elements` ou `LATERAL` como problema de versao por si so.

## Saida minima

- Tabela com `artefato`, `camada`, `status`, `origem`, `acao_recomendada`.
- Diferencas entre sintetico, simplificado e analitico.
- Pendencias ordenadas por impacto.
