# MissÃ£o 05: Velocidade da Luz: Cache In-Memory com Redis

**Contexto de ImplementaÃ§Ã£o:** Branch $branch

---

## ðŸš¨ O Incidente (Problema de NegÃ³cio)
O CEO quer um dashboard de estatÃ­sticas mostrando os cursos mais acessados. O problema Ã© que calcular isso no PostgreSQL gasta muita CPU e a lista muda apenas 1 vez por dia.

---

## ðŸŽ¯ A MissÃ£o (Desafio TÃ©cnico)
Implementar uma camada de Cache com Redis. RequisiÃ§Ãµes na rota de estatÃ­sticas devem bater no banco apenas a primeira vez; as subsequentes devem ler os dados quase instantaneamente da memÃ³ria RAM do Redis.

---

## âœ… CritÃ©rios de Aceite (Definition of Done)
1. Subir um container Redis.\n2. Anotar o mÃ©todo do Service com @Cacheable(value = "cursos").\n3. A segunda requisiÃ§Ã£o no endpoint deve ser respondida em menos de 15 milissegundos sem logs de Select no console do JPA.

---

## ðŸ“š Dicas e Pesquisa
Pesquise sobre: spring-boot-starter-data-redis e nÃ£o esqueÃ§a a anotaÃ§Ã£o @EnableCaching na classe principal.

> **Nota para a FÃ¡brica de Software:** A partir da MissÃ£o 11 (API Gateway), considere integrar as chamadas dessa infraestrutura diretamente nas telas correspondentes do Frontend React.
