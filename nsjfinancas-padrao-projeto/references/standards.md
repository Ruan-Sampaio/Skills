# Standards

## 1) Fronteira de modulo

Modulo funcional = conjunto coeso de unidades de um dominio, com camadas como:

- UI (`browser`, `ficha`, `frame`)
- aplicacao (`controller`)
- dados (`dao`, `dto`, `constantes`)
- suporte (`service`, `mapper`, `enum`) quando houver

Nao tratar pasta tecnica isolada como modulo (`mvc/dao`, `mvc/dto`).

## 2) Dependencias e build

- `nsproj.xml` define ordem de build, nao garante resolucao de `uses`.
- `DCC_UnitSearchPath` longo aumenta risco de estouro do `dcc`.
- Se a unit ja existir em package, preferir dependencia explicita de package.
- Se nao existir package, avaliar criar package do modulo completo.

## 3) Extracao de baixo risco

Priorizar primeiro:

- cadastro basico (`api_agencia*`, `api_banco*`, `api_tipoconta*`)
- leitura/relatorio (`relatorio_*`) quando nao houver escrita critica

Postergar blocos com forte acoplamento em tabelas centrais.

## 4) Contrato ERP x SQL para relatorios

- Tratar assinatura e ordem semantica de campos como contrato.
- Antes de alterar funcao SQL, confirmar se layouts/RTM consomem os campos.
- Registrar sempre:
  - campos retornados pela funcao
  - campos adicionados pelo `SELECT` do layout
  - filtros realmente repassados (`tipo`, `periodo`, `status`, `sinal`)

## 5) Politica de mudanca

- Aplicar em lote pequeno.
- Rodar build completo apos cada lote.
- Em caso de falha, reverter o lote e isolar causa antes de nova tentativa.
