# MissÃ£o 08: AutomaÃ§Ã£o de Entregas: Esteira CI/CD (GitHub Actions)

**Contexto de ImplementaÃ§Ã£o:** Branch $branch

---

## ðŸš¨ O Incidente (Problema de NegÃ³cio)
Um desenvolvedor sÃªnior executou o deploy manualmente do notebook dele usando um banco de dados de teste apontado no pplication.yml. Os dados de produÃ§Ã£o foram misturados com dados falsos. Um desastre.

---

## ðŸŽ¯ A MissÃ£o (Desafio TÃ©cnico)
Automatizar a entrega. Nenhum cÃ³digo deve ir para produÃ§Ã£o (ou ser fundido na branch main) sem passar por testes automatizados (CI) e ter a imagem docker gerada e publicada (CD).

---

## âœ… CritÃ©rios de Aceite (Definition of Done)
1. Criar o arquivo .github/workflows/pipeline.yml.\n2. O pipeline deve compilar o projeto (mvn clean package), rodar os testes unitÃ¡rios.\n3. Se tudo passar, deve gerar o *Build* da imagem Docker.

---

## ðŸ“š Dicas e Pesquisa
Estude como o GitHub Actions levanta um Ubuntu temporÃ¡rio, instala o Java 17 e roda os passos definidos no YAML.

> **Nota para a FÃ¡brica de Software:** A partir da MissÃ£o 11 (API Gateway), considere integrar as chamadas dessa infraestrutura diretamente nas telas correspondentes do Frontend React.
