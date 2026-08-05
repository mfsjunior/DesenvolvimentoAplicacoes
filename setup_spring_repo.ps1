$acadPom = "microservicos\ms-academico\pom.xml"
$acadContent = Get-Content $acadPom -Raw

$springMilestone = @"
    <repositories>
        <repository>
            <id>spring-milestones</id>
            <name>Spring Milestones</name>
            <url>https://repo.spring.io/milestone</url>
            <snapshots>
                <enabled>false</enabled>
            </snapshots>
        </repository>
    </repositories>
</project>
"@

$acadContent = $acadContent -replace "</project>", $springMilestone
Set-Content -Path $acadPom -Value $acadContent -Encoding UTF8
Write-Host "Spring Milestones repository added."
