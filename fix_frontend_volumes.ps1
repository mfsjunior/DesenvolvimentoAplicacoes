$compose = Get-Content docker-compose.yml -Raw
$compose = $compose -replace "(?s)  frontend:.*?environment:\r?\n      - VITE_API_GATEWAY_URL=http://localhost:8080", @"
  frontend:
    build:
      context: ./frontend
    container_name: unitech-frontend
    ports:
      - "5173:5173"
    volumes:
      - ./frontend:/app
      - /app/node_modules
    networks:
      - unitech-network
    environment:
      - VITE_API_GATEWAY_URL=http://localhost:8080
"@
Set-Content -Path docker-compose.yml -Value $compose -Encoding UTF8
