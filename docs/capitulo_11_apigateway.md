# Capítulo 11 — Roteamento Dinâmico com Spring Cloud Gateway

**Branch:** `branch-19-apigateway`
**Release:** 2.1
**Tipo de Evolução:** Arquitetura / Rede (não-funcional)
**Risco:** Médio — Substitui o Nginx por uma solução Java reativa, alterando como as requisições chegam aos microsserviços.
**Compatibilidade:** Totalmente compatível com clientes externos.

---

## 1. História da Empresa

Embora o Nginx (Release 1.4) tenha servido brilhantemente como proxy reverso, a arquitetura da UniTech começou a sofrer "dores de crescimento". Cada vez que a equipe criava um novo microsserviço (como o `ms-biblioteca`), o arquivo `nginx.conf` precisava ser atualizado manualmente, testado e reiniciado.

Além disso, a equipe de segurança queria adicionar filtros complexos (ex: validar o JWT antes de deixar a requisição entrar no cluster interno) que eram difíceis de programar em C/Lua no Nginx. Precisávamos de um **API Gateway** escrito na mesma linguagem da empresa (Java) que se integrasse perfeitamente ao ecossistema Spring, permitindo programação de filtros customizados de forma fluída e reativa.

Entra em cena o **Spring Cloud Gateway**.

---

## 2. Documento de Incidente (Modelo ITIL)

| Campo | Valor |
|-------|-------|
| **ID do Incidente** | INC-2025-0105 |
| **Data de Abertura** | 10/01/2025 09:00 |
| **Severidade** | P3 — Média (Complexidade de Manutenção) |
| **Causa Raiz** | Uso de um Gateway externo (Nginx) que não compartilhava a mesma linguagem da stack de desenvolvimento (Java), gerando silos de conhecimento e dificuldade em aplicar lógicas de negócio complexas na borda. |
| **Resolução Definitiva** | Substituir o Nginx pelo `Spring Cloud Gateway` como serviço central (`branch-19-apigateway`). |

---

## 3. Objetivos Técnicos

| # | Objetivo | Justificativa Técnica |
|---|----------|-----------------------|
| 1 | Centralização Reativa | O Spring Cloud Gateway é construído sobre o Project Reactor, suportando milhares de requisições concorrentes sem travar threads. |
| 2 | Filtros Customizados | Possibilidade de escrever código Java que executa antes/depois que a requisição bate no microsserviço (ex: Log Audit, Correlation IDs). |
| 3 | Configuração Dinâmica | Rotas configuradas no `application.yml` do Spring, facilitando a injeção via Kubernetes ConfigMaps. |

---

## 4. O Código (Filtro Global)

Um dos maiores ganhos foi poder injetar um **Correlation ID** (UUID único gerado no gateway) em todas as chamadas. Assim, ao debugar logs, é possível rastrear a jornada de uma requisição que passou por 3 microsserviços diferentes.

```java
@Component
public class CorrelationIdFilter implements GlobalFilter, Ordered {
    @Override
    public Mono<Void> filter(ServerWebExchange exchange, GatewayFilterChain chain) {
        String correlationId = UUID.randomUUID().toString();
        
        ServerHttpRequest request = exchange.getRequest().mutate()
            .header("X-Correlation-ID", correlationId)
            .build();
            
        return chain.filter(exchange.mutate().request(request).build());
    }

    @Override
    public int getOrder() {
        return -1; // Executa primeiro
    }
}
```

---

## 5. Exercícios e Desafios

### Exercício 1: Roteamento Baseado em Path
Configure no `application.yml` do Gateway a rota para que `/api/biblioteca/**` seja repassado para `http://ms-biblioteca:8085`. 

### Desafio 1: JWT Validation na Borda
Em vez de cada microsserviço ter que decodificar o JWT, mova a lógica de validação do token (assinatura e expiração) para um Filtro Customizado no Gateway. Se for inválido, o Gateway barra ali mesmo (HTTP 401).
