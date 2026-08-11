# MissÃ£o 14: SeguranÃ§a Zero-Trust: Service Mesh com Istio

**Contexto de ImplementaÃ§Ã£o:** Branch $branch

---

## ðŸš¨ O Incidente (Problema de NegÃ³cio)
Uma varredura de seguranÃ§a identificou que o trÃ¡fego interno (dentro da rede do Docker/K8s) estava em texto plano. Se alguÃ©m hackeasse a rede, conseguiria ler CPFs sendo trafegados entre os serviÃ§os.

---

## ðŸŽ¯ A MissÃ£o (Desafio TÃ©cnico)
Garantir mTLS (Mutual TLS) automÃ¡tico entre todos os microsserviÃ§os usando Service Mesh, sem alterar o cÃ³digo Java.

---

## âœ… CritÃ©rios de Aceite (Definition of Done)
1. Explicar e configurar sidecars (Envoy Proxies) ao lado de cada container.\n2. Toda comunicaÃ§Ã£o interna passarÃ¡ a ser encriptada no trÃ¢nsito.

---

## ðŸ“š Dicas e Pesquisa
O Istio intercepta a porta de saÃ­da do container, criptografa o dado e envia para o Istio de destino.

> **Nota para a FÃ¡brica de Software:** A partir da MissÃ£o 11 (API Gateway), considere integrar as chamadas dessa infraestrutura diretamente nas telas correspondentes do Frontend React.
