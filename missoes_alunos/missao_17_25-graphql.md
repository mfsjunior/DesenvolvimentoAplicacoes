# MissÃ£o 17: ReduÃ§Ã£o de Payload: Sob Demanda com GraphQL

**Contexto de ImplementaÃ§Ã£o:** Branch $branch

---

## ðŸš¨ O Incidente (Problema de NegÃ³cio)
A tela de listagem de alunos no Front-end (Mobile) consome muita banda de internet porque a API REST retorna 30 campos, sendo que o Mobile sÃ³ precisa de 
ome e email.

---

## ðŸŽ¯ A MissÃ£o (Desafio TÃ©cnico)
Disponibilizar uma API GraphQL para fornecer apenas os dados que o cliente pedir (Under-fetching e Over-fetching).

---

## âœ… CritÃ©rios de Aceite (Definition of Done)
1. Implementar spring-boot-starter-graphql.\n2. Criar o schema .graphqls com a query de busca de alunos.\n3. O Frontend farÃ¡ uma requisiÃ§Ã£o POST pedindo exclusivamente id, nome, curso e receberÃ¡ apenas esses campos no JSON.

---

## ðŸ“š Dicas e Pesquisa
Pesquise sobre anotaÃ§Ãµes @QueryMapping e @Argument.

> **Nota para a FÃ¡brica de Software:** A partir da MissÃ£o 11 (API Gateway), considere integrar as chamadas dessa infraestrutura diretamente nas telas correspondentes do Frontend React.
