# Redundant Units Safety

## Regra principal
Unit coberta por dependencia no `nsproj` pode continuar necessaria no build atual.

## Exemplo real
Unidades:
- `SchtNS20`
- `CheqDef`
- `chqDLLS`

Foram detectadas como cobertas por `nsjchequeimplementacao`, mas remover causou:
- `F2613: Unit 'chqDLLS' not found`

## Procedimento seguro
1. Marcar como candidata.
2. Remover em lote pequeno.
3. Build completo.
4. Se quebrar, restaurar lote.
5. Investigar search path/package antes de nova tentativa.

## Validacao obrigatoria em migracao para package

1. Confirmar `<dependencia>` do package no `build/xmls/nsjfinancas.nsproj.xml`.
2. Remover do `nsjFinancas.dpr` as units legadas equivalentes.
3. Remover do `nsjFinancas.dproj` os `DCCReference` equivalentes.
4. So considerar migracao concluida quando os 3 pontos estiverem alinhados.
