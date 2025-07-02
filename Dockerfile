# ---------- build stage ----------
FROM eclipse-temurin:17-jdk-jammy AS builder

# tools for both back- and front-end
RUN apt-get update && \
    apt-get install -y ansible python3-pip nodejs npm && \
    npm install -g @angular/cli && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# backend skeleton
COPY backend/pom.xml backend/mvnw ./backend/
COPY backend/.mvn ./backend/.mvn
RUN chmod +x backend/mvnw && \
    cd backend && ./mvnw dependency:go-offline

# frontend skeleton
COPY frontend/package.json frontend/package-lock.json ./frontend/
RUN cd frontend && npm install

# rest of the source tree
COPY . .

# build backend (wrapper needs +x again after blanket copy)
RUN chmod +x backend/mvnw && \
    cd backend && ./mvnw package -DskipTests

# build frontend
RUN cd frontend && npm run build -- --configuration production


# ---------- runtime stage ----------
FROM eclipse-temurin:17-jdk-jammy AS runtime

RUN apt-get update && \
    apt-get install -y ansible python3-pip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# bring in artefacts
COPY --from=builder /app/backend/target/*.jar ./app.jar
COPY --from=builder /app/frontend/dist ./frontend/dist
COPY ansible ./ansiblex

# entrypoint
COPY entrypoint.sh .
RUN chmod +x entrypoint.sh

EXPOSE 8080 4200
ENTRYPOINT ["./entrypoint.sh"]
