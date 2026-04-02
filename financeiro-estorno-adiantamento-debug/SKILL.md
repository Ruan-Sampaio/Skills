---
name: financeiro-estorno-adiantamento-debug
description: Diagnostica divergencia de saldo e situacao em titulos de credito adiantados apos estorno, quitacao, transferencia ou recalculo. Use quando o usuario relatar saldo incorreto, situacao inconsistente (ex.: deveria ficar Em Debito), ou quando for necessario confirmar se a causa raiz esta no fluxo de estorno, no vinculo id_titulo_estorno, no tipoestorno, em atualizacoes manuais de saldoadiantamento, ou na funcao financas.atualiza_titulosadiantamentos.
---

# Financeiro Estorno Adiantamento Debug

Executar este fluxo para identificar causa raiz com evidencia em banco e codigo, sem aplicar remendo antes do diagnostico.

## Fluxo

1. Ler [workflow.md](references/workflow.md).
2. Confirmar ambiente de banco e evitar erro por instancia errada (`5432` vs `5433`).
3. Identificar o titulo por `id` e nao apenas por `numero`.
4. Coletar evidencia de dados (`saldoadiantamento`, `situacao`, `situacaotexto`, `id_titulo_estorno`, `tipoestorno`, baixas e estorno gerado).
5. Executar o playbook de `inconsistencia silenciosa` no fluxo de estorno.
6. Executar o playbook de `regularizar situacao de titulo de credito` quando houver uso parcial.
7. Validar a formula de recalculo efetiva no banco.
8. Rastrear o fluxo no codigo e separar:
   - fluxo de estorno de titulo (`financas.estornar_titulo`);
   - fluxo de estorno por lancamento (`EstornarSaldoAdiantamento`);
   - fluxos de uso/transferencia de credito que alteram `adiantamentossaldos`.
9. Classificar causa raiz e registrar evidencias com arquivo, linha e consulta.

## Playbook: Inconsistencia silenciosa

Aplicar quando o usuario relata que o estorno foi criado, mas o saldo de credito continua incorreto.

1. Localizar o ponto de criacao do estorno (`API_TITULORECEBERNOVO` ou `API_TITULOPAGARNOVO`).
2. Verificar se, em seguida, existe `UPDATE FINANCAS.TITULOS` preenchendo `ID_TITULO_ESTORNO`.
3. Exigir validacao transacional apos o `UPDATE`:
   - `GET DIAGNOSTICS ... ROW_COUNT` igual a `1`;
   - releitura do `ID_TITULO_ESTORNO` gravado no titulo original.
4. Se o valor gravado estiver nulo ou diferente do id criado, o fluxo deve fazer `RAISE EXCEPTION`.
5. Confirmar que a regra existe nos dois ramos (`sinal = 1` e `sinal <> 1`).

## Playbook: Regularizar situacao de titulo de credito

Aplicar quando o saldo do credito esta correto, mas a situacao do titulo nao reflete uso parcial (deveria ficar `Em Debito`).

1. Confirmar se houve uso parcial real do credito.
   - calcular `valor_utilizado` no titulo adiantado (soma em `adiantamentossaldos` e, se houver, valor do estorno vinculado).
   - comparar com valor de face (`valor` ou `valorbruto` conforme regra vigente no banco).
2. Validar o esperado de situacao.
   - se `valor_utilizado > 0` e `< valor_face`, esperado: `situacao = 2` e `situacaotexto = 'Em Debito'`;
   - se `valor_utilizado = 0` ou `>= valor_face`, esperado: `situacao = 1` e `situacaotexto = 'Quitado'`.
3. Auditar a funcao central no banco.
   - conferir se `financas.atualiza_titulosadiantamentos` atualiza nao apenas `saldoadiantamento`, mas tambem `situacao` e `situacaotexto` para titulos de adiantamento.
4. Buscar remendo manual nos fluxos de negocio.
   - localizar scripts/funcoes que fazem `UPDATE financas.titulos SET saldoadiantamento = ...` apos uso de credito.
   - classificar como risco quando o fluxo atualiza saldo sem chamar `financas.atualiza_titulosadiantamentos`.
5. Corrigir pela regra central.
   - substituir ajuste manual por acumulacao dos titulos afetados + chamada unica de `financas.atualiza_titulosadiantamentos(...)`.
6. Validar em homologacao com cenario minimo.
   - titulo de credito 5.000,00;
   - uso parcial 2.375,00;
   - resultado esperado: `saldoadiantamento` recalculado e `situacao = Em Debito`.

## Regras de investigacao

- Nao alterar dados sem pedido explicito.
- Para testes de impacto em banco, usar `BEGIN` e `ROLLBACK`.
- Priorizar prova objetiva antes de hipotese.
- Diferenciar problema de regra de calculo e problema de integridade de dados.
- Se houver numeros de titulo repetidos, sempre cruzar por `id_pessoa`, `id_estabelecimento`, `emissao` e `valor`.
- Quando citar datas relativas, registrar data absoluta.

## Causas comuns

- `id_titulo_estorno` ausente no titulo original.
- `tipoestorno` diferente do esperado para saldo restante de credito.
- Estorno realizado por fluxo que zera saldo de lancamento, mas nao vincula titulo de estorno.
- Fluxo de estorno sem validacao pos-`UPDATE`, permitindo sucesso parcial sem erro.
- Recalculo executado com dados inconsistentes, preservando saldo incorreto.
- Fluxo de uso de credito com ajuste manual de `saldoadiantamento` sem passar pela funcao central de recalc.
- Funcao central recalculando apenas saldo e deixando `situacao`/`situacaotexto` defasados.

## Saida minima

- Erro raiz em uma frase.
- Evidencias de banco (consulta e resultado relevante).
- Evidencias de codigo (arquivo e linha).
- Momento provavel da regressao (commit ou periodo).
- Impacto e risco de repeticao.
