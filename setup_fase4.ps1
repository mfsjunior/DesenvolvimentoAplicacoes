$k8sDir = "k8s\microservices"
New-Item -Path $k8sDir -ItemType Directory -Force | Out-Null

# ms-academico deployment
$acadDeploy = @"
apiVersion: apps/v1
kind: Deployment
metadata:
  name: ms-academico
spec:
  replicas: 2
  selector:
    matchLabels:
      app: ms-academico
  template:
    metadata:
      labels:
        app: ms-academico
    spec:
      containers:
      - name: ms-academico
        image: unitech/ms-academico:latest
        ports:
        - containerPort: 8082
        env:
        - name: SPRING_DATASOURCE_URL
          value: jdbc:postgresql://postgres-service:5432/academico_db
---
apiVersion: v1
kind: Service
metadata:
  name: ms-academico-service
spec:
  selector:
    app: ms-academico
  ports:
    - protocol: TCP
      port: 8082
      targetPort: 8082
"@
Set-Content -Path "$k8sDir\ms-academico.yml" -Value $acadDeploy -Encoding UTF8

# ms-perfil deployment
$perfDeploy = @"
apiVersion: apps/v1
kind: Deployment
metadata:
  name: ms-perfil
spec:
  replicas: 1
  selector:
    matchLabels:
      app: ms-perfil
  template:
    metadata:
      labels:
        app: ms-perfil
    spec:
      containers:
      - name: ms-perfil
        image: unitech/ms-perfil:latest
        ports:
        - containerPort: 8084
        env:
        - name: SPRING_DATA_MONGODB_URI
          value: mongodb://admin:adminpassword@mongodb-service:27017/perfil_db?authSource=admin
---
apiVersion: v1
kind: Service
metadata:
  name: ms-perfil-service
spec:
  selector:
    app: ms-perfil
  ports:
    - protocol: TCP
      port: 8084
      targetPort: 8084
"@
Set-Content -Path "$k8sDir\ms-perfil.yml" -Value $perfDeploy -Encoding UTF8

Write-Host "Fase 4 (Manifestos Kubernetes) preparada."
