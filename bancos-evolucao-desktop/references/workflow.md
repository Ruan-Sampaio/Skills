# Workflow

## Objetivo

Rodar evolucao de banco no projeto `bancos/desktop` com o procedimento padrao e rastreabilidade.

## Execucao padrao

1. Abrir terminal em `C:\@work\bancos\desktop`.
2. Executar `EvoluirBanco.bat`.
3. Responder:
   - `Atualizar ou criar um banco de dados(0 - Atualizar/1 - Criar):` -> `0`
   - `Digite o hostname (Default: localhost):` -> Enter
   - `Digite a porta (Default: 5432):` -> Enter
   - `Digite o superusuario (Default: postgres):` -> Enter
   - `Digite a senha (Default: postgres):` -> Enter
   - `Digite o nome da base...:` -> usar a base alvo confirmada
4. Aguardar a geracao e aplicacao dos scripts.
5. Se pedir `Pressione qualquer tecla para continuar`, confirmar.

## Artefatos e log

- Scripts gerados: `C:\@work\bancos\desktop\Scripts`
- Log de erro: `C:\@work\bancos\desktop\criaBancoErros.log`
- Comando de leitura de log: `type C:\@work\bancos\desktop\criaBancoErros.log`

## Observacoes

- Base padrao comum no cliente: `acofer`.
- Nao assumir base padrao sem confirmacao quando houver risco.
