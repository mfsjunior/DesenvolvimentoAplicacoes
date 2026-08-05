$services = @("ms-academico", "ms-auth", "ms-config-server", "ms-financeiro", "ms-gateway", "ms-perfil")

$plugin = @"
    <build>
        <plugins>
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
        </plugins>
    </build>
</project>
"@

foreach ($svc in $services) {
    $pomPath = "microservicos\$svc\pom.xml"
    $content = Get-Content $pomPath -Raw
    
    # Strip any existing build block entirely to start fresh (for the simple ones)
    if ($svc -ne "ms-academico" -and $svc -ne "ms-financeiro") {
        $content = $content -replace "(?s)<build>.*</build>", ""
        $content = $content -replace "</project>", $plugin
        Set-Content -Path $pomPath -Value $content -Encoding UTF8
    } else {
        # ms-academico and ms-financeiro have protobuf plugin.
        # We need to make sure spring-boot-maven-plugin has the repackage execution.
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
        # Remove any existing spring-boot-maven-plugin block
        $content = $content -replace "(?s)<plugin>\s*<groupId>org\.springframework\.boot</groupId>\s*<artifactId>spring-boot-maven-plugin</artifactId>.*?</plugin>", ""
        # Inject it back before </plugins>
        $content = $content -replace "</plugins>", "$repackage</plugins>"
        Set-Content -Path $pomPath -Value $content -Encoding UTF8
    }
}

# Add OpenAI API Key to docker-compose
$compose = Get-Content "docker-compose.yml" -Raw
$compose = $compose -replace "SPRING_REDIS_HOST=redis", "SPRING_REDIS_HOST=redis`n      - SPRING_AI_OPENAI_API_KEY=sk-dummy-12345"
Set-Content -Path "docker-compose.yml" -Value $compose -Encoding UTF8

Write-Host "POMs and Compose fixed."
