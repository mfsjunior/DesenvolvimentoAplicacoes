$pomPath = "microservicos\ms-academico\pom.xml"
$pomContent = Get-Content $pomPath -Raw
$deps = @"
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-data-jpa</artifactId>
        </dependency>
        <dependency>
            <groupId>org.postgresql</groupId>
            <artifactId>postgresql</artifactId>
            <scope>runtime</scope>
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

$ymlPath = "microservicos\ms-academico\src\main\resources\application.yml"
$ymlContent = @"
server:
  port: 8082
spring:
  application:
    name: ms-academico
  datasource:
    url: jdbc:postgresql://localhost:5432/academico_db
    username: admin
    password: adminpassword
    driver-class-name: org.postgresql.Driver
    hikari:
      maximum-pool-size: 50 # Capítulo 2: Performance
  jpa:
    hibernate:
      ddl-auto: update
    show-sql: true
    properties:
      hibernate:
        format_sql: true
"@
Set-Content -Path $ymlPath -Value $ymlContent -Encoding UTF8

$srcDir = "microservicos\ms-academico\src\main\java\com\unitech\msacademico"
New-Item -Path "$srcDir\model" -ItemType Directory -Force | Out-Null
New-Item -Path "$srcDir\repository" -ItemType Directory -Force | Out-Null
New-Item -Path "$srcDir\controller" -ItemType Directory -Force | Out-Null
New-Item -Path "$srcDir\service" -ItemType Directory -Force | Out-Null

$alunoClass = @"
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
"@
Set-Content -Path "$srcDir\model\Aluno.java" -Value $alunoClass -Encoding UTF8

$cursoClass = @"
package com.unitech.msacademico.model;

import jakarta.persistence.*;
import lombok.Data;
import com.fasterxml.jackson.annotation.JsonIgnore;

@Data
@Entity
@Table(name = "cursos")
public class Curso {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    private String nome;
    private String ementa;
    
    @ManyToOne
    @JoinColumn(name = "aluno_id")
    @JsonIgnore
    private Aluno aluno;
}
"@
Set-Content -Path "$srcDir\model\Curso.java" -Value $cursoClass -Encoding UTF8

$alunoRepo = @"
package com.unitech.msacademico.repository;

import com.unitech.msacademico.model.Aluno;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AlunoRepository extends JpaRepository<Aluno, Long> {
}
"@
Set-Content -Path "$srcDir\repository\AlunoRepository.java" -Value $alunoRepo -Encoding UTF8

$alunoCtrl = @"
package com.unitech.msacademico.controller;

import com.unitech.msacademico.model.Aluno;
import com.unitech.msacademico.repository.AlunoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/alunos")
public class AlunoController {

    @Autowired
    private AlunoRepository repository;

    @GetMapping
    public List<Aluno> listarTodos() {
        return repository.findAll();
    }
    
    @PostMapping
    public Aluno salvar(@RequestBody Aluno aluno) {
        return repository.save(aluno);
    }
}
"@
Set-Content -Path "$srcDir\controller\AlunoController.java" -Value $alunoCtrl -Encoding UTF8

Write-Host "ms-academico configurado com sucesso."
