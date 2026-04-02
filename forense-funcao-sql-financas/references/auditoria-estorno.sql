-- Auditoria de titulos com possivel inconsistencia de vinculo de estorno.
-- Compatibilidade: PostgreSQL 9.3+

SELECT
  t.id AS titulo_original,
  t.numero AS numero_original,
  t.sinal AS sinal_original,
  t.statusestorno,
  t.id_titulo_estorno,
  te.id AS titulo_estorno,
  te.numero AS numero_estorno,
  te.sinal AS sinal_estorno,
  te.estorno AS flag_estorno_destino,
  CASE
    WHEN t.statusestorno IS NOT NULL AND ns.isuuidnull(t.id_titulo_estorno) THEN 'ORIGINAL_SEM_LINK'
    WHEN NOT ns.isuuidnull(t.id_titulo_estorno) AND te.id IS NULL THEN 'LINK_APONTA_INEXISTENTE'
    WHEN te.id = t.id THEN 'AUTO_REFERENCIA'
    WHEN te.estorno IS DISTINCT FROM TRUE THEN 'DESTINO_SEM_FLAG_ESTORNO'
    WHEN te.sinal = t.sinal THEN 'SINAL_DESTINO_INVALIDO'
    ELSE 'OK'
  END AS tipo_anomalia
FROM financas.titulos t
LEFT JOIN financas.titulos te
  ON te.id = t.id_titulo_estorno
WHERE t.statusestorno IS NOT NULL
  AND (
    ns.isuuidnull(t.id_titulo_estorno)
    OR te.id IS NULL
    OR te.id = t.id
    OR te.estorno IS DISTINCT FROM TRUE
    OR te.sinal = t.sinal
  )
ORDER BY tipo_anomalia, t.emissao DESC, t.numero;
