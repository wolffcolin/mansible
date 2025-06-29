#!/bin/sh

# Start Spring Boot backend
java -jar app.jar &

# Serve frontend (use http-server for production)
cd frontend/dist
npx http-server -p 4200 --proxy http://localhost:8080?

wait