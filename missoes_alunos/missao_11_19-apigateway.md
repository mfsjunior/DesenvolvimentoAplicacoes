# MissÃ£o 11: Roteamento DinÃ¢mico e Frontend: Spring Cloud Gateway

**Contexto de ImplementaÃ§Ã£o:** Branch $branch

---

## ðŸš¨ O Incidente (Problema de NegÃ³cio)
Chegou a hora de plugarmos o Frontend React! O time de front avisou que nÃ£o tem como decorar 5 portas diferentes (8081, 8082, etc.) e lidar com CORS individual de cada microserviÃ§o.

---

## ðŸŽ¯ A MissÃ£o (Desafio TÃ©cnico)
Criar um API Gateway (o Porteiro). Ele serÃ¡ a Ãºnica aplicaÃ§Ã£o exposta publicamente na porta 8080. O Frontend (React) tambÃ©m deverÃ¡ ser inicializado.

---

## âœ… CritÃ©rios de Aceite (Definition of Done)
1. O MS Gateway deve rotear /api/alunos/** para o ms-academico (8082) e /api/financeiro/** para o ms-financeiro (8083).\n2. O Frontend (React + Vite) deve ser executado consumindo exclusivamente a porta 8080.

---

## ðŸ“š Dicas e Pesquisa
A partir desta missÃ£o, sua atenÃ§Ã£o passa a ser Fullstack. Acesse a pasta rontend e comece a casar a infraestrutura construÃ­da com a experiÃªncia do usuÃ¡rio!

> **Nota para a FÃ¡brica de Software:** A partir da MissÃ£o 11 (API Gateway), considere integrar as chamadas dessa infraestrutura diretamente nas telas correspondentes do Frontend React.
