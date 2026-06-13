# Spring PetClinic - Multi-Stage Docker 

This repository contains the containerized version of the **Spring PetClinic** application, optimized using a modern **Multi-Stage Docker architecture** .

---

## 🏗️ Architecture Overview

To minimize the final production footprint and improve security, this project leverages a **Multi-Stage Docker Build**. 



### Stage 1: Build & Package (Maven + JDK)
* Uses a full `maven:3.9-eclipse-temurin-21-alpine` image.
* Isolates and caches dependency resolution (`pom.xml`) to speed up subsequent builds.
* Compiles the source code and packages it into an executable fat JAR while discarding test overhead for runtime efficiency.

### Stage 2: Production Runtime (JRE)
* Uses a highly stripped-down, secure `eclipse-temurin:21-jre-alpine` runtime environment.
* Copies *only* the compiled `.jar` artifact from Stage 1.
* Drops the final image size by **over 60%** by excluding development tools, compilers, and debugging symbols.

---

## 🛠️ Local Development Setup

### Prerequisites
* [Docker Desktop](https://www.docker.com/products/docker-desktop/) installed and running.
* Git installed locally.

### 1. Build the Docker Image
Clone the repo into your remote machine

From the root directory of the project, run the following command to execute the multi-stage build:
```bash
docker build -t spring-petclinic:latest .
```

### 2. Run the Container

Spin up the application container. We map host port 8001 instead of 8080 to prevent port conflicts with local services (like Jenkins):

docker run -d -p 8001:8080 --name petclinic-app spring-petclinic:latest


### 3. Verify the Application
Open your web browser and navigate to:
👉 http://localhost:8001

To tail the live boot logs and verify the Spring context initializes properly, run:

docker logs -f petclinic-app
<img width="1432" height="836" alt="Screenshot 2026-06-14 010357" src="https://github.com/user-attachments/assets/8ff90bef-6e5e-424b-bb98-5cee995694cf" />

<img width="1397" height="721" alt="Screenshot 2026-06-14 010409" src="https://github.com/user-attachments/assets/364b4beb-684d-4957-bf55-aa1e3a85f5ea" />

<img width="1686" height="871" alt="Screenshot 2026-06-14 010416" src="https://github.com/user-attachments/assets/960fa726-6294-484c-af22-92208720f413" />



