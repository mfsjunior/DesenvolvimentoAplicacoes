# MissÃ£o 06: Desacoplamento AssÃ­ncrono: Mensageria com RabbitMQ

**Contexto de ImplementaÃ§Ã£o:** Branch $branch

---

## ðŸš¨ O Incidente (Problema de NegÃ³cio)
Na hora de efetivar uma matrÃ­cula, o MS AcadÃªmico faz uma chamada HTTP para o MS Financeiro gerar a primeira mensalidade. Ontem o MS Financeiro caiu, e centenas de alunos perderam a vaga porque a transaÃ§Ã£o sÃ­ncrona falhou.

---

## ðŸŽ¯ A MissÃ£o (Desafio TÃ©cnico)
Quebrar o acoplamento temporal usando RabbitMQ. Quando um aluno se matricular, o AcadÃªmico deve lanÃ§ar uma mensagem MatriculaRealizadaEvent na fila. O Financeiro consumirÃ¡ essa mensagem no tempo dele.

---

## âœ… CritÃ©rios de Aceite (Definition of Done)
1. O endpoint de matrÃ­cula nÃ£o deve esperar o financeiro retornar para responder 200 OK ao aluno.\n2. A mensagem deve chegar na *Exchange* do Rabbit e ser roteada para a *Queue* financeira.\n3. Se o MS Financeiro estiver desligado, a mensagem deve ficar salva no RabbitMQ esperando ele ligar.

---

## ðŸ“š Dicas e Pesquisa
Pesquise: RabbitTemplate para publicar e @RabbitListener para consumir. AtenÃ§Ã£o Ã  conversÃ£o de objetos em JSON via Jackson2JsonMessageConverter.

> **Nota para a FÃ¡brica de Software:** A partir da MissÃ£o 11 (API Gateway), considere integrar as chamadas dessa infraestrutura diretamente nas telas correspondentes do Frontend React.
