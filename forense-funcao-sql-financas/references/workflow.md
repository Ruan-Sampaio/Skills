# Workflow

## Objetivo

Determinar qual alteracao de funcao SQL causou regressao funcional e comprovar impacto no banco atual.

## Passos

1. Localizar o script da funcao.
   - procurar em `C:\@work\bancos\desktop\Scripts\functions`.
   - mapear nome, caminho e dependencias diretas.
2. Levantar historico da funcao.
   - `git rev-list HEAD -- <arquivo>`
   - `git show -s --format="%h|%ad|%an|%s" --date=short <sha...>`
3. Comparar comportamento entre versoes.
   - `git show <sha> -- <arquivo>`
   - destacar mudancas de regra, joins, filtros, agregacoes e atualizacoes.
4. Confirmar funcao ativa no banco.
   - consultar `pg_proc` + `pg_namespace`.
   - capturar `md5(prosrc)` e `length(prosrc)`.
5. Reproduzir impacto em ambiente controlado.
   - executar consulta antes/depois em `BEGIN`.
   - chamar funcao e validar resultado.
   - finalizar com `ROLLBACK`.
6. Aplicar checklist legado de integridade transacional.
   - localizar trecho `API_*NOVO` seguido de `UPDATE FINANCAS.TITULOS`.
   - exigir `ROW_COUNT = 1` e releitura do campo atualizado no mesmo fluxo.
   - sem isso, marcar potencial de inconsistencia silenciosa.
7. Rodar auditoria de base para medir abrangencia.
   - executar [auditoria-estorno.sql](auditoria-estorno.sql).
   - separar resultado por tipo de anomalia.
8. Correlacionar com camada aplicacao.
   - localizar chamadas da funcao no codigo Delphi.
   - validar se contrato da chamada mudou junto com SQL.
9. Consolidar conclusao.
   - mudanca candidata principal.
   - evidencia tecnica.
   - risco e abrangencia.

## Matriz recomendada

Preencher para cada mudanca relevante:

- `sha`
- `data`
- `mudanca_de_regra`
- `efeito_observado`
- `caminho_de_execucao_afetado`
- `risco_colateral`

## Criterio de prova forte

Somente considerar causa raiz fechada quando os tres pontos baterem:

1. diff funcional em commit identificado;
2. mesma regra presente na funcao ativa do banco;
3. resultado de consulta reproduzivel no cenario afetado.
