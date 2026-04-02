---
name: delphi-legado-guardrails
description: Aplica guardrails de stack para manutencao de sistemas Delphi legado em VCL Desktop com Delphi 10.1 Berlin. Use antes de editar `.pas`, `.dfm`, `.dpr` ou `.dproj` em repositorios Delphi do ERP para garantir compatibilidade de linguagem, preservar `Windows-1252`, e seguir as regras de GUID e ORM do projeto.
---

# Delphi Legado Guardrails

Aplicar este fluxo antes de alterar codigo Delphi no projeto legado.

## Fluxo

1. Ler [rules.md](references/rules.md).
2. Confirmar que a mudanca e compativel com Delphi 10.1 Berlin.
3. Validar que nao ha introducao de recursos de versoes mais novas.
4. Se houver GUID, aplicar apenas o padrao autorizado do projeto.
5. Se houver consulta ao ORM, usar apenas as referencias permitidas.
6. Aplicar patch minimo e preservar comportamento.

## Regras

- Tratar `Windows-1252` como encoding padrao do projeto.
- Nao propor mudancas na biblioteca ORM.
- Nao alterar assinatura publica sem necessidade explicita.
- Priorizar correcao pontual e de baixo risco.

## Saida minima

- Riscos de compatibilidade Delphi identificados.
- Confirmacao de aderencia a GUID e ORM.
- Resumo do patch minimo aplicado.
