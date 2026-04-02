# Workflow

## Objetivo

Mapear o estado atual dos artefatos ERP e SQL do relatorio de saldo de credito, incluindo versoes sintetica, simplificada e analitica.

## Verificacoes

1. Listar formularios, browsers, controllers, DAOs e DTOs relacionados.
2. Localizar scripts SQL, functions e views envolvidos.
3. Confirmar filtros de tela aplicados em Visualizar e Exportar CSV.
4. Confirmar campos e aliases retornados pelas functions SQL.
5. Validar regra de `sinal` para nao misturar receber/pagar.
6. Verificar se scripts de layout sao idempotentes.
7. Identificar diferencas entre sintetico, simplificado e o analitico desejado.
8. Registrar pendencias com prioridade e impacto.
9. Marcar separadamente o que e incompatibilidade de `PostgreSQL 9.3` e o que e apenas decisao de implementacao.

## Formato recomendado de saida

- `artefato`
- `camada`
- `status`
- `origem`
- `acao recomendada`
