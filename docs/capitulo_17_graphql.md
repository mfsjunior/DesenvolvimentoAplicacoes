# Capítulo 17 — APIs sob Demanda com GraphQL

**Branch:** `branch-25-graphql`
**Release:** 2.7
**Tipo de Evolução:** API e Integração (não-funcional)
**Risco:** Médio — Introduce um novo paradigma de consulta concorrente ao REST.
**Compatibilidade:** Backward-compatible (Rodará em paralelo à API REST).

---

## 1. História da Empresa

Ao criarem o aplicativo *Mobile* (iOS e Android) da UniTech, os desenvolvedores de front-end enfrentaram dois grandes inimigos do mundo REST: **Over-fetching** e **Under-fetching**.

**O problema do Over-fetching:** 
Para mostrar a lista de alunos na tela inicial do app móvel, o celular precisava chamar `GET /api/pessoas`. A API REST retornava um JSON gigantesco de 10MB contendo RG, CPF, Endereço e Filiação de todos os alunos, gastando a franquia de dados 4G do usuário apenas para renderizar uma tela que só exibia a `Foto` e o `Nome`.

**O problema do Under-fetching:**
Quando o aluno abria a "Página de Detalhes da Turma", o celular precisava fazer:
1. `GET /api/turmas/1` (Pega a turma)
2. `GET /api/professores/4` (Pega o professor que dá aula na turma)
3. `GET /api/alunos?turma=1` (Pega os alunos matriculados)
Foram 3 requisições de rede lentas (Round-trips) para montar uma única tela.

A equipe Front-End implorou: *"Por favor, Backend, criem um endpoint específico que junte exatamente as coisas que eu preciso para essa tela!"*.
Mas o Arquiteto backend se recusou a criar milhares de rotas específicas para cada tela do sistema. A solução definitiva de mercado para isso atende pelo nome de **GraphQL**.

---

## 2. A Evolução: O Fim do REST?

Desenvolvido pelo Facebook, o GraphQL inverte o controle. No REST, o Servidor dita o formato do JSON que ele quer enviar. No GraphQL, o **Cliente (Celular/Browser)** dita exatamente as colunas e os relacionamentos que ele deseja receber. O servidor apenas obedece.

Um único endpoint POST (`/graphql`) substitui quase todos os controladores da sua aplicação.

---

## 3. O Código (Spring for GraphQL)

Definimos o contrato no formato de um Schema (`schema.graphqls`).

```graphql
type Aluno {
    id: ID!
    nome: String!
    matricula: String!
    cursos: [Curso]
}

type Curso {
    id: ID!
    nome: String!
}

type Query {
    alunoPorId(id: ID!): Aluno
    todosOsAlunos: [Aluno]
}
```

E mapeamos os "Resolvers" no Java usando o moderno `@Controller` de GraphQL:

```java
@Controller
public class AlunoGraphController {
    
    @QueryMapping
    public Aluno alunoPorId(@Argument Long id) {
        return alunoRepository.findById(id).orElse(null);
    }
    
    @SchemaMapping(typeName = "Aluno", field = "cursos")
    public List<Curso> buscarCursosDoAluno(Aluno aluno) {
        // Isso resolve o problema de relacionamentos profundos.
        // Só será executado se o Cliente Mobile EXPLICITAMENTE pedir a lista de cursos!
        return cursoRepository.findByAlunoId(aluno.getId());
    }
}
```

---

## 4. Como o Celular faz a requisição

O aplicativo manda uma string (Query) para o backend:

```graphql
query {
  alunoPorId(id: 1) {
    nome
    cursos {
      nome
    }
  }
}
```

E o Servidor responde um JSON minúsculo e focado:

```json
{
  "data": {
    "alunoPorId": {
      "nome": "João da Silva",
      "cursos": [
        { "nome": "Engenharia de Software" }
      ]
    }
  }
}
```

Sem CPFs, sem RGs, sem excesso de dados trafegando.

---

## 5. Exercícios e Desafios

### Exercício 1: GraphiQL Explorer
Acesse `http://localhost:8080/graphiql` pelo navegador. Use o editor interativo para explorar a documentação viva e montar requisições pedindo apenas a letra inicial do nome dos alunos. Veja o auto-complete funcionando!

### Desafio 1: O Problema do N+1
O GraphQL pode derrubar o banco de dados se não for bem programado. Se você pedir a lista de 100 alunos e os cursos de cada um, a JPA fará 1 query para os alunos e 100 queries separadas para os cursos (N+1). Pesquise e instale o `DataLoader` do Spring para englobar (Batching) essas requisições em 1 única query `IN (...)`.
