package com.unitech.msperfil.controller;

import com.unitech.msperfil.model.PerfilAcademico;
import com.unitech.msperfil.repository.PerfilRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/perfis")
public class PerfilController {

    @Autowired
    private PerfilRepository repository;

    @GetMapping
    public List<PerfilAcademico> listarTodos() {
        return repository.findAll();
    }
    
    @GetMapping("/habilidade/{hab}")
    public List<PerfilAcademico> buscarPorHabilidade(@PathVariable String hab) {
        return repository.findByHabilidadesContaining(hab);
    }

    @PostMapping
    public PerfilAcademico salvar(@RequestBody PerfilAcademico perfil) {
        return repository.save(perfil);
    }
}
