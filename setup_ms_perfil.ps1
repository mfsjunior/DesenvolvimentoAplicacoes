$pomPath = "microservicos\ms-perfil\pom.xml"
$pomContent = Get-Content $pomPath -Raw
$deps = @"
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-data-mongodb</artifactId>
        </dependency>
        <dependency>
            <groupId>org.projectlombok</groupId>
            <artifactId>lombok</artifactId>
            <optional>true</optional>
        </dependency>
    </dependencies>
"@
$pomContent = $pomContent -replace "</dependencies>", $deps
Set-Content -Path $pomPath -Value $pomContent -Encoding UTF8

$ymlPath = "microservicos\ms-perfil\src\main\resources\application.yml"
$ymlContent = @"
server:
  port: 8084
spring:
  application:
    name: ms-perfil
  data:
    mongodb:
      uri: mongodb://admin:adminpassword@localhost:27017/perfil_db?authSource=admin
"@
Set-Content -Path $ymlPath -Value $ymlContent -Encoding UTF8

$srcDir = "microservicos\ms-perfil\src\main\java\com\unitech\msperfil"
New-Item -Path "$srcDir\model" -ItemType Directory -Force | Out-Null
New-Item -Path "$srcDir\repository" -ItemType Directory -Force | Out-Null
New-Item -Path "$srcDir\controller" -ItemType Directory -Force | Out-Null

$perfilClass = @"
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
"@
Set-Content -Path "$srcDir\model\PerfilAcademico.java" -Value $perfilClass -Encoding UTF8

$perfilRepo = @"
package com.unitech.msperfil.repository;

import com.unitech.msperfil.model.PerfilAcademico;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PerfilRepository extends MongoRepository<PerfilAcademico, String> {
    List<PerfilAcademico> findByHabilidadesContaining(String habilidade);
}
"@
Set-Content -Path "$srcDir\repository\PerfilRepository.java" -Value $perfilRepo -Encoding UTF8

$perfilCtrl = @"
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
"@
Set-Content -Path "$srcDir\controller\PerfilController.java" -Value $perfilCtrl -Encoding UTF8

Write-Host "ms-perfil configurado com sucesso."
