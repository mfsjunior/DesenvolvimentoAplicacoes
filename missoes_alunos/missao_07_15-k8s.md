# MissÃ£o 07: Alta Disponibilidade: OrquestraÃ§Ã£o com Kubernetes (K8s)

**Contexto de ImplementaÃ§Ã£o:** Branch $branch

---

## ðŸš¨ O Incidente (Problema de NegÃ³cio)
A Black Friday das mensalidades trouxe 3x mais trÃ¡fego que o normal. O nosso Ãºnico container do MS AcadÃªmico chegou a 100% de CPU e o sistema nÃ£o conseguiu se autoescalar.

---

## ðŸŽ¯ A MissÃ£o (Desafio TÃ©cnico)
Migrar a implantaÃ§Ã£o local do Docker Compose para manifestos do Kubernetes (Deployment e Service). Configurar rÃ©plicas para suportar a carga.

---

## âœ… CritÃ©rios de Aceite (Definition of Done)
1. Criar deployment.yaml com 3 eplicas do ms-academico.\n2. Criar um service.yaml do tipo ClusterIP para fazer balanceamento de carga (Round-Robin) entre as rÃ©plicas.

---

## ðŸ“š Dicas e Pesquisa
VocÃª pode testar localmente usando Minikube ou Docker Desktop (ativando o K8s). O K8s cuidarÃ¡ de reiniciar o pod se ele travar.

> **Nota para a FÃ¡brica de Software:** A partir da MissÃ£o 11 (API Gateway), considere integrar as chamadas dessa infraestrutura diretamente nas telas correspondentes do Frontend React.
