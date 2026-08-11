# MissÃ£o 03: Acendendo as Luzes: Observabilidade com Prometheus

**Contexto de ImplementaÃ§Ã£o:** Branch $branch

---

## ðŸš¨ O Incidente (Problema de NegÃ³cio)
Ontem Ã s 15:00 o sistema ficou indisponÃ­vel por 10 minutos e voltou sozinho. O diretor perguntou o motivo, e nÃ³s... nÃ£o sabÃ­amos. EstÃ¡vamos 'voando Ã s cegas' sem mÃ©tricas do sistema.

---

## ðŸŽ¯ A MissÃ£o (Desafio TÃ©cnico)
Expor os batimentos cardÃ­acos da aplicaÃ§Ã£o utilizando Spring Boot Actuator e conectar a saÃ­da do Actuator para um formato que o Prometheus entenda.

---

## âœ… CritÃ©rios de Aceite (Definition of Done)
1. Adicionar as dependÃªncias do spring-boot-starter-actuator e micrometer-registry-prometheus.\n2. O endpoint /actuator/prometheus deve responder com mÃ©tricas textuais (formato chave-valor do Prometheus).\n3. O Grafana deve conseguir raspar esses dados (configurar no docker-compose.yml).

---

## ðŸ“š Dicas e Pesquisa
No pplication.yml, atente-se Ã  propriedade management.endpoints.web.exposure.include=health,info,prometheus.

> **Nota para a FÃ¡brica de Software:** A partir da MissÃ£o 11 (API Gateway), considere integrar as chamadas dessa infraestrutura diretamente nas telas correspondentes do Frontend React.
