$gatewayYml = "microservicos\ms-gateway\src\main\resources\application.yml"
$gatewayYmlContent = @"
server:
  port: 8080
spring:
  application:
    name: ms-gateway
  cloud:
    gateway:
      routes:
        - id: academico-route
          uri: http://localhost:8082
          predicates:
            - Path=/api/alunos/**, /graphql/**
        - id: financeiro-route
          uri: http://localhost:8083
          predicates:
            - Path=/api/financeiro/**
        - id: perfil-route
          uri: http://localhost:8084
          predicates:
            - Path=/api/perfis/**
"@
Set-Content -Path $gatewayYml -Value $gatewayYmlContent -Encoding UTF8

$gatewayPom = "microservicos\ms-gateway\pom.xml"
$gatewayPomContent = Get-Content $gatewayPom -Raw
$depsGateway = @"
        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-starter-gateway</artifactId>
        </dependency>
    </dependencies>
"@
$gatewayPomContent = $gatewayPomContent -replace "</dependencies>", $depsGateway
$gatewayPomContent = $gatewayPomContent -replace "<dependency>\s*<groupId>org.springframework.boot</groupId>\s*<artifactId>spring-boot-starter-web</artifactId>\s*</dependency>", ""
Set-Content -Path $gatewayPom -Value $gatewayPomContent -Encoding UTF8


$acadPom = "microservicos\ms-academico\pom.xml"
$acadContent = Get-Content $acadPom -Raw
$depsAcadGraph = @"
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-graphql</artifactId>
        </dependency>
        <dependency>
            <groupId>net.devh</groupId>
            <artifactId>grpc-server-spring-boot-starter</artifactId>
            <version>2.14.0.RELEASE</version>
        </dependency>
    </dependencies>
"@
$acadContent = $acadContent -replace "</dependencies>", $depsAcadGraph
Set-Content -Path $acadPom -Value $acadContent -Encoding UTF8

$graphqlDir = "microservicos\ms-academico\src\main\resources\graphql"
New-Item -Path $graphqlDir -ItemType Directory -Force | Out-Null
$schemaGraphql = @"
type Aluno {
    id: ID!
    nome: String!
    cpf: String!
    matricula: String!
    cursos: [Curso]
}

type Curso {
    id: ID!
    nome: String!
    ementa: String
}

type Query {
    alunoPorId(id: ID!): Aluno
    todosOsAlunos: [Aluno]
}
"@
Set-Content -Path "$graphqlDir\schema.graphqls" -Value $schemaGraphql -Encoding UTF8

$acadCtrlDir = "microservicos\ms-academico\src\main\java\com\unitech\msacademico\controller"
$alunoGraphCtrl = @"
package com.unitech.msacademico.controller;

import com.unitech.msacademico.model.Aluno;
import com.unitech.msacademico.repository.AlunoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.graphql.data.method.annotation.Argument;
import org.springframework.graphql.data.method.annotation.QueryMapping;
import org.springframework.stereotype.Controller;
import java.util.List;

@Controller
public class AlunoGraphController {

    @Autowired
    private AlunoRepository repository;

    @QueryMapping
    public Aluno alunoPorId(@Argument Long id) {
        return repository.findById(id).orElse(null);
    }

    @QueryMapping
    public List<Aluno> todosOsAlunos() {
        return repository.findAll();
    }
}
"@
Set-Content -Path "$acadCtrlDir\AlunoGraphController.java" -Value $alunoGraphCtrl -Encoding UTF8


$finPom = "microservicos\ms-financeiro\pom.xml"
$finContent = Get-Content $finPom -Raw
$depsFinGrpc = @"
        <dependency>
            <groupId>net.devh</groupId>
            <artifactId>grpc-client-spring-boot-starter</artifactId>
            <version>2.14.0.RELEASE</version>
        </dependency>
    </dependencies>
"@
$finContent = $finContent -replace "</dependencies>", $depsFinGrpc
Set-Content -Path $finPom -Value $finContent -Encoding UTF8

Write-Host "Fase 3 (Gateway, GraphQL, gRPC config) preparada."
