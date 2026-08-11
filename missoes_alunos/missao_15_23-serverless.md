# MissÃ£o 15: Escala ao Zero: Serverless e GraalVM

**Contexto de ImplementaÃ§Ã£o:** Branch $branch

---

## ðŸš¨ O Incidente (Problema de NegÃ³cio)
NÃ³s pagamos hospedagem na nuvem o tempo todo, mas de madrugada o sistema quase nÃ£o tem acessos. No Spring clÃ¡ssico, a JVM consome 500MB de RAM parada.

---

## ðŸŽ¯ A MissÃ£o (Desafio TÃ©cnico)
Compilar o cÃ³digo como Imagem Nativa (GraalVM) ou portar funÃ§Ãµes especÃ­ficas para AWS Lambda / Google Cloud Functions.

---

## âœ… CritÃ©rios de Aceite (Definition of Done)
1. A aplicaÃ§Ã£o deve inicializar em menos de 100 milissegundos.\n2. Consumo de memÃ³ria inicial (idle) reduzido para a casa dos 50MB.

---

## ðŸ“š Dicas e Pesquisa
Estude: spring-boot-starter-parent versÃ£o 3.x com suporte AOT (Ahead-of-Time) e Spring Native.

> **Nota para a FÃ¡brica de Software:** A partir da MissÃ£o 11 (API Gateway), considere integrar as chamadas dessa infraestrutura diretamente nas telas correspondentes do Frontend React.
