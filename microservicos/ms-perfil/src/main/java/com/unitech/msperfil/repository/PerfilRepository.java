package com.unitech.msperfil.repository;

import com.unitech.msperfil.model.PerfilAcademico;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PerfilRepository extends MongoRepository<PerfilAcademico, String> {
    List<PerfilAcademico> findByHabilidadesContaining(String habilidade);
}
