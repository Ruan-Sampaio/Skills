---
name: registrar-limpeza-modulos
description: Planeja limpeza e extracao de modulos do `nsjFinancas` para packages ou `commonfeature.*` usando a fronteira funcional correta do projeto. Use quando precisar escolher candidatos de baixo risco, definir escopo de modulo completo, registrar dependencias cruzadas, ou preparar ordem de migracao sem agrupar apenas por pasta tecnica.
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
8. Migrar em ordem de risco baixo para alto, sempre com build e smoke test.

## Regras de decisao

- Nao chamar de modulo algo que seja so `mvc/dao` ou `mvc/dto`.
- Priorizar modulo com boa coesao e pouco acoplamento externo.
- Quando a dependencia ja existir em package, ajustar o `nsproj.xml` antes de expandir `DCC_UnitSearchPath`.
- Quando o modulo ainda existir apenas no `financas`, mover o conjunto funcional inteiro.

## Saida minima

- Lista de modulos candidatos com camadas encontradas.
- Dependencias externas relevantes.
- Estrategia: `usar package existente`, `criar package novo` ou `adiar`.
- Ordem sugerida de migracao.
