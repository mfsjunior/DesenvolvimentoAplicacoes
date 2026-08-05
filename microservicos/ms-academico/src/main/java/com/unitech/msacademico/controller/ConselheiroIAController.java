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
        String contexto = "VocÃª Ã© um orientador pedagÃ³gico da UniTech. Responda: " + pergunta;
        return chatClient.call(contexto);
    }
}
