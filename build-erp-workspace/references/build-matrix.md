# Build Matrix

## Regras gerais

- Nao rodar `clean` por padrao.
- Rodar `clean` somente quando o usuario pedir explicitamente.
- Quando usar o script da skill, `clean` so pode rodar com `-CleanAuthorizedByUser` preenchido com a confirmacao textual do usuario no mesmo turno.
- Em repo com mais de um alvo, usar o alvo padrao listado abaixo se o usuario nao especificar outro.
- Esta matriz nao cobre `sftp_cmd`.

## Repositorios suportados

### erp-financas-servicos

- Repo: `C:\@work\erp-financas-servicos`
- Build dir: `C:\@work\erp-financas-servicos\build`
- Comando padrao: `nsbuild nsjfinancas`
- Alvo alternativo conhecido: `nsbuild nsjservicos`
- Alvos adicionais: aceitar alvo informado (`nsbuild <target>`), ex.: package especifico.
- Clean opcional: `nsbuild clean`

### erp-admin

- Repo: `C:\@work\erp-admin`
- Build dir: `C:\@work\erp-admin\build`
- Comando padrao: `nsbuild nsjadmin`
- Clean opcional: `nsbuild clean`

### erp-persona

- Repo: `C:\@work\erp-persona`
- Build dir: `C:\@work\erp-persona\build`
- Comando padrao: `nsbuild nsjpersona`
- Clean opcional: `nsbuild clean`

### erp-utils

- Repo: `C:\@work\erp-utils`
- Build dir: `C:\@work\erp-utils\build`
- Comando padrao: `build_all_debug.bat`
- Observacao: este fluxo atende o bloco de `utils/libraries`

### erp-libraries

- Repo: `C:\@work\erp-libraries`
- Build dir efetivo: `C:\@work\erp-utils\build`
- Comando padrao: `build_all_debug.bat`
- Observacao: usar o mesmo build consolidado de `erp-utils`
