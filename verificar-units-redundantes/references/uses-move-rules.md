# Uses Move Rules

## Manter na interface

- Tipos usados na declaracao da classe, record ou interface.
- Tipos usados em parametros e retorno de metodos declarados na interface.
- Unit da classe base herdada.
- Units exigidas por atributos/metadados declarados na interface.

## Mover para implementation

- Units usadas apenas no corpo dos metodos.
- Helpers e utils usados somente em implementacao.
- Units de UI/skins nao usadas por tipos publicos.
- Constantes usadas apenas dentro de metodos.

## Armadilhas comuns

- Virgula sobrando no `uses` com `{$IFDEF}`.
- Forward declaration para tipo que precisa de definicao completa.
- Introduzir mudancas alem de `uses` e aumentar risco de regressao.
- Fazer lote grande demais e dificultar rollback.

## Checklist por unit

1. Interface compila com tipos publicos preservados.
2. Implementation contem dependencias movidas.
3. Nao houve alteracao de regra de negocio.
4. Build completo executado apos o lote.
