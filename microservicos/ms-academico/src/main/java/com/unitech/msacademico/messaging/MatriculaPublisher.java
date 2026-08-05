package com.unitech.msacademico.messaging;

import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MatriculaPublisher {

    @Autowired
    private RabbitTemplate rabbitTemplate;

    public void notificarFinanceiro(Long alunoId) {
        // Envia mensagem para a fila (CapÃ­tulo 6 - Assincronismo)
        rabbitTemplate.convertAndSend("matricula.concluida.queue", "AlunoID: " + alunoId);
    }
}
