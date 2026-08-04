# Capítulo 14 — Segurança Zero-Trust com Service Mesh (Istio)

**Branch:** `branch-22-servicemesh`
**Release:** 2.4
**Tipo de Evolução:** Infraestrutura / Segurança Avançada (não-funcional)
**Risco:** Alto — Modifica a comunicação inter-rede de todos os containers via proxies invisíveis.
**Compatibilidade:** Transparente para o desenvolvedor, opaco para a operação.

---

## 1. História da Empresa

Na arquitetura atual (K8s), a segurança estava "na borda". O *API Gateway* barrava intrusos e decodificava o HTTPS. Mas o que acontecia **dentro** do cluster? 

Se o `ms-academico` conversasse com o `ms-pessoas`, o tráfego fluía em HTTP puro (texto claro). Durante uma auditoria interna "Red Team", um atacante conseguiu comprometer um container de baixa prioridade (um leitor de logs inofensivo) e, a partir dali, executou um ataque de movimentação lateral (*Lateral Movement*). Ele "escutou" a rede interna virtual do K8s (Packet Sniffing) e começou a capturar dados confidenciais dos alunos trafegando livremente.

Além disso, a equipe percebeu que havia poluição no código Java: os Circuit Breakers (Resilience4j) e lógicas de Retries enfeitavam o código-fonte de negócio. O Arquiteto queria remover essas preocupações de infraestrutura do Java.

A resposta para a política de *Zero Trust* (Não confie em ninguém, nem nos seus vizinhos internos) é o uso de um **Service Mesh** (Malha de Serviços), utilizando o famoso **Istio**.

---

## 2. Documento de Incidente (Modelo ITIL)

| Campo | Valor |
|-------|-------|
| **ID do Incidente** | INC-2025-0412 |
| **Severidade** | P2 — Alta (Vazamento Interno Simulado) |
| **Causa Raiz** | Falta de criptografia e autenticação *inter-microsserviços* dentro do Cluster (Confiabilidade baseada apenas em perímetro). |
| **Resolução Definitiva** | Implantação do *Istio Service Mesh* aplicando mTLS (Mutual TLS) automático entre todos os Pods e migração de políticas de rede para fora do Java (`branch-22-servicemesh`). |

---

## 3. O Padrão Service Mesh e o Padrão "Sidecar"

O Istio não pede para você mudar uma única linha de código Java. Ele usa o padrão **Sidecar**.
Quando o Kubernetes sobe o Pod do `ms-academico`, o Istio, de forma oculta (Webhook Mutator), injeta um segundo container no mesmo Pod, chamado **Envoy Proxy**.

- O `ms-academico` quer falar com o `ms-pessoas`. Ele acha que está enviando HTTP na porta 80.
- O *Envoy* intercepta essa chamada *dentro do próprio pod*.
- O *Envoy* embala a chamada num pacote criptografado HTTPS (mTLS) forte.
- Ele envia para o *Envoy* parceiro que está no pod do `ms-pessoas`.
- O *Envoy* receptor tira o pacote, verifica os certificados criptográficos das duas pontas (Mutual), e só então entrega o HTTP limpo para a JVM do `ms-pessoas`.

**Toda a comunicação dentro do datacenter passa a ser encriptada por padrão.** E as políticas de *Circuit Breaker*, *Retries* e *Roteamento A/B* agora são feitas configurando o Envoy via manifestos YAML, aliviando o desenvolvedor Java.

---

## 4. O Manifesto K8s (Istio VirtualService)

Veja como criar *Canary Releases* (Testar em Produção) sem mexer no Java:

```yaml
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: ms-academico-route
spec:
  hosts:
  - ms-academico
  http:
  - route:
    - destination:
        host: ms-academico
        subset: v2 # A nova versão que tem risco
      weight: 10   # Só 10% dos usuários vão cair nela!
    - destination:
        host: ms-academico
        subset: v1 # A versão antiga estável
      weight: 90   # 90% do tráfego continua salvo!
```

---

## 5. Exercícios e Desafios

### Exercício 1: Injeção de Sidecar
Habilite o Istio no namespace do K8s executando: `kubectl label namespace default istio-injection=enabled`. Delete seus pods e veja eles nascerem agora com a coluna `READY 2/2` (O segundo container é o Envoy Proxy invisível!).

### Desafio 1: Observabilidade Kiali
A magia do Service Mesh é que ele enxerga TODO o tráfego da rede. Habilite o addon Kiali do Istio e gere um "Grafico de Espaguete" animado mostrando como os dados fluem entre seus pods, quem está dando erro, e onde estão os engasgos, sem adicionar 1 linha de código de métricas.
