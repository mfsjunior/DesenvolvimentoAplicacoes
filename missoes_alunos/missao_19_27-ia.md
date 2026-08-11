# MissÃ£o 19: O Futuro: IA Generativa com Spring AI

**Contexto de ImplementaÃ§Ã£o:** Branch $branch

---

## ðŸš¨ O Incidente (Problema de NegÃ³cio)
Os coordenadores gastam horas respondendo perguntas repetitivas dos alunos sobre a matriz curricular e os cursos. Precisamos automatizar e dar inteligÃªncia ao sistema.

---

## ðŸŽ¯ A MissÃ£o (Desafio TÃ©cnico)
Incorporar um modelo de linguagem natural (LLM) diretamente no Backend.

---

## âœ… CritÃ©rios de Aceite (Definition of Done)
1. Utilizar a biblioteca Spring AI.\n2. Criar um endpoint /api/ia/chat que recebe um prompt do usuÃ¡rio (ex: 'O que aprendo no curso de Medicina?').\n3. O sistema farÃ¡ a chamada para a OpenAI ou Gemini e retornarÃ¡ a resposta formatada para a tela de Conselheiro IA do Front-end.

---

## ðŸ“š Dicas e Pesquisa
Lembre-se de configurar a API Key no seu ambiente e nÃ£o subir chaves privadas (tokens) para o Git!

> **Nota para a FÃ¡brica de Software:** A partir da MissÃ£o 11 (API Gateway), considere integrar as chamadas dessa infraestrutura diretamente nas telas correspondentes do Frontend React.
