# SQL Rules

## Ambiente

- Banco principal local: `PostgreSQL 11`
- Compatibilidade obrigatoria dos scripts: `PostgreSQL 9.3`
- Encoding esperado: `Windows-1252` / `win1252`
- Pasta raiz de scripts: `C:\@work\bancos\desktop\Scripts`

## Regras globais

- Nao usar `owner to group_nasajon/postgres`, exceto em views materializadas quando o processo exigir.
- Nao usar comandos que desativem verificacao de constraints ou comportamento equivalente, como:
  - `DISABLE TRIGGER ALL`
  - `SESSION_REPLICATION_ROLE = REPLICA`
- Em dollar-quote:
  - `$$$$` e valido para string vazia
  - nunca deixar delimitadores `$$` desbalanceados

## Nome e local do arquivo

- Quando aplicavel, usar nome com timestamp no formato `AAMMDDhhmmss`.
- Exemplo: `2103110854_meu_script.sql`
- `functions`: `desktop\Scripts\functions`
- `views`: `desktop\Scripts\views`
- `relatorios`: `desktop\Scripts\relatorios`
- scripts gerais de tabela, coluna, constraint, type: `desktop\Scripts`

## Functions

- Toda function deve usar `create or replace`.
- Quando houver parametro opcional novo, incluir `drop function if exists` da assinatura anterior.
- Functions que retornam `TABLE` ou `TYPE` tambem devem ter `drop function` no inicio.
- Nao alterar parametros nem tipo de retorno de funcoes de API.
- Quando necessario, criar uma nova versao da API.

## Views

- Toda criacao de view deve conter `drop view if exists`.
- Nao usar `CASCADE` no `drop view`.
- Views de cubo BI devem ficar no schema `nsview`.
- Em componentes de BI:
  - versionar a view na pasta `views`
  - criar tambem o script de registro na pasta `scripts`
  - nunca usar `UNREGISTER`
- Para acrescimo de campo em view, usar `public_new_field_nsview` quando esse fluxo se aplicar.

## Tabelas e colunas

- Toda tabela deve possuir chave primaria.
- Preferir chave primaria `UUID`.
- Ao criar coluna, usar `ns.has_column`.
- Nao excluir nem renomear colunas.
- Em tabelas grandes ou sensiveis, evitar `default` em coluna nova.
- Ao adicionar campo em `financas.titulos`, criar campo identico em `financas.tituloscancelados`.

## Types

- Nao excluir types.
- Nao remover atributos existentes.
- Ao adicionar atributo, usar `ns.has_attribute`.

## Triggers

- Criar trigger exige analise adicional.
- Alterar ou remover trigger e trigger function pode exigir aprovacao adicional.
- Trigger function fica em `desktop\Scripts\functions`.

## RTM e CRUD

- Scripts de relatorio ficam em `desktop\Scripts\relatorios`.
- `UPDATE` e `DELETE` devem sempre ter `WHERE`.
- Mudancas massivas em tabelas compartilhadas exigem analise adicional.

## Mudancas sensiveis

Podem exigir aprovacao adicional:

- alteracao em funcoes de API
- alteracao em views compartilhadas
- alteracao de tipo de coluna
- mudancas em tabelas sensiveis
- criacao, remocao ou alteracao de triggers
- mudancas em `FK`, `UNIQUE` e types usados por API
- qualquer acao que desative triggers da contabilizacao
