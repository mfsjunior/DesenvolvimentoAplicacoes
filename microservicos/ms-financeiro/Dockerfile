FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
COPY target/ms-financeiro-1.0-SNAPSHOT.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]
