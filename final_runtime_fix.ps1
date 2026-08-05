$compose = Get-Content "docker-compose.yml" -Raw

# Replace gateway routes
$gatewayEnvOld = @"
    environment:
      - SPRING_CLOUD_GATEWAY_ROUTES_0_URI=http://ms-academico:8082
      - SPRING_CLOUD_GATEWAY_ROUTES_1_URI=http://ms-financeiro:8083
      - SPRING_CLOUD_GATEWAY_ROUTES_2_URI=http://ms-perfil:8084
"@
$gatewayEnvNew = @"
    environment:
      - SPRING_CLOUD_COMPATIBILITY_VERIFIER_ENABLED=false
      - SPRING_CLOUD_GATEWAY_ROUTES_0_ID=academico-route
      - SPRING_CLOUD_GATEWAY_ROUTES_0_URI=http://ms-academico:8082
      - SPRING_CLOUD_GATEWAY_ROUTES_0_PREDICATES_0=Path=/api/alunos/**, /graphql/**
      - SPRING_CLOUD_GATEWAY_ROUTES_1_ID=financeiro-route
      - SPRING_CLOUD_GATEWAY_ROUTES_1_URI=http://ms-financeiro:8083
      - SPRING_CLOUD_GATEWAY_ROUTES_1_PREDICATES_0=Path=/api/financeiro/**
      - SPRING_CLOUD_GATEWAY_ROUTES_2_ID=perfil-route
      - SPRING_CLOUD_GATEWAY_ROUTES_2_URI=http://ms-perfil:8084
      - SPRING_CLOUD_GATEWAY_ROUTES_2_PREDICATES_0=Path=/api/perfis/**
"@
$compose = $compose -replace [regex]::Escape($gatewayEnvOld), $gatewayEnvNew

# Add SPRING_CLOUD_COMPATIBILITY_VERIFIER_ENABLED=false to ms-academico
$academicoEnvOld = @"
    environment:
      - SPRING_DATASOURCE_URL=jdbc:postgresql://postgres:5432/academico_db
"@
$academicoEnvNew = @"
    environment:
      - SPRING_CLOUD_COMPATIBILITY_VERIFIER_ENABLED=false
      - SPRING_DATASOURCE_URL=jdbc:postgresql://postgres:5432/academico_db
"@
$compose = $compose -replace [regex]::Escape($academicoEnvOld), $academicoEnvNew

# Add SPRING_CLOUD_COMPATIBILITY_VERIFIER_ENABLED=false to ms-financeiro
$financeiroEnvOld = @"
    environment:
      - SPRING_RABBITMQ_HOST=rabbitmq
"@
$financeiroEnvNew = @"
    environment:
      - SPRING_CLOUD_COMPATIBILITY_VERIFIER_ENABLED=false
      - SPRING_RABBITMQ_HOST=rabbitmq
"@
$compose = $compose -replace [regex]::Escape($financeiroEnvOld), $financeiroEnvNew

# Add SPRING_CLOUD_COMPATIBILITY_VERIFIER_ENABLED=false to ms-perfil
$perfilEnvOld = @"
    environment:
      - SPRING_DATA_MONGODB_URI=mongodb://admin:adminpassword@mongodb:27017/perfil_db?authSource=admin
"@
$perfilEnvNew = @"
    environment:
      - SPRING_CLOUD_COMPATIBILITY_VERIFIER_ENABLED=false
      - SPRING_DATA_MONGODB_URI=mongodb://admin:adminpassword@mongodb:27017/perfil_db?authSource=admin
"@
$compose = $compose -replace [regex]::Escape($perfilEnvOld), $perfilEnvNew

# ms-auth and ms-config-server don't have an environment block yet, so we inject one.
$authOld = @"
  ms-auth:
    build:
      context: ./microservicos/ms-auth
    container_name: unitech-ms-auth
    ports:
      - "8081:8081"
"@
$authNew = @"
  ms-auth:
    build:
      context: ./microservicos/ms-auth
    container_name: unitech-ms-auth
    environment:
      - SPRING_CLOUD_COMPATIBILITY_VERIFIER_ENABLED=false
    ports:
      - "8081:8081"
"@
$compose = $compose -replace [regex]::Escape($authOld), $authNew

$configOld = @"
  ms-config-server:
    build:
      context: ./microservicos/ms-config-server
    container_name: unitech-ms-config-server
    ports:
      - "8888:8888"
"@
$configNew = @"
  ms-config-server:
    build:
      context: ./microservicos/ms-config-server
    container_name: unitech-ms-config-server
    environment:
      - SPRING_CLOUD_COMPATIBILITY_VERIFIER_ENABLED=false
    ports:
      - "8888:8888"
"@
$compose = $compose -replace [regex]::Escape($configOld), $configNew

Set-Content -Path "docker-compose.yml" -Value $compose -Encoding UTF8
Write-Host "docker-compose.yml finally fixed for the final runtime."
