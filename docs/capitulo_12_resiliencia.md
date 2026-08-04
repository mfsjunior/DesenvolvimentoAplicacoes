# Capítulo 12 — Resiliência e Prevenção de Cascatas com Circuit Breaker

**Branch:** `branch-20-resiliencia`
**Release:** 2.2
**Tipo de Evolução:** Resiliência (não-funcional)
**Risco:** Baixo — Protege o sistema contra quedas de serviços terceiros ou internos.
**Compatibilidade:** Backward-compatible.

---

## 1. História da Empresa

Embora a **UniTech** tivesse implementado a mensageria no Capítulo 06 para salvar os boletos de timeouts, outras partes do sistema ainda se comunicavam de forma síncrona (via `FeignClient` ou `RestTemplate`). 
Por exemplo, quando um aluno ia se matricular, o `ms-academico` fazia uma chamada REST rápida para o `ms-biblioteca` para verificar se o aluno tinha multas de livros não pagos. Se tivesse, a matrícula era bloqueada.

Um dia, o `ms-biblioteca` entrou num ciclo de *CrashLoopBackOff* no Kubernetes (Capítulo 07) após uma atualização mal sucedida, ficando 100% fora do ar.
Consequentemente, todas as tentativas do `ms-academico` de chamar a biblioteca falhavam após um longo timeout. As requisições de Matrícula começaram a empilhar na memória do `ms-academico`, e logo ele também caiu por falta de recursos (Cascading Failure).

A lição foi clara: **Se um serviço que você depende cai, ele não pode te arrastar junto.**

---

## 2. Documento de Incidente (Modelo ITIL)

| Campo | Valor |
|-------|-------|
| **ID do Incidente** | INC-2025-0218 |
| **Data de Abertura** | 18/02/2025 15:00 |
| **Severidade** | P1 — Crítica (Efeito Cascata) |
| **Causa Raiz** | Falha em cascata (Cascading Failure) provocada por chamadas síncronas presas (Timeouts). |
| **Resolução Definitiva** | Implementação do padrão **Circuit Breaker** utilizando a biblioteca *Resilience4j* (`branch-20-resiliencia`). |

---

## 3. O Padrão Circuit Breaker (Disjuntor)

Igual ao disjuntor da sua casa: se a corrente elétrica ficar perigosa, o disjuntor "Desarma" (Abre o Circuito) para evitar que a casa pegue fogo.

**Estados:**
1. **CLOSED (Fechado):** Fluxo normal. O serviço acadêmico liga para a biblioteca.
2. **OPEN (Aberto):** Após 5 falhas seguidas da biblioteca, o disjuntor "abre". A partir de agora, o serviço acadêmico **nem tenta** ligar para a biblioteca; ele retorna um erro instantâneo ou executa um plano B (Fallback), poupando memória e tempo.
3. **HALF-OPEN (Semi-Aberto):** Após 30 segundos, o disjuntor deixa 1 ou 2 requisições passarem de propósito. Se funcionarem, ele fecha o circuito de volta (Sistema se recuperou). Se falharem, ele abre o circuito novamente.

---

## 4. O Código (Fallback Method)

Com a anotação do *Resilience4j*, protegemos a chamada e declaramos um plano B.

```java
@CircuitBreaker(name = "bibliotecaService", fallbackMethod = "fallbackVerificaMulta")
public boolean alunoTemMulta(Long alunoId) {
    // Chamada remota perigosa (Pode dar Timeout!)
    return bibliotecaFeignClient.checarMulta(alunoId);
}

// O Plano B (Fallback)
public boolean fallbackVerificaMulta(Long alunoId, Throwable t) {
    // Se a biblioteca caiu, vamos presumir que ele NÃO tem multas (Graceful Degradation).
    // É melhor deixar o aluno se matricular do que travar a empresa inteira!
    System.out.println("Biblioteca fora do ar. Ignorando checagem de multas para " + alunoId);
    return false; 
}
```

---

## 5. Exercícios e Desafios

### Exercício 1: Configurando a Sensibilidade
Acesse o `application.yml` e configure o Resilience4j para abrir o circuito (OPEN) se 50% das requisições falharem nos últimos 10 requests (`slidingWindowSize: 10`, `failureRateThreshold: 50`).

### Desafio 1: Retries e Rate Limiting Internos
O *Resilience4j* não faz apenas Circuit Breaker. Combine as anotações `@Retry(name="x")` para que ele tente fazer a requisição 3 vezes antes de considerar uma falha para a estatística do disjuntor.
