# MissÃ£o 04: Escudo Frontal: Nginx, SSL e Rate Limiting

**Contexto de ImplementaÃ§Ã£o:** Branch $branch

---

## ðŸš¨ O Incidente (Problema de NegÃ³cio)
Sofremos um ataque de negaÃ§Ã£o de serviÃ§o (DDoS). Centenas de requisiÃ§Ãµes por segundo esgotaram o Tomcat do Spring Boot diretamente na porta 8080. AlÃ©m disso, o trÃ¡fego nÃ£o estava criptografado.

---

## ðŸŽ¯ A MissÃ£o (Desafio TÃ©cnico)
Colocar um NGINX (Servidor Web) na frente do Spring Boot atuando como Proxy Reverso. Ele serÃ¡ o responsÃ¡vel por barrar ataques de repetiÃ§Ã£o (Rate Limit).

---

## âœ… CritÃ©rios de Aceite (Definition of Done)
1. Criar um arquivo 
ginx.conf.\n2. Configurar o NGINX para ouvir na porta 80 e encaminhar o trÃ¡fego interno para a porta do Spring Boot.\n3. Aplicar a diretiva limit_req para permitir no mÃ¡ximo 10 requisiÃ§Ãµes/segundo por IP.

---

## ðŸ“š Dicas e Pesquisa
Estude como o Docker Compose mapeia a porta 80 do Nginx enquanto a porta do Java fica fechada para a internet externa.

> **Nota para a FÃ¡brica de Software:** A partir da MissÃ£o 11 (API Gateway), considere integrar as chamadas dessa infraestrutura diretamente nas telas correspondentes do Frontend React.
