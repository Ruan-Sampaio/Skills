# Workflow

## Objetivo

Provar a causa raiz de saldo ou situacao incorreta em titulo de credito adiantado apos estorno, quitacao, transferencia ou recalculo.

## Passos

1. Validar instancia e banco alvo.
   - `netstat -ano | findstr :543`
   - confirmar porta, banco e usuario antes de qualquer consulta.
2. Isolar o titulo correto por `id` e contexto.
   - usar `numero` apenas como apoio, nunca como chave unica.
   - cruzar `id_pessoa`, `id_estabelecimento`, `emissao`, `valor`.
3. Levantar evidencia de saldo e situacao.
   - `financas.titulos`: `saldoadiantamento`, `situacao`, `situacaotexto`, `id_titulo_estorno`, `tipoestorno`, `estorno`.
   - `financas.baixas`: soma por `id_titulo`.
   - `financas.adiantamentossaldos`: soma por `tituloadiantamento`.
4. Confirmar definicao das funcoes ativas no banco.
   - `financas.atualiza_titulosadiantamentos`
   - `financas.estornar_titulo`
   - extrair `md5(prosrc)` e `length(prosrc)` para auditoria rapida.
5. Validar o recalc em transacao.
   - rodar funcao dentro de `BEGIN` e finalizar com `ROLLBACK`.
   - comparar antes/depois sem persistir alteracao.
6. Validar regra de situacao para uso parcial de credito.
   - esperado: `situacao = 2` e `situacaotexto = 'Em Debito'` quando `valor_utilizado > 0` e `< valor_face`.
   - auditar `financas.atualiza_titulosadiantamentos` para garantir que atualiza saldo e situacao.
7. Rastrear fluxo no codigo.
   - Estorno de titulo: `Financas.DAO.TituloReceberEstorno` -> `FINANCAS.ESTORNAR_TITULO`.
   - Estorno por lancamento: `TSistemaLancamentoConta.EstornarSaldoAdiantamento`.
   - Uso de credito/transferencia: procurar `UPDATE ... saldoadiantamento` e preferir recalc central.
8. Aplicar check de integridade pos-estorno na funcao SQL.
   - apos `API_TITULO*NOVO`, validar `UPDATE` do original com `ROW_COUNT = 1`.
   - reler `id_titulo_estorno` e confirmar igualdade com o id criado.
   - se ausente no script, classificar como risco de inconsistencia silenciosa.
9. Classificar causa.
   - vinculo de estorno ausente (`id_titulo_estorno` nulo);
   - `tipoestorno` incorreto para o caso;
   - fluxo que atua em lancamento mas nao sincroniza campos do titulo;
   - fluxo de uso de credito que atualiza saldo manualmente e nao recalcula situacao;
   - regra de recalc alterada e dados legados nao normalizados.

## Checklist de saida

- Titulo analisado com `id`.
- Consulta de prova (SQL) com resultado relevante.
- Trecho de codigo com caminho e linha.
- Causa raiz em linguagem objetiva.
- Observacao de risco para casos semelhantes.
