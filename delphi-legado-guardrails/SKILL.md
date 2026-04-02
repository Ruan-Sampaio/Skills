---
name: delphi-legado-guardrails
description: Aplica guardrails de stack para manutencao de sistemas Delphi legado em VCL Desktop com Delphi 10.1 Berlin. Use antes de editar `.pas`, `.dfm`, `.dpr` ou `.dproj` em repositorios Delphi do ERP para garantir compatibilidade de linguagem, preservar `Windows-1252`, seguir as regras de GUID e ORM, evitar numeros magicos e manter o padrao de camadas do projeto.
---

# Delphi Legado Guardrails

Aplicar este fluxo antes de alterar codigo Delphi no projeto legado.

## Fluxo

1. Ler [rules.md](references/rules.md).
2. Confirmar que a mudanca e compativel com Delphi 10.1 Berlin.
3. Validar que nao ha introducao de recursos de versoes mais novas.
4. Se houver GUID, aplicar apenas o padrao autorizado do projeto.
5. Se houver consulta ao ORM, usar apenas as referencias permitidas.
6. Se houver componente visual novo, preferir os componentes `TCX` quando esse padrao se aplicar.
7. Aplicar patch minimo e preservar comportamento.

## Regras

- Tratar `Windows-1252` como encoding padrao do projeto.
- Nao propor mudancas na biblioteca ORM.
- Substituir numeros magicos por constantes quando o valor nao for autoevidente.
- Respeitar o fluxo de camadas: `ficha/frame/browser -> controller -> dao/dto/constantes`.
- Em criacao de componentes, preferir os componentes da biblioteca `TCX`.
- Nao alterar assinatura publica sem necessidade explicita.
- Priorizar correcao pontual e de baixo risco.

## Saida minima

- Riscos de compatibilidade Delphi identificados.
- Confirmacao de aderencia a GUID e ORM.
- Resumo do patch minimo aplicado.
