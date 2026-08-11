# MissÃ£o 16: PersistÃªncia Poliglota: MongoDB

**Contexto de ImplementaÃ§Ã£o:** Branch $branch

---

## ðŸš¨ O Incidente (Problema de NegÃ³cio)
O mÃ³dulo de 'Perfil de UsuÃ¡rio' permite que alunos criem atributos dinÃ¢micos customizados (redes sociais, habilidades, hobbies). Criar dezenas de colunas nulas no PostgreSQL ficou insustentÃ¡vel (esquema rÃ­gido).

---

## ðŸŽ¯ A MissÃ£o (Desafio TÃ©cnico)
Adicionar persistÃªncia poliglota. O sistema usarÃ¡ PostgreSQL para transaÃ§Ãµes financeiras ACID e MongoDB para dados flexÃ­veis de perfil.

---

## âœ… CritÃ©rios de Aceite (Definition of Done)
1. Subir um container do MongoDB.\n2. Criar um novo serviÃ§o (ms-perfil) que persista documentos BSON no MongoDB sem esquema definido (@Document).

---

## ðŸ“š Dicas e Pesquisa
DÃª uma olhada no MongoRepository no Spring Data. O front-end deverÃ¡ ler o perfil direto do MongoDB (via Gateway).

> **Nota para a FÃ¡brica de Software:** A partir da MissÃ£o 11 (API Gateway), considere integrar as chamadas dessa infraestrutura diretamente nas telas correspondentes do Frontend React.
