# registrar_limpeza_modulos

## Objetivo
Gerar plano de limpeza/migracao de modulos `financas.*` para `commonfeature.*` e reduzir acoplamento no `nsjFinancas.dpr`/`nsjFinancas.dproj`.

## Definicao de modulo (padrao do projeto)
Modulo = conjunto funcional transversal de camadas:
- browser/ficha/frame
- controller
- dao/dto/constantes (e variantes como enum/service/mapper)

Nao agrupar por pasta tecnica isolada (`mvc/dao`, `mvc/dto`, etc.).

## Checklist
1. Identificar modulo funcional completo (camadas presentes).
2. Levantar dependencias cruzadas do modulo.
3. Definir fronteira publica (interfaces/DTOs).
3.1. Se a dependencia ja existir em package: adicionar dependencia no `nsproj.xml` em vez de expandir `DCC_UnitSearchPath`.
3.2. Se existir apenas no `financas`: avaliar novo package para o modulo completo.
4. Planejar ordem de migracao (baixo risco -> alto risco).
5. Atualizar `build/xmls/nsjfinancas.nsproj.xml` quando aplicavel.
6. Ajustar `nsjFinancas.dpr` e `nsjFinancas.dproj`.
7. Rodar build e smoke test a cada passo.

## Candidatos iniciais (boa coesao)
- `financas.chequescustodias`
- `ocorrenciacontrato`
- `documentoajusterateio`
- `renegociacaocontrato`
- `reguacobranca`
- `commonfeature.terceiros_lcdpr`
