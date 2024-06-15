# Etapa 1: Compilar a aplicação
FROM ubuntu:latest AS build

# Atualiza e instala o JDK e Maven
RUN apt-get update && \
    apt-get install -y openjdk-21-jdk maven

# Copia o código-fonte para a imagem
COPY . /app
WORKDIR /app

# Compila o projeto Maven
RUN mvn clean install

# Etapa 2: Criar a imagem final
FROM openjdk:21-jdk-slim

# Expõe a porta 8080
EXPOSE 8080

# Copia o arquivo JAR da etapa de build
COPY --from=build /app/target/demo-0.0.1-SNAPSHOT.jar app.jar

# Define o entrypoint
ENTRYPOINT ["java", "-jar", "app.jar"]
