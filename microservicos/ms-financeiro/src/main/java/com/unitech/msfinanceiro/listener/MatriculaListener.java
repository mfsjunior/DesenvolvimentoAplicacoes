package com.unitech.msfinanceiro.listener;

import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.stereotype.Component;

@Component
public class MatriculaListener {

    @RabbitListener(queues = "matricula.concluida.queue")
    public void processarMensalidade(String mensagem) {
        System.out.println("Processando boleto em background para: " + mensagem);
        // Simulando delay de geraÃ§Ã£o de PDF
        try {
            Thread.sleep(2000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        System.out.println("Boleto gerado com sucesso.");
    }
}
