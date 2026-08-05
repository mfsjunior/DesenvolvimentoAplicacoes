$acadPom = "microservicos\ms-academico\pom.xml"
$acadContent = Get-Content $acadPom -Raw
$depsAcad = @"
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-data-redis</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-amqp</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-starter-circuitbreaker-resilience4j</artifactId>
        </dependency>
    </dependencies>
"@
$acadContent = $acadContent -replace "</dependencies>", $depsAcad
Set-Content -Path $acadPom -Value $acadContent -Encoding UTF8

$acadYml = "microservicos\ms-academico\src\main\resources\application.yml"
$acadYmlContent = Get-Content $acadYml -Raw
$acadYmlContent += @"
  redis:
    host: localhost
    port: 6379
  rabbitmq:
    host: localhost
    port: 5672
    username: guest
    password: guest
resilience4j:
  circuitbreaker:
    instances:
      financeiroService:
        registerHealthIndicator: true
        slidingWindowSize: 10
        failureRateThreshold: 50
        waitDurationInOpenState: 10000
"@
Set-Content -Path $acadYml -Value $acadYmlContent -Encoding UTF8

$finPom = "microservicos\ms-financeiro\pom.xml"
$finContent = Get-Content $finPom -Raw
$depsFin = @"
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-amqp</artifactId>
        </dependency>
    </dependencies>
"@
$finContent = $finContent -replace "</dependencies>", $depsFin
Set-Content -Path $finPom -Value $finContent -Encoding UTF8

$finYmlPath = "microservicos\ms-financeiro\src\main\resources\application.yml"
$finYmlContent = @"
server:
  port: 8083
spring:
  application:
    name: ms-financeiro
  rabbitmq:
    host: localhost
    port: 5672
    username: guest
    password: guest
"@
Set-Content -Path $finYmlPath -Value $finYmlContent -Encoding UTF8

$finSrcDir = "microservicos\ms-financeiro\src\main\java\com\unitech\msfinanceiro"
New-Item -Path "$finSrcDir\listener" -ItemType Directory -Force | Out-Null

$finListener = @"
package com.unitech.msfinanceiro.listener;

import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.stereotype.Component;

@Component
public class MatriculaListener {

    @RabbitListener(queues = "matricula.concluida.queue")
    public void processarMensalidade(String mensagem) {
        System.out.println("Processando boleto em background para: " + mensagem);
        // Simulando delay de geração de PDF
        try {
            Thread.sleep(2000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        System.out.println("Boleto gerado com sucesso.");
    }
}
"@
Set-Content -Path "$finSrcDir\listener\MatriculaListener.java" -Value $finListener -Encoding UTF8


$acadMsgDir = "microservicos\ms-academico\src\main\java\com\unitech\msacademico\messaging"
New-Item -Path $acadMsgDir -ItemType Directory -Force | Out-Null
$acadPublisher = @"
package com.unitech.msacademico.messaging;

import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MatriculaPublisher {

    @Autowired
    private RabbitTemplate rabbitTemplate;

    public void notificarFinanceiro(Long alunoId) {
        // Envia mensagem para a fila (Capítulo 6 - Assincronismo)
        rabbitTemplate.convertAndSend("matricula.concluida.queue", "AlunoID: " + alunoId);
    }
}
"@
Set-Content -Path "$acadMsgDir\MatriculaPublisher.java" -Value $acadPublisher -Encoding UTF8

Write-Host "Fase 2 (RabbitMQ, Redis, Resilience4j) configurada com sucesso."
