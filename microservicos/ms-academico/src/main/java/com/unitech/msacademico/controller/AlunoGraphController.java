package com.unitech.msacademico.controller;

import com.unitech.msacademico.model.Aluno;
import com.unitech.msacademico.repository.AlunoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.graphql.data.method.annotation.Argument;
import org.springframework.graphql.data.method.annotation.QueryMapping;
import org.springframework.stereotype.Controller;
import java.util.List;

@Controller
public class AlunoGraphController {

    @Autowired
    private AlunoRepository repository;

    @QueryMapping
    public Aluno alunoPorId(@Argument Long id) {
        return repository.findById(id).orElse(null);
    }

    @QueryMapping
    public List<Aluno> todosOsAlunos() {
        return repository.findAll();
    }
}
