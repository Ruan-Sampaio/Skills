---
name: build-erp-workspace
description: Executa o build padrao dos repositorios ERP do workspace `C:\@work`, escolhendo o comando correto por repo e evitando `clean` por padrao. Use quando o usuario pedir para compilar, buildar, gerar executavel, rodar `nsbuild`, rodar `build_all_debug.bat`, ou buildar o projeto atual em repos como `erp-financas-servicos`, `erp-admin`, `erp-persona`, `erp-utils` e `erp-libraries`.
---

# Build ERP Workspace

Executar este fluxo quando a tarefa for buildar o repo ERP atual ou um repo ERP conhecido do workspace.

## Fluxo

1. Ler [build-matrix.md](references/build-matrix.md).
2. Identificar o repo alvo pelo caminho atual ou por repo informado.
3. Resolver o comando padrao do repo (com alvo livre no `erp-financas-servicos` quando informado).
4. Nao rodar `clean` a menos que o usuario tenha pedido explicitamente no mesmo turno.
5. Executar o build no diretorio `build` correto ou pelo script batch correto.
6. Quando `nsbuild` nao estiver no `PATH`, usar fallback para `nsbuild.bat` dentro da pasta `build`.
7. Se houver falha, abrir `build\logs\<alvo>.log` (ou logs recentes) e retornar a primeira causa real.
8. Resumir alvo, comando executado e falhas relevantes.

## Regras

- `clean` nunca e padrao; usar so com pedido explicito do usuario.
- `clean` e bloqueado por padrao no script; so executar com confirmacao textual explicita do usuario no mesmo turno.
- Ao usar o script, `-Clean` exige `-CleanAuthorizedByUser "<texto da confirmacao do usuario>"`.
- Em repos com mais de um alvo conhecido, usar o alvo padrao do repo quando o usuario nao especificar outro.
- Para `erp-financas-servicos`, aceitar alvo informado pelo usuario mesmo fora da lista curta padrao.
- Para `erp-financas-servicos`, o alvo padrao e `nsjfinancas`.
- Para `erp-libraries`, usar o fluxo consolidado de `erp-utils\build\build_all_debug.bat`.
- Esta skill nao cobre `sftp_cmd` nem fluxos fora do padrao Delphi ERP.
- Se a tarefa for apenas evolucao de banco, usar `bancos-evolucao-desktop` em vez desta skill.
- Nao fixar `debug` no comando de `nsbuild`; usar o alvo puro.

## Recursos

- Script executor: [run-build.ps1](scripts/run-build.ps1)
- Matriz de repos e comandos: [build-matrix.md](references/build-matrix.md)

## Saida minima

- Repo resolvido.
- Alvo escolhido.
- Se houve ou nao `clean`.
- Comando executado.
- Resultado do build.
- Primeira causa de falha quando houver erro de compilacao.
