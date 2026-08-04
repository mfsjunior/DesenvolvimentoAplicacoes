# Capítulo 15 — Escalabilidade ao Zero com Cloud Functions (Serverless)

**Branch:** `branch-23-serverless`
**Release:** 2.5
**Tipo de Evolução:** Arquitetura / Custo Operacional
**Risco:** Baixo — Aplica-se apenas a serviços específicos de uso esporádico.
**Compatibilidade:** Backward-compatible (Trata-se de uma refatoração infraestrutural).

---

## 1. História da Empresa

A **UniTech Soluções Acadêmicas** atingiu a excelência em arquitetura usando K8s, Istio, Mensageria e CI/CD. Porém, ao receber a fatura da AWS/GCP no final do mês, o CFO quase caiu da cadeira.

O microsserviço de "Geração de PDF de Certificado", que foi programado como uma API Java padrão (`ms-certificado`), ficava ligado **24 horas por dia, 7 dias por semana**, ocupando 1GB de RAM no Cluster. O grande problema é que alunos só emitem certificados durante a *Semana de Colação de Grau* (2 vezes por ano). No resto do ano, esse microsserviço recebia, no máximo, 1 requisição por dia.

A empresa estava pagando centenas de dólares para manter servidores rodando e ociosos (Idle).
O CTO sugeriu arrancar esse código do nosso Cluster K8s e hospedá-lo usando o modelo **Serverless (Cloud Functions / AWS Lambda)**.

---

## 2. O Padrão Serverless (Faas - Functions as a Service)

No Serverless, o código só existe quando alguém o chama.
1. O aluno aperta o botão "Gerar Certificado".
2. A Nuvem (AWS/GCP) levanta um container do zero contendo o código Java.
3. O PDF é gerado e retornado em milissegundos.
4. Se mais ninguém pedir nada por 15 minutos, a Nuvem *destrói* o container.
5. **Custo:** Você paga apenas pelos milissegundos de CPU que gastou gerando o PDF. O custo mensal cai de U$50,00 para U$0,02. Escalabilidade ao Zero (Scale to Zero).

---

## 3. O Desafio do Cold Start com Java

Java é notoriamente lento para ligar. Subir um Spring Boot demora de 3 a 10 segundos. No Serverless, o usuário ficaria esperando todo esse tempo na primeira execução do dia (*Cold Start*).

Para resolver isso, a branch adota o **Spring Cloud Function** em conjunto com a compilação **GraalVM Native Image**. O GraalVM compila o código Java em um executável nativo do sistema operacional (C-like), que liga em meros **0.05 segundos**, tornando o Java perfeito para Serverless.

---

## 4. O Código (Uma Função Limpa)

Sai o `@RestController`, entra a interface funcional nativa do Java.

```java
@SpringBootApplication
public class CertificadoFunctionApplication {
    public static void main(String[] args) {
        SpringApplication.run(CertificadoFunctionApplication.class, args);
    }

    // O Spring Cloud Function transforma esse @Bean em uma Serverless Function
    @Bean
    public Function<AlunoDTO, CertificadoDTO> gerarCertificado() {
        return aluno -> {
            // Lógica isolada de geração de PDF
            String url = "https://bucket/cert/" + UUID.randomUUID() + ".pdf";
            return new CertificadoDTO(aluno.getNome(), url, LocalDate.now());
        };
    }
}
```

---

## 5. Exercícios e Desafios

### Exercício 1: Invocação Local
Execute o projeto Spring Cloud Function localmente e perceba que, sem você escrever nenhum Controller, o Spring magicamente criou a rota HTTP POST `/gerarCertificado` apenas lendo o nome do seu Bean.

### Desafio 1: GraalVM Build
Instale o GraalVM e o plugin Native-Image. Execute o Maven mandando buildar o pacote nativo (`mvn -Pnative native:compile`). Execute o binário gerado e tire um print do log do Spring mostrando a velocidade estratosférica de Boot: `Started in 0.089 seconds`. O seu código agora está pronto para a nuvem.
