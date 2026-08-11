# MissÃ£o 10: SeparaÃ§Ã£o LÃ³gica: Arquitetura CQRS

**Contexto de ImplementaÃ§Ã£o:** Branch $branch

---

## ðŸš¨ O Incidente (Problema de NegÃ³cio)
RelatÃ³rios contÃ¡beis massivos estÃ£o concorrendo com transaÃ§Ãµes de matrÃ­cula na mesma tabela, causando Locks pessimistas no banco e lentidÃ£o generalizada.

---

## ðŸŽ¯ A MissÃ£o (Desafio TÃ©cnico)
Implementar CQRS (Command Query Responsibility Segregation). Separar as classes e fluxos que GRAVAM dados (Commands - ex: MatriculaService) dos que LÃŠEM dados (Queries - ex: RelatorioService).

---

## âœ… CritÃ©rios de Aceite (Definition of Done)
1. O cÃ³digo de leitura deve estar fisicamente isolado do cÃ³digo de escrita (em pacotes separados).\n2. (BÃ´nus) As queries mais pesadas podem apontar para uma view materializada ou um banco de leitura separado, sem impactar o banco principal.

---

## ðŸ“š Dicas e Pesquisa
A separaÃ§Ã£o nÃ£o precisa ser fÃ­sica inicialmente; aplicar o padrÃ£o estruturalmente nos pacotes jÃ¡ organiza o cÃ³digo consideravelmente.

> **Nota para a FÃ¡brica de Software:** A partir da MissÃ£o 11 (API Gateway), considere integrar as chamadas dessa infraestrutura diretamente nas telas correspondentes do Frontend React.
