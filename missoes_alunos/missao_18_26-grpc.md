# MissÃ£o 18: TrÃ¡fego BinÃ¡rio: Alta Performance Interna via gRPC

**Contexto de ImplementaÃ§Ã£o:** Branch $branch

---

## ðŸš¨ O Incidente (Problema de NegÃ³cio)
O volume de dados sendo transmitido internamente entre o API Gateway e o Backend explodiu. O JSON (que Ã© apenas texto longo) tornou-se o grande vilÃ£o do peso na rede.

---

## ðŸŽ¯ A MissÃ£o (Desafio TÃ©cnico)
Trocar o REST interno por gRPC. Substituir JSON texto por Protobuf binÃ¡rio compactado.

---

## âœ… CritÃ©rios de Aceite (Definition of Done)
1. Criar o arquivo .proto definindo o contrato de comunicaÃ§Ã£o.\n2. Gerar as classes Java automaticamente atravÃ©s do plugin Maven do protobuf.\n3. Implementar um cliente e servidor gRPC para uma funcionalidade core.

---

## ðŸ“š Dicas e Pesquisa
gRPC trafega por HTTP/2 de forma nativa e Ã© infinitamente mais rÃ¡pido que REST puro para chamadas inter-serviÃ§os.

> **Nota para a FÃ¡brica de Software:** A partir da MissÃ£o 11 (API Gateway), considere integrar as chamadas dessa infraestrutura diretamente nas telas correspondentes do Frontend React.
