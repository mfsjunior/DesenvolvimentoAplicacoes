# Capítulo 19 — Inteligência Artificial Generativa com Spring AI

**Branch:** `branch-27-ia`
**Release:** 2.9
**Tipo de Evolução:** Inovação / Negócio (Funcional)
**Risco:** Médio — Integração com APIs externas estocásticas (LLMs como OpenAI/Gemini), o que pode gerar custos imprevisíveis e latência.
**Compatibilidade:** Funcionalidade Aditiva.

---

## 1. História da Empresa

Nós chegamos ao topo da montanha da Engenharia de Software Clássica. A **UniTech Soluções Acadêmicas** tinha um sistema resiliente, rápido, escalável, monitorado e seguro. O problema agora era de Negócios: **Evasão Escolar**.

Muitos alunos se matriculavam no primeiro semestre, não sabiam quais matérias complementares escolher, ficavam desmotivados e abandonavam a faculdade. O setor pedagógico pediu uma funcionalidade revolucionária: *"Queremos um sistema de recomendação personalizado. Queremos que o aplicativo converse com o aluno, entenda suas notas, suas matérias preferidas e sugira a trilha acadêmica ideal baseada no currículo do MEC."*

Fazer isso com "If/Else" (Sistemas Especialistas antigos) seria impossível. Fazer isso treinando um modelo próprio de Machine Learning levaria 6 meses e custaria 1 milhão de reais em cientistas de dados.

A solução da arquitetura moderna foi adotar os **Large Language Models (LLMs)** conectados diretamente ao código Java através do framework oficial **Spring AI**.

---

## 2. A Evolução: RAG (Retrieval-Augmented Generation)

Você não pode simplesmente mandar uma mensagem pro ChatGPT perguntando "Qual matéria o João da Silva deve cursar?". O ChatGPT não conhece o seu banco de dados, nem quem é João, nem as matérias da UniTech (isso são dados privados e proprietários).

Nós implementamos o padrão **RAG**:
1. O aluno pergunta ao sistema: "Quero uma matéria fácil sobre matemática para esse semestre".
2. O sistema intercepta a pergunta.
3. O Java vai no PostgreSQL, pega o Histórico Escolar do João.
4. O Java empacota a pergunta do João + o Histórico Escolar + As Ementas dos Cursos da UniTech, criando um "Super Prompt".
5. O Java envia esse Super Prompt para a API do Modelo (ex: GPT-4).
6. O modelo junta a Inteligência Artificial Geral com os Dados Privados e devolve uma resposta perfeitamente embasada.

---

## 3. O Código (Spring AI na Prática)

Adicionamos a dependência `spring-ai-openai-spring-boot-starter`. Injetamos o Client e configuramos o System Prompt.

```java
@RestController
@RequestMapping("/api/ia/conselheiro")
public class ConselheiroIAController {

    private final ChatClient chatClient;
    private final AlunoRepository alunoRepository;
    private final CursoRepository cursoRepository;

    public ConselheiroIAController(ChatClient.Builder chatClientBuilder, 
                                   AlunoRepository alunoRepository, 
                                   CursoRepository cursoRepository) {
        // Configuramos a "Personalidade" do robô
        this.chatClient = chatClientBuilder
            .defaultSystem("Você é um orientador pedagógico gentil da faculdade UniTech. " +
                           "Baseie-se APENAS nos dados fornecidos abaixo para recomendar cursos. " +
                           "Não recomende cursos que o aluno já fez ou foi reprovado.")
            .build();
        this.alunoRepository = alunoRepository;
        this.cursoRepository = cursoRepository;
    }

    @PostMapping("/perguntar/{alunoId}")
    public String recomendarTrilha(@PathVariable Long alunoId, @RequestBody String perguntaAluno) {
        
        // Passo 1: Buscar Dados Privados do Banco (Retrieval)
        Aluno aluno = alunoRepository.findByIdComHistorico(alunoId);
        List<Curso> disponiveis = cursoRepository.findAll();
        
        // Passo 2: Montar Contexto (Augmented)
        String contexto = String.format("""
            Dados do Aluno: Nome %s, Notas Anteriores: %s.
            Cursos Disponíveis neste semestre: %s.
            Pergunta do Aluno: %s
            """, aluno.getNome(), aluno.getHistorico(), disponiveis, perguntaAluno);

        // Passo 3: Geração (Generation)
        return this.chatClient.prompt()
            .user(contexto)
            .call()
            .content();
    }
}
```

E voilà. O aluno recebe:
*"Olá João! Vi que você tirou 9.5 em Lógica de Programação, mas sofreu um pouco (nota 6.0) em Cálculo. Como você pediu algo na linha de exatas porem mais acessível, sugiro você cursar 'Estatística Aplicada a Dados' neste semestre..."*

A Inteligência Artificial agora faz parte do coração transacional do software corporativo.

---

## 4. Exercícios e Desafios

### Exercício 1: Gerando Chave de API
Crie uma conta gratuita (ex: Groq, Gemini ou OpenAI), pegue a sua `API_KEY` e injete no seu `application.yml` na chave `spring.ai.openai.api-key`. Dispare uma requisição POST e veja o retorno Mágico gerado pelo LLM chegar na sua tela.

### Desafio 1: Função de Chamada (Tool Calling)
Se o aluno perguntar "Faz a matrícula pra mim na matéria sugerida?", o LLM não tem mãos para fazer INSERT no banco. Estude e aplique o conceito de `Function Calling` no Spring AI (usando a anotação `@Tool` no Java) permitindo que o LLM "clique" no botão interno da sua API de matrícula sem intervenção humana! O robô virou um Agente Autônomo.

---

# Epílogo

Parabéns, arquiteto. Você concluiu as 19 etapas evolutivas de um software corporativo. O sistema começou como um crud imperativo travado de banco de dados e terminou como um Cluster Kubernetes global, distribuído, resiliente, protegido por malhas criptográficas e impulsionado por Inteligência Artificial.

Você está pronto para liderar qualquer equipe de tecnologia do mundo.
