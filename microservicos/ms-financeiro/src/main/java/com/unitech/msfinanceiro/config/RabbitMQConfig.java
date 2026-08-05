package com.unitech.msfinanceiro.config;

import org.springframework.amqp.core.Queue;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class RabbitMQConfig {

    @Bean
    public Queue matriculaConcluidaQueue() {
        return new Queue("matricula.concluida.queue", true);
    }

}
