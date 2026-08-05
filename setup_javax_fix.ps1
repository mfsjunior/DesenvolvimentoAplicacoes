$javaxDep = @"
        <dependency>
            <groupId>javax.annotation</groupId>
            <artifactId>javax.annotation-api</artifactId>
            <version>1.3.2</version>
        </dependency>
    </dependencies>
"@

$acadPom = "microservicos\ms-academico\pom.xml"
$acadContent = Get-Content $acadPom -Raw
$acadContent = $acadContent -replace "</dependencies>", $javaxDep
Set-Content -Path $acadPom -Value $acadContent -Encoding UTF8

$finPom = "microservicos\ms-financeiro\pom.xml"
$finContent = Get-Content $finPom -Raw
$finContent = $finContent -replace "</dependencies>", $javaxDep
Set-Content -Path $finPom -Value $finContent -Encoding UTF8

Write-Host "javax.annotation injected."
