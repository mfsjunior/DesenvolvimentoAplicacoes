$microservices = @(
    "ms-auth",
    "ms-academico",
    "ms-config-server",
    "ms-financeiro",
    "ms-gateway",
    "ms-perfil"
)

New-Item -Path "microservicos" -ItemType Directory -Force | Out-Null

$parentPom = @"
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <groupId>com.unitech</groupId>
    <artifactId>unitech-microservices</artifactId>
    <version>1.0-SNAPSHOT</version>
    <packaging>pom</packaging>

    <modules>
        <module>ms-auth</module>
        <module>ms-academico</module>
        <module>ms-config-server</module>
        <module>ms-financeiro</module>
        <module>ms-gateway</module>
        <module>ms-perfil</module>
    </modules>

    <properties>
        <java.version>17</java.version>
        <spring-boot.version>3.1.5</spring-boot.version>
        <spring-cloud.version>2022.0.4</spring-cloud.version>
        <maven.compiler.source>17</maven.compiler.source>
        <maven.compiler.target>17</maven.compiler.target>
    </properties>

    <dependencyManagement>
        <dependencies>
            <dependency>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-dependencies</artifactId>
                <version>`${spring-boot.version}</version>
                <type>pom</type>
                <scope>import</scope>
            </dependency>
            <dependency>
                <groupId>org.springframework.cloud</groupId>
                <artifactId>spring-cloud-dependencies</artifactId>
                <version>`${spring-cloud.version}</version>
                <type>pom</type>
                <scope>import</scope>
            </dependency>
        </dependencies>
    </dependencyManagement>
</project>
"@

Set-Content -Path "microservicos\pom.xml" -Value $parentPom -Encoding UTF8

foreach ($ms in $microservices) {
    $dir = "microservicos\$ms"
    New-Item -Path $dir -ItemType Directory -Force | Out-Null
    
    $package = $ms.Replace("-", "")
    $srcDir = "$dir\src\main\java\com\unitech\$package"
    $resDir = "$dir\src\main\resources"
    
    New-Item -Path $srcDir -ItemType Directory -Force | Out-Null
    New-Item -Path $resDir -ItemType Directory -Force | Out-Null
    
    $className = ""
    $ms.Split("-") | ForEach-Object {
        $className += $_.Substring(0,1).ToUpper() + $_.Substring(1).ToLower()
    }
    $className += "Application"
    
    $pom = @"
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <parent>
        <groupId>com.unitech</groupId>
        <artifactId>unitech-microservices</artifactId>
        <version>1.0-SNAPSHOT</version>
    </parent>
    <modelVersion>4.0.0</modelVersion>

    <artifactId>$ms</artifactId>

    <dependencies>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-actuator</artifactId>
        </dependency>
    </dependencies>
</project>
"@
    Set-Content -Path "$dir\pom.xml" -Value $pom -Encoding UTF8
    
    $appClass = @"
package com.unitech.$package;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class $className {
    public static void main(String[] args) {
        SpringApplication.run($className.class, args);
    }
}
"@
    Set-Content -Path "$srcDir\$className.java" -Value $appClass -Encoding UTF8
    
    $port = 8080
    switch ($ms) {
        "ms-auth" { $port = 8081 }
        "ms-academico" { $port = 8082 }
        "ms-config-server" { $port = 8888 }
        "ms-financeiro" { $port = 8083 }
        "ms-gateway" { $port = 8080 }
        "ms-perfil" { $port = 8084 }
    }
    
    $appYml = @"
server:
  port: $port
spring:
  application:
    name: $ms
"@
    Set-Content -Path "$resDir\application.yml" -Value $appYml -Encoding UTF8
}

Write-Host "Scaffolding completed."
