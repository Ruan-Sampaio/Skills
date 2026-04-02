# Migration Checklist

Checklist operacional para migracao incremental de units em repositorios Delphi ERP.

## Preparacao

- Identificar package alvo e comando de build alvo.
- Mapear onde a unit aparece:
  - `nsjFinancas.dpr` / `nsjFinancas.dproj`
  - `nsjServicos.dpr` / `nsjServicos.dproj`
  - outros projetos consumidores
  - `package.dpr` / `package.dproj` destino
- Definir criterio de parada para `DCC_UnitSearchPath` longo.

## Ciclo unitario (1 unit)

1. `git mv` da unit.
2. Ajustar referencias diretas em `dpr`/`dproj`.
3. Incluir a unit no `dpr`/`dproj` do package de destino (se aplicavel).
4. Rodar build do package.
5. Se falhar:
   - ler `build\logs\<target>.log`
   - extrair primeira causa real
   - rollback apenas da unit do ciclo
   - repetir build para confirmar retorno ao estado verde

## Sinais de alto risco

- Unit nova puxa `uFinancas_Controller` ou controllers de alto fan-out.
- Cascata de `F2613` em familias inteiras.
- Necessidade de adicionar muitos caminhos no `DCC_UnitSearchPath`.
- Alteracao simultanea em mais de um package.

## Criterio de parada e escalonamento

- Parar quando a solucao exigir expansao significativa de `DCC_UnitSearchPath`.
- Consultar o usuario com opcoes claras:
  - rollback do ultimo passo e encerrar lote
  - seguir com acoplamento maior e risco assumido
  - planejar extracao por modulo funcional antes de continuar
