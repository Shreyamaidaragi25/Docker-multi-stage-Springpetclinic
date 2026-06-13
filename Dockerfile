# =========================================================================
# STAGE 1: Build the application using Maven and Java 21
# =========================================================================
# Upgraded to maven:3.9 (which resolves to latest 3.9.x) and eclipse-temurin-21
FROM maven:3.9-eclipse-temurin-21-alpine AS builder

WORKDIR /app

# Copy pom.xml to cache dependencies
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copy the source code and build the war/jar package
COPY src ./src
RUN mvn clean package -DskipTests

# =========================================================================
# STAGE 2: Lightweight Runtime Environment (Java 21)
# =========================================================================
# Upgraded to Java 21 JRE to match the compilation version
FROM eclipse-temurin:21-jre-alpine

WORKDIR /app

EXPOSE 8080

# Copies the compiled artifact from the builder stage
COPY --from=builder /app/target/spring-petclinic-*.jar ./app.jar


ENTRYPOINT ["java", "-jar", "app.jar"]


