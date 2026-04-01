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

## 6) Regras fixas do projeto

- Preservar encoding `Windows-1252`; evitar caracteres que possam quebrar compilacao/leitura quando o arquivo estiver nesse padrao.
- Evitar numeros magicos no codigo; extrair para `constantes`.
- Ao criar componente, utilizar biblioteca `TCX`.
- Seguir padrao de camadas do projeto:
  - UI (`ficha`, `frame`, `browser`)
  - `controller` coordena fluxo entre UI e acesso a dados
  - `dao` executa queries e acessa banco
  - `dto` transporta dados
  - `constantes` centraliza literais e codigos fixos
- Quando precisar cast/conversao de GUID, usar metodos descritos em:
  `E:\Nasajon\ManipulacaoGuid.txt`

## 7) Infra e SQL

- Repositorio principal: `C:\@work\erp-financas-servicos`.
- Banco alvo para validacao: `PostgreSQL 9.3`.
- Considerar `PostgreSQL 9.3` como teto de recurso SQL:
  - permitido: `json`, `json_array_elements`, `LATERAL`
  - proibido: `jsonb`, `to_jsonb`, familia `jsonb_*`, `FILTER (...)`
- Ao revisar SQL, preferir acesso direto a coluna em vez de converter linha para JSON para ler campo.
- Ao reescrever agregacoes com filtro, usar `CASE WHEN` dentro da agregacao em vez de `FILTER (...)`.
- Scripts SQL novos devem ser criados em:
  `C:\@work\bancos\desktop\Scripts`.
- Comando util de conexao local:
  `psql -h localhost -U postgres -d teste -P pager=off` (senha: `postgres`).
