#FROM eclipse-temurin:17-jre as builder
#RUN mkdir -p /app/source
#COPY . /app/source
#WORKDIR /app/source
#RUN ./mvnw clean package
#FROM builder
#COPY --from=builder /app/source/target/*.jar /app/app.jar
#EXPOSE 8080
#ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom", "-jar", "/app/app.jar"]

# Stage 1 - Build
FROM maven:3.8.6-openjdk-8 AS builder

RUN mkdir -p /app/source

COPY . /app/source

WORKDIR /app/source

RUN mvn clean package


# Stage 2 - Runtime
FROM openjdk:8-jre-slim

COPY --from=builder /app/source/target/*.jar /app/app.jar

EXPOSE 8080

ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app/app.jar"]
