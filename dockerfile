# Base image
FROM node:20-slim

# Install Ansible
RUN apt-get update && \
    apt-get install -y ansible python3-pip && \
    apt-get clean && \
    npm install -g @angular/cli && \
    rm -rf /var/lib/apt/lists/*

# Set working dir
WORKDIR /app

# Copy backend files
#COPY backend/ ./
COPY frontend/ ./

# Install backend dependencies
RUN npm install

# Expose app port
EXPOSE 4200

# Start server
#CMD ["npm", "start"]
CMD ["ng", "serve", "--host", "0.0.0.0"]