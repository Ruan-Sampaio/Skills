# AGENTS.md

## Escopo
Estas sao minhas preferencias globais para uso do Codex em qualquer projeto local dentro de `C:\@work`.
Se houver conflito entre este arquivo base e um arquivo especifico da stack ou do repositorio, priorize o arquivo mais especifico.

## Objetivo deste arquivo
Este arquivo deve funcionar como roteador principal de contexto.
Ao trabalhar em qualquer repo dentro de `C:\@work`, o Codex deve entender:
- quais sao as regras globais
- quais skills existem
- quando cada skill deve ser usada
- em que ordem combinar guardrails e skills de execucao

## Roteamento automatico de skills
- Ao iniciar qualquer tarefa dentro de `C:\@work`, ler primeiro `C:\@work\Skills\Skills.md`.
- Selecionar automaticamente a skill mais especifica aplicavel, mesmo que o usuario nao cite o nome da skill.
- Nao depender de comandos explicitos para descobrir que existe uma skill apropriada.
- Se houver mais de uma skill aplicavel, aplicar nesta ordem:
  1. skill de stack ou guardrail geral
  2. skill de projeto ou arquitetura
  3. skill especifica da tarefa
  4. skill auxiliar de operacao ou diagnostico
- Preferir skill especializada a skill guarda-chuva.
- Usar skill guarda-chuva apenas quando nao houver skill mais focada ou quando ela for necessaria como guardrail.
- Se nenhuma skill cobrir bem a tarefa, seguir as regras deste arquivo e registrar implicitamente a lacuna.

## Regras de combinacao de skills
- Em projetos Delphi, aplicar tambem `delphi-legado-guardrails`.
- Quando a tarefa for buildar, compilar ou gerar executavel em repos ERP conhecidos, aplicar `build-erp-workspace`.
- Quando a tarefa for criar, revisar ou alterar script SQL no repo `C:\@work\bancos`, aplicar `bancos-sql-guardrails`.
- Em mudancas estruturais no `nsjFinancas`, aplicar primeiro `nsjfinancas-padrao-projeto` ou `nsjfinancas-refactor-guardrails`, depois a skill especifica da tarefa.
- Para tarefas de banco em `C:\@work\bancos`, verificar se a demanda e:
  - evolucao operacional de base: usar `bancos-evolucao-desktop`
  - investigacao ou correcao funcional SQL de `financas`: usar a skill especifica do problema
- Quando a tarefa mencionar saldo adiantamento, extrato de credito, estorno, function SQL, `dpr`, `dproj`, `nsproj`, package, `commonfeature` ou `F2046`, assumir que existe alta chance de haver skill aplicavel e consultar o catalogo antes de responder.

## Atalhos de roteamento rapido
- Pedido de build, compilacao, executavel, `nsbuild`, `build_all_debug.bat` ou build do repo atual -> `build-erp-workspace`
- Pedido de script SQL, function, view, type, trigger, RTM, tabela ou coluna no repo Bancos -> `bancos-sql-guardrails`
- Repo `/financas-servicos`:
  - se for manutencao Delphi, ativar `delphi-legado-guardrails`
  - se for pedido de build ou compilacao, ativar `build-erp-workspace`
  - se envolver `nsjFinancas`, `dpr`, `dproj`, `nsproj`, package ou `commonfeature`, ativar tambem uma skill de arquitetura do `nsjFinancas`
  - se o problema citar saldo adiantamento, extrato de credito, estorno ou function SQL de `financas`, procurar primeiro a skill especifica desse fluxo
- Repo `/bancos`:
  - se for criacao ou revisao de script SQL, usar `bancos-sql-guardrails`
  - se for rodar atualizacao local de base, usar `bancos-evolucao-desktop`
  - se for regressao em function SQL, usar `forense-funcao-sql-financas`
- Se a tarefa estiver entre duas skills, preferir a mais especifica pelo sintoma do problema, nao pelo repo.

## Catalogo de skills
- Catalogo principal: `C:\@work\Skills\Skills.md`
- Pasta raiz das skills: `C:\@work\Skills`
- O catalogo deve ser tratado como indice de descoberta rapida.
- O `SKILL.md` de cada skill continua sendo a fonte detalhada de execucao.

## Comandos rapidos
- `/delphi` => reforcar contexto Delphi legado e priorizar `delphi-legado-guardrails`

## Repositorios (aliases de `C:\@work`)
- `/bancos` => `C:\@work\bancos`
- `/admin` => `C:\@work\erp-admin`
- `/components` => `C:\@work\erp-components`
- `/crm` => `C:\@work\erp-crm`
- `/estoque` => `C:\@work\erp-estoque`
- `/financas-servicos` => `C:\@work\erp-financas-servicos`
- `/instalador` => `C:\@work\erp-instalador`
- `/libraries` => `C:\@work\erp-libraries`
- `/locacoes` => `C:\@work\erp-locacoes`
- `/scritta` => `C:\@work\erp-scritta`
- `/utils` => `C:\@work\erp-utils`
- `/gold` => `C:\@work\gold`

## Regra de interpretacao
- Quando eu escrever `aja/atue como /<stack> repo /<alias>`, resolver stack e alias e confirmar ambos antes de editar arquivos.
- Caso eu nao informe stack e repo e isso seja necessario para decidir com seguranca, pergunte.
- Se o repo ou o assunto ja deixarem a stack obvia, nao pergunte sem necessidade.

## Regras gerais
- Priorize correcoes pontuais, seguras e de baixo risco.
- Antes de alterar, explique a proposta e aguarde confirmacao.
- Faca a menor alteracao possivel para resolver a tarefa.
- Nao alterar assinaturas publicas sem solicitar.
- Nao mudar comportamento funcional sem avisar explicitamente.
- Conferir commits exclusivos da branch atual antes de sugerir mudancas.
- Manter o padrao ja existente no codigo.
- Nao alterar encoding automaticamente.
- Preserve o encoding original dos arquivos.
- Use acentuacao correta em mensagens e textos que nao sao codigo.
- Evite mudancas cosmeticas fora do escopo.
- Nao introduza padroes novos sem necessidade clara.
- Em caso de duvida, prefira preservar compatibilidade e comportamento atual.

## Banco de dados
- Banco principal local: PostgreSQL 11.
- O padrao de acesso a dados existente no codigo deve ser mantido.
- Scripts SQL devem ser criados exclusivamente em: `C:\@work\bancos\desktop\Scripts`
- Encoding dos scripts SQL: `win1252`
- Todos os scripts de banco devem ser compativeis com PostgreSQL 9.3.
- Para criacao de novas colunas, use sempre a funcao `ns.has_column` para verificar se a coluna ja existe.
- Configuracao local padrao do banco:
  - user: `postgres`
  - pass: `postgres`
  - host: `localhost`
  - porta padrao

## Postura esperada
Atue como revisor e desenvolvedor senior, focado em sistemas grandes, estabilidade, previsibilidade e manutencao.
