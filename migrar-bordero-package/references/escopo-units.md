# Criterio de inclusao de unit no package de bordero

Uma unit deve ir para o package de bordero quando:

1. O dominio principal dela for bordero (eletronico/manual/remessa/retorno).
2. Ela conversar majoritariamente com units do grupo bordero.
3. O uso fora do grupo ocorrer via interfaces/DTOs estaveis.

Uma unit deve ficar fora quando:

1. For infraestrutura transversal usada por varios modulos.
2. Pertencer a dominio principal diferente (ex.: titulo pagar geral, participante base).
3. Causar dependencia ciclica entre packages.

## Sinais praticos

- Nome/path aponta para `sistemaBorderoEletronico` ou `BorderoEletronico.Layouts`.
- Browser/ficha/frame dedicado de bordero.
- DTO/DAO/controller exclusivos de bordero.

## Antipadroes

- Mover utilitario global para dentro do package por conveniencia.
- Deixar unit migrada duplicada em package e no `dpr/.dproj` principal.
- Resolver dependencia adicionando muitos caminhos no `DCC_UnitSearchPath`.
