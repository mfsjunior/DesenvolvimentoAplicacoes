# Capítulo 16 — Flexibilidade Dinâmica com Bancos NoSQL (MongoDB)

**Branch:** `branch-24-nosql`
**Release:** 2.6
**Tipo de Evolução:** Arquitetura de Dados (não-funcional)
**Risco:** Baixo — Adoção de tecnologia auxiliar paralela ao PostgreSQL.
**Compatibilidade:** Nenhuma alteração nas tabelas relacionais clássicas.

---

## 1. História da Empresa

Na evolução passada (Capítulo 10 - CQRS), vimos o MongoDB ser usado como base de leitura desnormalizada. No entanto, surgiu uma nova demanda funcional na **UniTech**: criar um serviço de "Perfis de Alunos", como uma pequena rede social acadêmica. 

O problema era que a aba de Perfil permitia campos extremamente variáveis: alguns alunos queriam adicionar suas redes sociais (LinkedIn, Twitter), outros queriam adicionar Hobbies, projetos de código, e links de repositórios. No banco relacional PostgreSQL, o DBA tentou criar uma tabela chamada `PerfilAluno` e acabou com 30 colunas, sendo que a maioria ficava `NULL` na maior parte do tempo. Outra alternativa foi tentar mapear uma tabela chata do tipo `Chave_Valor` (`id_aluno, nome_campo, valor_campo`), o que transformou qualquer busca em um inferno de junções.

Dados sem estrutura rígida não pertencem ao mundo rígido. Era hora de trazer um Banco de Dados Orientado a Documentos de forma oficial.

---

## 2. A Evolução: Documentos vs Tabelas

Enquanto o JPA / Hibernate exige que você crie classes Java perfeitamente alinhadas com as Colunas fixas da Tabela SQL, o **Spring Data MongoDB** permite mapear um Documento BSON flexível.

Se a classe Java ganhar um novo atributo `List<String> hobbies`, ao salvar, o MongoDB simplesmente embute um Array dentro do JSON do aluno. Sem migrações Flyway/Liquibase, sem travar tabelas com `ALTER TABLE`.

---

## 3. O Código (Spring Data Mongo)

```java
@Document(collection = "perfis_academicos")
public class PerfilAcademico {
    @Id
    private String id; // UUID ou ObjectId do Mongo
    
    private Long matriculaSqlId; // Ligação Lógica com o PostgreSQL (Polyglot Persistence)
    
    // Campos Flexíveis!
    private String biografia;
    private Map<String, String> redesSociais;
    private List<String> habilidades;
}
```

E o repositório é incrivelmente semelhante ao JPA, porem herdando de `MongoRepository`:

```java
@Repository
public interface PerfilRepository extends MongoRepository<PerfilAcademico, String> {
    // Busca baseada em um array interno! Magia do NoSQL.
    List<PerfilAcademico> findByHabilidadesContaining(String habilidade);
}
```

---

## 4. Arquitetura Poliglota (Polyglot Persistence)

Usar MongoDB não significa aposentar o PostgreSQL. A arquitetura correta é usar **a ferramenta certa para o trabalho certo**.

- **PostgreSQL:** Perfeito para transações financeiras, matrículas, notas, onde a relação `ACID` (Atomicidade, Consistência, Isolamento e Durabilidade) e transações seguras são inegociáveis.
- **MongoDB:** Perfeito para catálogos, logs, perfis de usuários, informações temporárias, ou coleções onde os esquemas evoluem diariamente.

A ligação entre os dois mundos é feita através de referências fracas (O Mongo guarda apenas o `id` da Matrícula gerada pelo PostgreSQL).

---

## 5. Exercícios e Desafios

### Exercício 1: Migração em Larga Escala
Ao salvar o documento via REST, inspecione a estrutura armazenada utilizando o MongoDB Compass. Perceba que as "redes sociais" e "habilidades" viraram matrizes JSON embebidas, impossíveis de serem modeladas perfeitamente de forma barata em Bancos SQL Tradicionais.

### Desafio 1: Paginação e Full Text Search
Crie um índice de busca textual (Text Index) no Mongo e faça uma pesquisa que encontre alunos baseada numa busca semântica em suas bibliografias, ordenando por pontuação de relevância de texto!
