# MissÃ£o 13: ConfiguraÃ§Ã£o Centralizada: Spring Cloud Config

**Contexto de ImplementaÃ§Ã£o:** Branch $branch

---

## ðŸš¨ O Incidente (Problema de NegÃ³cio)
A senha do banco de dados mudou na nuvem. Um desenvolvedor teve que abrir 6 projetos diferentes, alterar 6 pplication.yml, fazer 6 commits e dar restart em 6 servidores. Perda de tempo absurda.

---

## ðŸŽ¯ A MissÃ£o (Desafio TÃ©cnico)
Levantar um Servidor de ConfiguraÃ§Ã£o (Spring Cloud Config) que buscarÃ¡ os .yml diretamente de um repositÃ³rio Git.

---

## âœ… CritÃ©rios de Aceite (Definition of Done)
1. Subir a aplicaÃ§Ã£o ms-config-server.\n2. O ms-academico e o ms-financeiro nÃ£o devem mais ter senhas em seus arquivos locais, devem apontar para o servidor de config (spring.config.import).

---

## ðŸ“š Dicas e Pesquisa
As senhas devem ficar guardadas no repositÃ³rio de configuraÃ§Ã£o e injetadas no momento do boot dos microsserviÃ§os.

> **Nota para a FÃ¡brica de Software:** A partir da MissÃ£o 11 (API Gateway), considere integrar as chamadas dessa infraestrutura diretamente nas telas correspondentes do Frontend React.
