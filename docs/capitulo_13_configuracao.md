# Capítulo 13 — Configuração Centralizada (Spring Cloud Config)

**Branch:** `branch-21-configuracao`
**Release:** 2.3
**Tipo de Evolução:** Operações (não-funcional)
**Risco:** Médio — Todos os microsserviços passam a buscar suas credenciais na rede durante o Boot. Se falhar, o serviço não inicia.
**Compatibilidade:** Nenhuma alteração de negócio.

---

## 1. História da Empresa

A UniTech possuía 15 microsserviços rodando no K8s. Cada um deles tinha seu próprio arquivo `application.yml` embutido no código fonte (ou ConfigMaps individuais injetados). 

Quando a equipe de Banco de Dados precisou rotacionar a senha do PostgreSQL por motivos de segurança, foi um inferno: o DevOps teve que ir em 15 repositórios diferentes, alterar o arquivo YML, dar commit, disparar a CI/CD, buildar 15 novas imagens Docker e fazer o rollout. A operação levou um dia inteiro para alterar UMA senha.

Isso violava o princípio do **DRY (Don't Repeat Yourself)** aplicado à infraestrutura.

---

## 2. Documento de Incidente (Modelo ITIL)

| Campo | Valor |
|-------|-------|
| **ID do Incidente** | INC-2025-0305 |
| **Severidade** | P4 — Baixa (Operação Travada) |
| **Causa Raiz** | Configurações descentralizadas e espalhadas pelo código fonte, forçando rebuilds inteiros de imagens Docker apenas para mudar variáveis de ambiente. |
| **Resolução Definitiva** | Implementação do **Spring Cloud Config Server**, um microsserviço dedicado apenas a fornecer `.yml` sob demanda para os outros (`branch-21-configuracao`). |

---

## 3. O Padrão Centralized Configuration

Criamos um novo microsserviço chamado `ms-config-server`. 
Ele não tem banco de dados. Ele se conecta a um **Repositório Git Privado** que contém apenas arquivos de texto `.yml`.

1. O `ms-academico` inicia.
2. Em vez de ler seu YML local, ele lê o `bootstrap.yml` e descobre o endereço do `ms-config-server`.
3. Ele faz uma chamada HTTP REST: "Me dê as configurações de Banco de Dados e RabbitMQ do ambiente de Produção!".
4. O `ms-config-server` lê do Git, encripta senhas de forma segura, e devolve o JSON de configuração.
5. O `ms-academico` aplica em memória e termina de inicializar.

*Se quisermos mudar a senha amanhã, basta darmos um commit no Git de configurações, e acionar o endpoint `/actuator/refresh` nos microsserviços. Eles atualizam a memória na hora, SEM REBOOT e SEM REBUILD DOCKER!*

---

## 4. O Código (O Servidor)

A classe main do Config Server é ridiculamente simples:

```java
@SpringBootApplication
@EnableConfigServer // A mágica
public class ConfigServerApplication {
    public static void main(String[] args) {
        SpringApplication.run(ConfigServerApplication.class, args);
    }
}
```

*application.yml do Config Server:*
```yaml
spring:
  cloud:
    config:
      server:
        git:
          uri: https://github.com/mfsjunior/unitech-configs.git # Git separado!
          default-label: main
```

---

## 5. Exercícios e Desafios

### Exercício 1: Refresh Dinâmico
Use o Spring Actuator. Faça um `POST /actuator/refresh` no `ms-academico` após ter mudado uma variável no Git de configuração. Crie uma rota GET boba que retorna essa string e prove que a API assumiu o valor novo sem precisar ser reiniciada!

### Desafio 1: Criptografia Assimétrica de Valores
Não é seguro guardar senhas em texto puro no repositório `unitech-configs.git`. Configure o Config Server com uma chave criptográfica Keystore (`JCE`), salve no Git o valor encriptado `{cipher}AQABa12...` e observe o Config Server decifrá-lo *on the fly* antes de entregar para os microsserviços.
