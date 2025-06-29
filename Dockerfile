# Multi-stage build for better caching and smaller final image
FROM eclipse-temurin:17-jdk-jammy as builder

# Install Ansible and frontend dependencies
RUN apt-get update && \
    apt-get install -y ansible python3-pip nodejs npm && \
    npm install -g @angular/cli && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy backend files
COPY backend/pom.xml backend/mvnw ./backend/
COPY backend/.mvn ./backend/.mvn
RUN cd backend && ./mvnw dependency:go-offline

# Copy frontend files
COPY frontend/package.json frontend/package-lock.json ./frontend/
RUN cd frontend && npm install

# Copy remaining files
COPY . .

# Build backend
RUN cd backend && ./mvnw package -DskipTests

# Build frontend
RUN cd frontend && npm run build -- --configuration production

# Final image
FROM eclipse-temurin:17-jdk-jammy

# Install Ansible only (no build tools needed)
RUN apt-get update && \
    apt-get install -y ansible python3-pip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy built artifacts from builder
COPY --from=builder /app/backend/target/*.jar ./app.jar
COPY --from=builder /app/frontend/dist ./frontend/dist
COPY ansible ./ansible

# Copy entrypoint script
COPY entrypoint.sh .
RUN chmod +x entrypoint.sh

EXPOSE 8080 4200

ENTRYPOINT ["./entrypoint.sh"]