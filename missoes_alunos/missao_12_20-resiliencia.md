# MissÃ£o 12: PrevenÃ§Ã£o de Cascatas: Circuit Breaker

**Contexto de ImplementaÃ§Ã£o:** Branch $branch

---

## ðŸš¨ O Incidente (Problema de NegÃ³cio)
O MS Financeiro ficou lento e parou de responder rÃ¡pido. O API Gateway enfileirou requisiÃ§Ãµes para ele, gastou todos os recursos de rede e travou tambÃ©m. Uma falha local virou uma falha sistÃªmica.

---

## ðŸŽ¯ A MissÃ£o (Desafio TÃ©cnico)
Implementar o padrÃ£o Circuit Breaker no Gateway (ou via FeignClient) utilizando o Resilience4j.

---

## âœ… CritÃ©rios de Aceite (Definition of Done)
1. Configurar o disjuntor para abrir apÃ³s 50% de falhas nas Ãºltimas chamadas.\n2. Se o financeiro cair, o Gateway deve responder com uma mensagem amigÃ¡vel (Fallback) rapidamente, sem travar threads aguardando timeout longo.

---

## ðŸ“š Dicas e Pesquisa
Pesquise sobre: @CircuitBreaker(name = "financeiro", fallbackMethod = "fallback").

> **Nota para a FÃ¡brica de Software:** A partir da MissÃ£o 11 (API Gateway), considere integrar as chamadas dessa infraestrutura diretamente nas telas correspondentes do Frontend React.
