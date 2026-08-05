$content = Get-Content -Path docker-compose.yml -Raw
$content = $content -replace "(?s)volumes:\s+pgdata:\s+mongodata:.*", ""
$content += @"
  ms-config-server:
    build:
      context: ./microservicos/ms-config-server
    container_name: unitech-ms-config-server
    ports:
      - "8888:8888"
    networks:
      - unitech-network

  ms-auth:
    build:
      context: ./microservicos/ms-auth
    container_name: unitech-ms-auth
    ports:
      - "8081:8081"
    networks:
      - unitech-network

  ms-academico:
    build:
      context: ./microservicos/ms-academico
    container_name: unitech-ms-academico
    environment:
      - SPRING_DATASOURCE_URL=jdbc:postgresql://postgres:5432/academico_db
      - SPRING_RABBITMQ_HOST=rabbitmq
      - SPRING_REDIS_HOST=redis
    ports:
      - "8082:8082"
    depends_on:
      - postgres
      - rabbitmq
      - redis
    networks:
      - unitech-network

  ms-financeiro:
    build:
      context: ./microservicos/ms-financeiro
    container_name: unitech-ms-financeiro
    environment:
      - SPRING_RABBITMQ_HOST=rabbitmq
    ports:
      - "8083:8083"
    depends_on:
      - rabbitmq
    networks:
      - unitech-network

  ms-perfil:
    build:
      context: ./microservicos/ms-perfil
    container_name: unitech-ms-perfil
    environment:
      - SPRING_DATA_MONGODB_URI=mongodb://admin:adminpassword@mongodb:27017/perfil_db?authSource=admin
    ports:
      - "8084:8084"
    depends_on:
      - mongodb
    networks:
      - unitech-network

  ms-gateway:
    build:
      context: ./microservicos/ms-gateway
    container_name: unitech-ms-gateway
    environment:
      - SPRING_CLOUD_GATEWAY_ROUTES_0_URI=http://ms-academico:8082
      - SPRING_CLOUD_GATEWAY_ROUTES_1_URI=http://ms-financeiro:8083
      - SPRING_CLOUD_GATEWAY_ROUTES_2_URI=http://ms-perfil:8084
    ports:
      - "8080:8080"
    depends_on:
      - ms-academico
      - ms-financeiro
      - ms-perfil
    networks:
      - unitech-network

volumes:
  pgdata:
  mongodata:
"@
Set-Content -Path "docker-compose.yml" -Value $content -Encoding UTF8
Write-Host "docker-compose.yml corrigido!"
