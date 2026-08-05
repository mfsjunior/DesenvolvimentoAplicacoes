$services = @("ms-academico", "ms-auth", "ms-config-server", "ms-financeiro", "ms-gateway", "ms-perfil")

$plugin = @"
    <build>
        <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
            </plugin>
        </plugins>
    </build>
</project>
"@

foreach ($svc in $services) {
    $pomPath = "microservicos\$svc\pom.xml"
    $content = Get-Content $pomPath -Raw
    
    # Se já tem build/plugins do gRPC (ms-academico e ms-financeiro), a gente não sobrescreve rudemente,
    # mas o spring-boot-maven-plugin já deve estar lá, só precisamos garantir que a tag executions de repackage exista,
    # ou podemos só usar uma regex cuidadosa. Mas como os POMs são nossos, podemos reconstruir.
    
    if ($content -notmatch "spring-boot-maven-plugin") {
        $content = $content -replace "</project>", $plugin
        Set-Content -Path $pomPath -Value $content -Encoding UTF8
    } else {
        # Para os que já têm o plugin, vamos garantir que o repackage goal está lá
        $repackage = @"
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
                <executions>
                    <execution>
                        <goals>
                            <goal>repackage</goal>
                        </goals>
                    </execution>
                </executions>
            </plugin>
"@
        $content = $content -replace "(?s)<plugin>\s*<groupId>org\.springframework\.boot</groupId>\s*<artifactId>spring-boot-maven-plugin</artifactId>\s*</plugin>", $repackage
        Set-Content -Path $pomPath -Value $content -Encoding UTF8
    }
}
Write-Host "POMs corrigidos para Spring Boot Repackage (Executable JAR)."
