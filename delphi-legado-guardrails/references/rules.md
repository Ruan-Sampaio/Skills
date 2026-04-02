# Rules

## Ambiente alvo

- Linguagem: Delphi
- Versao alvo: Delphi 10.1 Berlin
- Tipo de projeto: VCL Desktop
- Encoding padrao: Windows-1252

## Compatibilidade

- Nao usar recursos de versoes mais novas da linguagem, RTL ou VCL.
- Preservar comportamento funcional atual quando a tarefa for de manutencao.
- Evitar numeros magicos; preferir constantes nomeadas.

## Padrao de projeto

- Respeitar o fluxo de camadas do projeto:
  - `ficha/frame/browser`
  - `controller`
  - `dao`, `dto`, `constantes`
- Queries devem nascer no `DAO`.
- `controller` faz a ponte entre camada visual e `DAO`.
- Constantes devem ficar na unidade de `constantes` do modulo.

## Componentes

- Ao criar componentes visuais, preferir os componentes da biblioteca `TCX` quando esse padrao estiver disponivel no projeto.

## GUID

- Em cast ou manipulacao de GUID, usar somente o padrao definido em:
  `E:\Nasajon\ManipulacaoGuid.txt`

## ORM

- Quando precisar consultar modelo ORM, usar apenas:
  `C:\@work\erp-libraries\nsORM\ORM\`
- Nao alterar arquivos desse caminho.
- Nao sugerir mudancas no ORM.

## Postura

- Atuar como manutencao de sistema legado: patch pequeno, previsivel e seguro.
