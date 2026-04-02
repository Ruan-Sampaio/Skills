---
name: registrar-limpeza-modulos
description: Planeja limpeza e extracao de modulos completos do `nsjFinancas` para packages ou `commonfeature.*`, com foco em baixo risco e consistencia entre `nsproj`, `dpr` e `dproj`. Use quando precisar definir fronteira de modulo inteiro, mapear dependencias cruzadas e organizar ordem de migracao; nao use para decidir remocao de uma unit isolada.
---

# Registrar Limpeza de Modulos

Executar este fluxo ao planejar migracao de modulos `financas.*` para outro package, `commonfeature.*` ou projeto separado.

## Fluxo

1. Ler [module-patterns.md](references/module-patterns.md).
2. Identificar o modulo funcional completo, nao apenas a pasta tecnica.
3. Levantar camadas presentes: browser, ficha, frame, controller, dao, dto, constantes e variantes.
4. Mapear dependencias cruzadas do modulo.
5. Definir a fronteira publica minima.
6. Verificar se o modulo ja cabe em package existente.
7. Se nao couber, propor novo package do modulo completo.
8. Aplicar migracao no trio `nsproj.xml`, `nsjFinancas.dpr` e `nsjFinancas.dproj`.
9. Migrar em ordem de risco baixo para alto, sempre com build e smoke test.

## Regras de decisao

- Nao chamar de modulo algo que seja so `mvc/dao` ou `mvc/dto`.
- Priorizar modulo com boa coesao e pouco acoplamento externo.
- Quando a dependencia ja existir em package, ajustar o `nsproj.xml` antes de expandir `DCC_UnitSearchPath`.
- Quando o modulo ainda existir apenas no `financas`, mover o conjunto funcional inteiro.
- Tratar remocao no `dpr/dproj` como candidata ate build validar.
- Se surgir unit faltando, primeiro verificar se ja existe package pronto antes de abrir novo pacote.

## Saida minima

- Lista de modulos candidatos com camadas encontradas.
- Dependencias externas relevantes.
- Estrategia: `usar package existente`, `criar package novo` ou `adiar`.
- Ordem sugerida de migracao.
