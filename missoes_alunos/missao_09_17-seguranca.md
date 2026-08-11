# MissÃ£o 09: Blindagem Total: JWT, CORS e ProteÃ§Ã£o XSS

**Contexto de ImplementaÃ§Ã£o:** Branch $branch

---

## ðŸš¨ O Incidente (Problema de NegÃ³cio)
Descobrimos que tokens JWT estavam sendo roubados do localStorage dos navegadores. AlÃ©m disso, origens suspeitas estavam enviando requisiÃ§Ãµes REST disfarÃ§adas.

---

## ðŸŽ¯ A MissÃ£o (Desafio TÃ©cnico)
Elevar a seguranÃ§a do sistema. Configurar o CORS de maneira restrita e melhorar o tratamento dos tokens de seguranÃ§a.

---

## âœ… CritÃ©rios de Aceite (Definition of Done)
1. O CORS deve permitir requisiÃ§Ãµes APENAS do endereÃ§o do front-end.\n2. Implementar o Spring Security de forma stateless protegendo endpoints sensÃ­veis (apenas usuÃ¡rios com perfil 'ADMIN' podem deletar recursos).

---

## ðŸ“š Dicas e Pesquisa
Pesquise sobre: SecurityFilterChain, CorsConfigurationSource e a anotaÃ§Ã£o @PreAuthorize.

> **Nota para a FÃ¡brica de Software:** A partir da MissÃ£o 11 (API Gateway), considere integrar as chamadas dessa infraestrutura diretamente nas telas correspondentes do Frontend React.
