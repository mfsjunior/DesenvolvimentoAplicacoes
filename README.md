# 🚀 Desenvolvimento de Aplicações - Arquitetura de Microsserviços

Bem-vindo ao repositório oficial da disciplina de **Desenvolvimento de Aplicações**. 
Neste semestre, não construímos apenas um sistema; nós vivenciamos a **Evolução Arquitetural** completa de um software. Saímos de um simples Monolito Crud até alcançarmos um Ecossistema Complexo, Orientado a Eventos, com Persistência Poliglota e Inteligência Artificial.

---

## 🗺️ O Que Vamos Trabalhar Neste Semestre na Disciplina?
O objetivo desta disciplina é preparar você para os desafios reais da Engenharia de Software Moderna. Ao longo do semestre, focamos em conceitos práticos de alta demanda no mercado corporativo:

1. **Evolução de Arquiteturas (Monolito vs Microsserviços)**: Compreender os *trade-offs*, as dores do acoplamento e as estratégias de estrangulamento para fatiar aplicações legadas.
2. **Padrões de Nuvem (Cloud Native Patterns)**: Implementação na prática de API Gateways, Service Discovery (Eureka), Configurações Centralizadas e Load Balancing.
3. **Persistência Poliglota**: Saber escolher a ferramenta certa para o problema certo. Quando o relacionamento rígido do **PostgreSQL** é necessário e quando a flexibilidade do **MongoDB** brilha.
4. **Arquitetura Orientada a Eventos (EDA)**: Desacoplamento de processos pesados (como financeiro e matrícula) utilizando **RabbitMQ**.
5. **Performance e Resiliência**: Mitigação de latência com cache distribuído (**Redis**) e prevenção de falhas em cascata utilizando Circuit Breakers (Resilience4j).
6. **Integração com IA Generativa**: Como construir sistemas inteligentes com **Spring AI** e interagir com Large Language Models (como a OpenAI).
7. **Containerização (DevOps)**: Empacotamento de toda a plataforma de forma isolada com **Docker** e **Docker Compose**, unindo Frontend e Backend em uma única rede virtual.

---

## 🏗️ O Que Já Fizemos (A Nossa Jornada)

O código deste projeto sofreu evoluções semanais (separadas historicamente por *branches* de estudo). A jornada técnica que concluímos abrangeu as seguintes fases vitais:

### 🔹 FASE 1: O Monolito Básico (Fundação)
- Construímos a base com Spring Boot e um banco único.
- Adicionamos autenticação blindada com JWT e Spring Security.
- Modelamos domínios com relacionamentos complexos, filtros, paginação e ordenação de buscas.
- *Branches de referência: `1` a `7`.*

### 🔹 FASE 2: A Quebra (Nasce o Ecossistema)
- Estrangulamos o monolito em pedaços menores.
- Subimos o `ms-config-server` para governança unificada de propriedades (application.yml injetado pelo GitHub).
- *Branches de referência: `8` a `12`.*

### 🔹 FASE 3: Orquestração e Comunicação
- Implantamos o `ms-gateway` como porta de entrada única (Porta 8080) roteando para os demais módulos.
- Implementamos a comunicação síncrona: usamos o bom e velho HTTP/REST (OpenFeign) e escalamos para altíssima performance binária usando **gRPC e Protobuf** entre `ms-academico` e `ms-financeiro`.
- Fixamos o **PostgreSQL** para transações ACID (Acadêmico) e o **MongoDB** para dados flexíveis (Perfis).
- *Branches de referência: `13` a `18`.*

### 🔹 FASE 4: Mensageria e Assincronicidade
- Resolvemos o gargalo do processamento introduzindo o **RabbitMQ**.
- Agora, quando uma matrícula é realizada no `ms-academico`, um evento é emitido na fila `matricula.concluida.queue` e consumido silenciosamente pelo `ms-financeiro`.
- *Branches de referência: `19` a `23`.*

### 🔹 FASE 5: Alta Performance e Inteligência
- Integramos o **Redis** para salvar e entregar dados imutáveis quase que instantaneamente.
- Injetamos o **Spring AI** dentro do `ms-academico` para atuar como um *Conselheiro Pedagógico IA*, capaz de conversar com o usuário.
- *Branches de referência: `24` a `27`.*

### 🔹 FASE 6: O Gran Finale (Fullstack + DevOps)
- Refatoramos todo o build com Maven (Fat JARs) e empacotamos tudo em **Containers Docker**.
- Criamos o nosso **Frontend em React + Vite**, totalmente desacoplado, limpo (sem bibliotecas CSS pesadas, puramente *Dark Mode Vanilla CSS*), hospedado localmente pelo Docker e consumindo o nosso Gateway de forma segura com CORS configurado.
- *Branch final (Gabarito Completo): `feature/frontend-react`.*

---

## 💻 Arquitetura Final Implementada

Nosso ecossistema orquestrado agora conta com a seguinte estrutura física:

- **Frontend:**
  - `unitech-frontend`: (React + Vite na porta `5173`)
- **Core Microsserviços Java:**
  - `unitech-ms-gateway`: Roteador Central (Porta `8080`)
  - `unitech-ms-auth`: Gerenciador de Identidades e JWT
  - `unitech-ms-academico`: Core Relacional Educacional (Porta `8082`)
  - `unitech-ms-financeiro`: Worker Assíncrono (Porta `8083`)
  - `unitech-ms-perfil`: Core NoSQL Flexível (Porta `8084`)
  - `unitech-ms-config-server`: Ponto Central de Configurações
- **Infraestrutura em Nuvem (Docker):**
  - `unitech-postgres`: Banco Relacional (Porta `5432`)
  - `unitech-mongodb`: Banco de Documentos (Porta `27017`)
  - `unitech-rabbitmq`: Message Broker (Porta `5672/15672`)
  - `unitech-redis`: In-memory Data Structure (Porta `6379`)

---

## ⚙️ Como Executar a Versão Completa

A arquitetura inteira está abstraída em um único arquivo de orquestração. Não é necessário ter Java, Node, Postgres ou Mongo instalados na máquina, **basta ter o Docker**.

1. Na branch da versão final (`feature/frontend-react`), abra o seu terminal.
2. Execute o comando mágico:
   ```bash
   docker-compose up -d --build
   ```
3. Aguarde o provisionamento de todos os containers.
4. Acesse o frontend no seu navegador: **[http://localhost:5173](http://localhost:5173)**
5. *(Opcional)* Todas as APIs continuam disponíveis puramente via Gateway através de `http://localhost:8080/api/...`

🎉 **Sejam muito bem-vindos à fronteira moderna do Desenvolvimento de Software.**
