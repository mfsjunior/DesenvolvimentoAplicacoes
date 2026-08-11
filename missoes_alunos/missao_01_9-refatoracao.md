# MissÃ£o 01: Limpando a Casa: RefatoraÃ§Ã£o, Solid e MapStruct

**Contexto de ImplementaÃ§Ã£o:** Branch $branch

---

## ðŸš¨ O Incidente (Problema de NegÃ³cio)
A equipe de suporte relatou dezenas de bugs no cadastro de alunos. Ao analisarmos o cÃ³digo da ranch-8, descobrimos classes gigantescas com milhares de linhas misturando regras de negÃ³cio, acesso ao banco e formataÃ§Ã£o de JSON. O cÃ³digo virou o temido 'CÃ³digo Espaguete'.

---

## ðŸŽ¯ A MissÃ£o (Desafio TÃ©cnico)
Sua missÃ£o Ã© aplicar princÃ­pios SOLID (Single Responsibility) e refatorar o cÃ³digo. VocÃª deve criar DTOs (Data Transfer Objects) e usar a biblioteca MapStruct para remover as conversÃµes manuais espalhadas pelos controllers.

---

## âœ… CritÃ©rios de Aceite (Definition of Done)
1. Nenhuma Entidade (@Entity) deve ser retornada diretamente no Controller.\n2. O MapStruct deve converter automaticamente as entidades para DTOs e vice-versa.\n3. O comportamento das APIs (JSON final) deve permanecer idÃªntico ao original.

---

## ðŸ“š Dicas e Pesquisa
Pesquise sobre: @Mapper(componentModel = "spring") do MapStruct. Estude a diferenÃ§a entre DAO/Model e DTO.

> **Nota para a FÃ¡brica de Software:** A partir da MissÃ£o 11 (API Gateway), considere integrar as chamadas dessa infraestrutura diretamente nas telas correspondentes do Frontend React.
