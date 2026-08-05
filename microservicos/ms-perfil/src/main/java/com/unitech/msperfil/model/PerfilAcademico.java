package com.unitech.msperfil.model;

import lombok.Data;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
import java.util.List;
import java.util.Map;

@Data
@Document(collection = "perfis_academicos")
public class PerfilAcademico {
    @Id
    private String id;
    
    private Long matriculaSqlId;
    private String biografia;
    private Map<String, String> redesSociais;
    private List<String> habilidades;
}
