$compose = Get-Content docker-compose.yml -Raw
$compose = $compose -replace "networks:\r?\n  unitech-network:", @"
  frontend:
    build:
      context: ./frontend
    container_name: unitech-frontend
    ports:
      - "5173:5173"
    networks:
      - unitech-network
    environment:
      - VITE_API_GATEWAY_URL=http://localhost:8080

networks:
  unitech-network:
"@
Set-Content -Path docker-compose.yml -Value $compose -Encoding UTF8
