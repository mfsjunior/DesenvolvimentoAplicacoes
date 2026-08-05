$acadPom = "microservicos\ms-academico\pom.xml"
$acadContent = Get-Content $acadPom -Raw
$depsAcadAi = @"
        <dependency>
            <groupId>org.springframework.ai</groupId>
            <artifactId>spring-ai-openai-spring-boot-starter</artifactId>
            <version>0.8.1</version>
        </dependency>
    </dependencies>
"@
$acadContent = $acadContent -replace "</dependencies>", $depsAcadAi
Set-Content -Path $acadPom -Value $acadContent -Encoding UTF8

$acadYml = "microservicos\ms-academico\src\main\resources\application.yml"
$acadYmlContent = Get-Content $acadYml -Raw
$acadYmlContent += @"
  ai:
    openai:
      api-key: \${OPENAI_API_KEY:sk-dummy-key}
      chat:
        options:
          model: gpt-3.5-turbo
"@
Set-Content -Path $acadYml -Value $acadYmlContent -Encoding UTF8

$iaCtrl = @"
package com.unitech.msacademico.controller;

import org.springframework.ai.chat.ChatClient;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/ia/conselheiro")
public class ConselheiroIAController {

    private final ChatClient chatClient;

    public ConselheiroIAController(ChatClient chatClient) {
        this.chatClient = chatClient;
    }

    @PostMapping("/perguntar")
    public String recomendarTrilha(@RequestBody String pergunta) {
        String contexto = "Você é um orientador pedagógico da UniTech. Responda: " + pergunta;
        return chatClient.call(contexto);
    }
}
"@
Set-Content -Path "microservicos\ms-academico\src\main\java\com\unitech\msacademico\controller\ConselheiroIAController.java" -Value $iaCtrl -Encoding UTF8

Write-Host "Fase 5 (Spring AI) preparada."
