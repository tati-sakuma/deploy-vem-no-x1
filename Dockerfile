#
# Build stage
#
FROM maven:3.8.4-openjdk-17 AS build

WORKDIR /app

#Copia as dependencias
COPY pom.xml .

#Copia o projeto
COPY src ./src

# Build do Maven SEM testes unitarios
# RUN mvn clean install -DSkipTests=true
RUN mvn clean package -DSkipTests

#
# Package stage
#
FROM openjdk:17-alpine

WORKDIR /app

COPY --from=build /app/target/*.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java","-jar","vemnox1.jar"]