# Workflow

## Objetivo

Mapear o estado atual dos artefatos ERP e SQL para o relatorio de saldo de credito, incluindo versoes sintetica, simplificada e analitica.

## Verificacoes

1. Listar formularios, browsers, controllers, DAOs e DTOs relacionados.
2. Localizar scripts SQL, functions e views envolvidos.
3. Confirmar parametros, filtros e ordenacao usados hoje.
4. Identificar diferencas entre sintetico, simplificado e o analitico desejado.
5. Registrar pendencias com prioridade e impacto.
6. Marcar separadamente o que e incompatibilidade de `PostgreSQL 9.3` e o que e apenas decisao de implementacao.

## Formato recomendado de saida

- `artefato`
- `camada`
- `status`
- `origem`
- `acao recomendada`
