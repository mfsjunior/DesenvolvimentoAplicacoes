# 🏭 Backlog da Fábrica de Software - Frontend UniTech

Neste documento, estruturamos as tarefas pendentes do projeto Frontend utilizando a metodologia ágil de **User Stories (Histórias de Usuário)**. 
A arquitetura de referência inicial já foi construída (Configuração Vite, React Router, chamadas Axios com CORS, Layout Dark Mode, Alunos e Conselheiro IA).

Seu papel agora, como Desenvolvedor(a) da nossa Fábrica de Software, é implementar as histórias abaixo consumindo as APIs REST (orquestradas pelo Gateway) que já existem no Backend.

---

## 📌 ÉPICO 1: Autenticação e Segurança

### US-01: Login e Integração JWT
**Como** usuário do sistema (Professor, Aluno ou Admin)
**Quero** fazer login informando minhas credenciais
**Para que** eu possa acessar os módulos protegidos e ser identificado pelo sistema.

**Critérios de Aceite:**
1. Criar a tela de `Login.tsx` com formulário de E-mail e Senha.
2. O formulário deve fazer um `POST /api/auth/login` (consumindo o `ms-auth`).
3. Ao receber o Token JWT de resposta, o Frontend deve salvá-lo no `localStorage` (ou `sessionStorage`).
4. Criar um **Axios Interceptor** no arquivo `src/services/api.ts` para que todas as futuras requisições (como a de listar alunos) insiram automaticamente o header `Authorization: Bearer <TOKEN>`.
5. Redirecionar o usuário para o `/` (Dashboard) após o login com sucesso.

---

## 📌 ÉPICO 2: Core Acadêmico (PostgreSQL)

### US-02: Gestão de Cursos
**Como** administrador acadêmico
**Quero** poder cadastrar novos cursos e visualizar os já existentes
**Para que** a universidade possa expandir seu catálogo de ofertas.

**Critérios de Aceite:**
1. Criar a página `CursosPage.tsx` contendo um layout similar ao de Alunos (Formulário à esquerda, Tabela à direita).
2. O formulário deve possuir os campos: Nome do Curso, Carga Horária e Departamento.
3. Deve disparar a chamada `POST /api/cursos` no momento de submissão.
4. A tabela de listagem deve ser alimentada pelo endpoint `GET /api/cursos`.
5. Adicionar a rota `/cursos` no `App.tsx` e o respectivo ícone no Menu Lateral.

### US-03: Corpo Docente (Professores)
**Como** coordenador acadêmico
**Quero** gerenciar o cadastro de professores
**Para que** eu possa vinculá-los às disciplinas futuramente.

**Critérios de Aceite:**
1. Criar a página `ProfessoresPage.tsx`.
2. A tela deve permitir cadastrar (Nome, Titulação, CPF) e listar os professores usando as rotas `POST /api/professores` e `GET /api/professores`.

---

## 📌 ÉPICO 3: Processos e Eventos Assíncronos

### US-04: Matrícula de Aluno em um Curso
**Como** secretário(a) ou próprio aluno
**Quero** poder vincular um Aluno a um Curso
**Para que** a vida letiva do aluno seja iniciada e faturada.

**Critérios de Aceite:**
1. Criar uma interface para vinculação (pode ser uma página separada `MatriculasPage.tsx` ou um botão de ação "Matricular" dentro da tela de Alunos).
2. A interface precisa de 2 inputs principais: ID do Aluno e ID do Curso.
3. Chamar a rota `POST /api/matriculas` enviando essas duas informações.
4. O frontend deve apresentar um *toast* ou mensagem de sucesso informando: "Matrícula realizada. O setor financeiro será notificado em instantes." (já que no backend isso aciona um evento RabbitMQ silenciosamente).

---

## 📌 ÉPICO 4: Módulo Financeiro

### US-05: Faturas e Pagamentos do Aluno
**Como** aluno logado no sistema
**Quero** visualizar todas as faturas que foram geradas para mim e realizar pagamentos
**Para que** eu consiga manter a minha situação financeira regular.

**Critérios de Aceite:**
1. Criar a página `FinanceiroPage.tsx`.
2. Permitir a digitação de um ID de aluno (se não houver login contextualizado) para carregar as faturas.
3. Consumir o endpoint `GET /api/faturas/aluno/{alunoId}` (sendo direcionado automaticamente pelo Gateway para o `ms-financeiro`).
4. Apresentar uma tabela mostrando as faturas (ID, Curso Ref, Valor, Data de Vencimento e Status [PENDENTE / PAGO]).
5. Incluir um botão verde "Pagar" na linha das faturas Pendentes. Ao clicar, o botão deve disparar um `PUT /api/faturas/{faturaId}/pagar` e, ao retornar sucesso (Status 200), atualizar o status da tabela visualmente para PAGO.
