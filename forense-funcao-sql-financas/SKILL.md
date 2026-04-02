---
name: forense-funcao-sql-financas
description: Rastreia regressao em function SQL de `financas` a partir de historico Git e validacao no banco atual. Use quando algo antes funcionava e parou, quando houver suspeita de mudanca em script SQL, quando for necessario apontar o commit provavel da quebra, ou quando precisar separar problema de codigo aplicativo de problema na definicao SQL implantada.
---

# Forense Funcao Sql Financas

Executar este fluxo para descobrir qual mudanca alterou comportamento de uma funcao SQL e qual impacto real isso traz no banco em uso.

## Fluxo

1. Ler [workflow.md](references/workflow.md).
2. Localizar o arquivo da funcao no repositorio de scripts de banco.
3. Levantar linha do tempo de commits da funcao.
4. Comparar diffs de comportamento (nao so diff textual).
5. Confirmar a definicao ativa no banco alvo.
6. Rodar teste controlado em transacao para provar impacto.
7. Rodar consulta de auditoria de vinculo de estorno: [auditoria-estorno.sql](references/auditoria-estorno.sql).
8. Entregar matriz `mudanca x efeito x risco`.

## Checklist de regressao legado

Aplicar obrigatoriamente em funcoes antigas que criam registros e depois atualizam vinculos.

1. Confirmar que o fluxo cria o novo registro via `API_*NOVO`.
2. Confirmar que o mesmo fluxo executa `UPDATE FINANCAS.TITULOS` para gravar `ID_TITULO_ESTORNO`.
3. Confirmar validacao pos-update no mesmo ramo:
   - `GET DIAGNOSTICS ... ROW_COUNT` igual a `1`;
   - releitura de `ID_TITULO_ESTORNO` para confirmar o id esperado.
4. Se nao houver essa validacao, classificar como `risco de inconsistencia silenciosa`.
5. Confirmar o mesmo comportamento nos dois sentidos de negocio (pagar/receber).

## Regras de forense

- Nao assumir que o banco executa o mesmo script que esta no Git.
- Validar a funcao ativa com `pg_get_functiondef`, `md5(prosrc)` e `length(prosrc)`.
- Para provas de impacto, usar `BEGIN` e `ROLLBACK`.
- Priorizar fontes primarias: script versionado, definicao ativa no banco e resultado de consulta.
- Em conclusao, separar: `quando mudou`, `o que mudou`, `como afeta`.

## Saida minima

- Commit ou janela de regressao mais provavel.
- Diferenca funcional entre versoes comparadas.
- Confirmacao da versao ativa no banco.
- Evidencia de impacto em dado real ou cenario reproduzivel.
- Risco de regressao colateral.
