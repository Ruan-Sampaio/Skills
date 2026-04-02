---
name: bancos-evolucao-desktop
description: Opera a atualizacao local de base no repositorio `bancos/desktop` usando o fluxo padrao `EvoluirBanco.bat`. Use quando precisar evoluir banco, localizar scripts gerados em `C:\@work\bancos\desktop\Scripts`, abrir `criaBancoErros.log`, ou conduzir execucao operacional segura; nao use para forense de regressao funcional em function SQL.
---

# Bancos Evolucao Desktop

Executar este fluxo para evoluir banco no repositorio `bancos/desktop`.

## Fluxo

1. Ler [workflow.md](references/workflow.md).
2. Confirmar base alvo antes de executar a evolucao.
3. Executar o fluxo padrao via `EvoluirBanco.bat`.
4. Coletar resultado, script gerado e erros quando houver.
5. Registrar o que foi aplicado e proximos passos.

## Regras

- Usar o repositorio `C:\@work\bancos\desktop`.
- Manter scripts SQL em `C:\@work\bancos\desktop\Scripts`.
- Usar configuracao local padrao quando o usuario nao informar outra:
  - host `localhost`
  - porta `5432`
  - usuario `postgres`
  - senha `postgres`
- Se a base nao for informada, perguntar antes de executar.
- Quando houver erro, consultar `C:\@work\bancos\desktop\criaBancoErros.log`.
- Em Windows PowerShell, usar `type` para abrir log quando `cat` falhar.

## Saida minima

- Base alvo usada na execucao.
- Resultado da evolucao (`ok` ou `erro`).
- Caminho do script gerado.
- Resumo do log de erro, quando aplicavel.
