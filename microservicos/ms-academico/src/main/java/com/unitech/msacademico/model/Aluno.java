package com.unitech.msacademico.model;

import jakarta.persistence.*;
import lombok.Data;
import java.util.List;

@Data
@Entity
@Table(name = "alunos")
public class Aluno {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    private String nome;
    private String cpf;
    private String matricula;
    
    @OneToMany(mappedBy = "aluno", cascade = CascadeType.ALL)
    private List<Curso> cursos;
}
