# Capítulo 18 — RPC de Alta Performance com gRPC

**Branch:** `branch-26-grpc`
**Release:** 2.8
**Tipo de Evolução:** Comunicação de Sistemas (não-funcional)
**Risco:** Médio — Substitui comunicações REST/JSON internas por conexões TCP binárias.
**Compatibilidade:** Interna apenas (Front-end não usa gRPC diretamente).

---

## 1. História da Empresa

No Capítulo 17, otimizamos o tráfego da API pública (Frontend -> Backend) usando GraphQL para diminuir o tamanho dos payloads. No entanto, surgiu um problema diferente: **A comunicação entre microsserviços nos bastidores.**

O `ms-financeiro` processava pagamentos lendo informações fiscais massivas do `ms-academico`. O processo funcionava via `HTTP 1.1 REST` transferindo JSON.

Um belo dia, o financeiro precisou importar a base completa de 50.000 alunos. A requisição trafegou um gigantesco JSON textual através da rede interna do Kubernetes. O *Parser* (Jackson) do Spring boot demorou mais tempo convertendo Strings em Arrays Java do que o banco de dados demorou para encontrar a informação. Além disso, o protocolo HTTP 1.1 precisava abrir e fechar conexões para cada chamada repetitiva. 

A rede estava sobrecarregada pelo peso do texto. Para sistemas de máquina conversando com máquina, JSON é extremamente ineficiente. Precisávamos da linguagem universal dos bytes.

---

## 2. A Evolução: O Poder do Protocol Buffers (Protobuf) e HTTP/2

Desenvolvido pelo Google, o **gRPC (gRPC Remote Procedure Calls)** destrói o conceito de "verbos REST" (GET, POST).
No gRPC, o serviço cliente chama uma função do serviço remoto como se estivesse executando código localmente.

1. **Protocol Buffers:** Em vez de trafegar `{"nome": "João", "idade": 20}`, o gRPC transforma tudo em pequenos bytes compilados. O tamanho do tráfego de rede cai até 80%.
2. **HTTP/2:** O gRPC usa túneis multiplexados. Uma mesma conexão HTTP fica aberta permanentemente transferindo milhões de bytes nos dois sentidos (Bidirecional Streaming), acabando com o *handshake* e a latência (TTFB).

---

## 3. O Código (Contrato `.proto`)

Diferente do REST onde você adivinha a documentação pelo Swagger, no gRPC o contrato é físico e gera código em qualquer linguagem.

*Arquivo `aluno.proto`:*
```protobuf
syntax = "proto3";
package academico;

option java_package = "com.unitech.grpc";
option java_multiple_files = true;

// O Serviço (Controller)
service AlunoService {
  rpc ConsultarAluno (AlunoRequest) returns (AlunoResponse);
}

// Os DTOs
message AlunoRequest {
  int64 id = 1;
}

message AlunoResponse {
  int64 id = 1;
  string nome = 2;
  double mensalidade = 3;
}
```

O Maven compila esse arquivo `.proto` e gera automaticamente classes abstratas Java. 
Nossa missão é estendê-las.

*No Servidor (ms-academico):*
```java
@GrpcService
public class AlunoGrpcServerImpl extends AlunoServiceGrpc.AlunoServiceImplBase {
    
    @Override
    public void consultarAluno(AlunoRequest request, StreamObserver<AlunoResponse> responseObserver) {
        // Pega do banco de dados real
        Aluno aluno = repository.findById(request.getId()).orElseThrow();
        
        // Constrói a resposta binária
        AlunoResponse resposta = AlunoResponse.newBuilder()
            .setId(aluno.getId())
            .setNome(aluno.getNome())
            .setMensalidade(aluno.getValorMensal())
            .build();
            
        // Dispara de volta pela rede via Stream
        responseObserver.onNext(resposta);
        responseObserver.onCompleted();
    }
}
```

*No Cliente (ms-financeiro):*
```java
@Service
public class FaturamentoService {
    
    @GrpcClient("ms-academico-channel")
    private AlunoServiceGrpc.AlunoServiceBlockingStub alunoStub;
    
    public void gerarFatura(Long alunoId) {
        // Parece uma chamada de método local, mas cruza a rede em microssegundos!
        AlunoRequest req = AlunoRequest.newBuilder().setId(alunoId).build();
        AlunoResponse res = alunoStub.consultarAluno(req);
        
        System.out.println("Cobrando R$" + res.getMensalidade() + " de " + res.getNome());
    }
}
```

---

## 4. Exercícios e Desafios

### Exercício 1: Protobuf vs JSON Size
Faça uma requisição REST que retorne os dados de um Aluno (usando o Postman) e anote o tamanho do Payload em Bytes. Faça a mesma requisição utilizando o cliente **BloomRPC** na porta gRPC e comprove a economia colossal de tamanho na transferência.

### Desafio 1: Streaming Server-to-Client
No REST, se você pede o relatório financeiro de 1 milhão de alunos, você precisa baixar o arquivo inteiro para começar a ler. O gRPC possui *Server Streaming*. Crie um endpoint gRPC `rpc BaixarHistorico (FiltroRequest) returns (stream AlunoResponse)`. Envie do servidor para o cliente 1 Aluno por vez pela rede e veja a mágica do processamento contínuo sem estouro de RAM!
