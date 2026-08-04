# Livro de Evolução de Software Corporativo (UniTech Soluções Acadêmicas)

Bem-vindo ao material de apoio da disciplina **Desenvolvimento de Aplicações**.
Este livro documenta a evolução arquitetural de um software de nível empresarial, partindo de um monólito com débitos técnicos até se tornar uma arquitetura distribuída, segura e elástica na nuvem.

## Filosofia de Evolução

Nesta obra, nenhuma tecnologia é adicionada "apenas porque existe" ou "porque está na moda". Para cada capítulo, você encontrará:
1. **Qual problema surgiu:** O incidente de negócios ou infraestrutura.
2. **Como foi identificado:** Uso de telemetria e análise de falhas.
3. **Alternativas e Escolha:** Por que a solução adotada foi a melhor.
4. **Impacto Arquitetural:** O antes, o depois, e as quebras de paradigma.

---

## Diagrama da Evolução Arquitetural Completa

```mermaid
journey
    title A Jornada Evolutiva da UniTech
    section Fase 1: Qualidade Interna (Core)
      Cap. 01 (Refatoração): 5: Arquiteto
      Cap. 02 (Performance & Hikari): 4: DBA
      Cap. 03 (Observabilidade Grafana): 6: SRE
    section Fase 2: Infraestrutura Borda
      Cap. 04 (Nginx & API Gateway): 5: Redes
      Cap. 05 (Cache com Redis): 6: Arquiteto
      Cap. 06 (RabbitMQ Assíncrono): 7: Arquiteto
    section Fase 3: Cloud & Ops
      Cap. 07 (Kubernetes - K8s): 8: DevOps
      Cap. 08 (CI/CD Github Actions): 7: DevOps
      Cap. 09 (Segurança & Refresh JWT): 8: DevSecOps
    section Fase 4: Otimização Avançada
      Cap. 10 (CQRS & Event Sourcing): 9: Arquiteto
      Cap. 11 (Spring Cloud Gateway): 6: Desenvolvedor
      Cap. 12 (Circuit Breaker): 7: Arquiteto
      Cap. 13 (Cloud Config Central): 5: DevOps
    section Fase 5: Nuvem Nativa
      Cap. 14 (Istio Service Mesh): 8: SRE
      Cap. 15 (Serverless GraalVM): 7: Arquiteto
      Cap. 16 (Polyglot Mongo NoSQL): 6: DBA
      Cap. 17 (GraphQL Otimizado): 7: Front-End
      Cap. 18 (gRPC Alta Performance): 8: Arquiteto
      Cap. 19 (Integração IA): 9: Produto
```

---

## Sumário dos Capítulos

### Fase 1: Fundações e Observabilidade
* **[Capítulo 01 — Limpando a Casa: Refatoração, Solid e MapStruct](capitulo_01_refatoracao.md)**
  * *Risco:* Baixo | *Branch:* `branch-9-refatoracao`
* **[Capítulo 02 — Gargalo de Conexões: HikariCP, JPA e Paginação](capitulo_02_performance.md)**
  * *Risco:* Alto | *Branch:* `branch-10-performance`
* **[Capítulo 03 — Acendendo as Luzes: Observabilidade com Prometheus e Grafana](capitulo_03_observabilidade.md)**
  * *Risco:* Baixo | *Branch:* `branch-11-observabilidade`

### Fase 2: Perímetro, Cache e Assincronismo
* **[Capítulo 04 — Escudo Frontal: Nginx, SSL, API Gateway e Rate Limiting](capitulo_04_nginx.md)**
  * *Risco:* Médio | *Branch:* `branch-12-nginx`
* **[Capítulo 05 — Velocidade da Luz: Cache In-Memory com Redis](capitulo_05_cache.md)**
  * *Risco:* Baixo | *Branch:* `branch-13-cache`
* **[Capítulo 06 — Desacoplamento Assíncrono: Mensageria com RabbitMQ](capitulo_06_mensageria.md)**
  * *Risco:* Alto | *Branch:* `branch-14-mensageria`

### Fase 3: Cloud Native e DevSecOps
* **[Capítulo 07 — Alta Disponibilidade: Orquestração com Kubernetes (K8s)](capitulo_07_k8s.md)**
  * *Risco:* Alto | *Branch:* `branch-15-k8s`
* **[Capítulo 08 — Automação de Entregas: Esteira CI/CD com GitHub Actions](capitulo_08_ci_cd.md)**
  * *Risco:* Baixo | *Branch:* `branch-16-ci-cd`
* **[Capítulo 09 — Blindagem Total: Dual JWT, CORS e Proteção XSS/CSRF](capitulo_09_seguranca.md)**
  * *Risco:* Muito Alto | *Branch:* `branch-17-seguranca`

### Fase 4: Padrões Avançados de Microsserviços
* **[Capítulo 10 — Separação Lógica: Arquitetura CQRS e Event Sourcing](capitulo_10_cqrs.md)**
  * *Risco:* Alto | *Branch:* `branch-18-cqrs`
* **[Capítulo 11 — Roteamento Dinâmico: Spring Cloud Gateway](capitulo_11_apigateway.md)**
  * *Risco:* Médio | *Branch:* `branch-19-apigateway`
* **[Capítulo 12 — Prevenção de Cascatas: Resiliência com Circuit Breaker](capitulo_12_resiliencia.md)**
  * *Risco:* Baixo | *Branch:* `branch-20-resiliencia`
* **[Capítulo 13 — Configuração Centralizada: Spring Cloud Config](capitulo_13_configuracao.md)**
  * *Risco:* Médio | *Branch:* `branch-21-configuracao`

### Fase 5: A Fronteira do Estado da Arte
* **[Capítulo 14 — Segurança Zero-Trust: Service Mesh com Istio](capitulo_14_servicemesh.md)**
  * *Risco:* Alto | *Branch:* `branch-22-servicemesh`
* **[Capítulo 15 — Escala ao Zero: Serverless (Faas) e GraalVM](capitulo_15_serverless.md)**
  * *Risco:* Baixo | *Branch:* `branch-23-serverless`
* **[Capítulo 16 — Persistência Poliglota: Flexibilidade com MongoDB (NoSQL)](capitulo_16_nosql.md)**
  * *Risco:* Baixo | *Branch:* `branch-24-nosql`
* **[Capítulo 17 — Redução de Payload: Sob Demanda com GraphQL](capitulo_17_graphql.md)**
  * *Risco:* Médio | *Branch:* `branch-25-graphql`
* **[Capítulo 18 — Tráfego Binário: Alta Performance Interna via gRPC](capitulo_18_grpc.md)**
  * *Risco:* Médio | *Branch:* `branch-26-grpc`
* **[Capítulo 19 — O Futuro: IA Generativa com Spring AI e RAG](capitulo_19_ia.md)**
  * *Risco:* Médio | *Branch:* `branch-27-ia`

---
> **Bons estudos e boa evolução arquitetural!**
