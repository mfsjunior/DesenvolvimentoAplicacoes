# MissÃ£o 02: Gargalo de ConexÃµes: HikariCP, JPA e PaginaÃ§Ã£o

**Contexto de ImplementaÃ§Ã£o:** Branch $branch

---

## ðŸš¨ O Incidente (Problema de NegÃ³cio)
Na Ãºltima semana de provas, a tela de listagem de alunos travou o sistema inteiro. O DBA reportou que o PostgreSQL estourou o limite de conexÃµes (Too many clients already). AlÃ©m disso, descobrimos que o JPA estava trazendo 15.000 alunos de uma vez para a memÃ³ria do Java apenas para exibir 10 na tela (Problema do N+1).

---

## ðŸŽ¯ A MissÃ£o (Desafio TÃ©cnico)
Configurar um Pool de ConexÃµes saudÃ¡vel usando o HikariCP. Em seguida, refatorar a consulta de alunos implementando paginaÃ§Ã£o real a nÃ­vel de banco de dados, para que nunca tragamos mais do que o necessÃ¡rio para a memÃ³ria.

---

## âœ… CritÃ©rios de Aceite (Definition of Done)
1. O pplication.yml deve ter propriedades explÃ­citas de tuning do HikariCP (ex: maximum-pool-size: 20).\n2. O endpoint GET /api/alunos deve passar a receber os parÃ¢metros page e size e retornar um objeto do tipo Page.\n3. Evidenciar no console (SQL Logging) que o banco usou LIMIT e OFFSET.

---

## ðŸ“š Dicas e Pesquisa
Pesquise sobre: PagingAndSortingRepository no Spring Data JPA e a interface Pageable.

> **Nota para a FÃ¡brica de Software:** A partir da MissÃ£o 11 (API Gateway), considere integrar as chamadas dessa infraestrutura diretamente nas telas correspondentes do Frontend React.
