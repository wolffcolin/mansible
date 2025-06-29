# Variables
IMAGE_NAME := mansible-docker-container
CONTAINER_NAME := mansible
FRONTEND_PORT := 4200
BACKEND_PORT := 8080
DOCKERFILE := Dockerfile
CONTEXT := .

# Build the Docker image
build: stop
	docker build -f $(DOCKERFILE) -t $(IMAGE_NAME) $(CONTEXT)

# Run the container (production)
run: stop
	docker run -d --name $(CONTAINER_NAME) \
		-p $(FRONTEND_PORT):4200 \
		-p $(BACKEND_PORT):8080 \
		$(IMAGE_NAME)
	@echo "🚀 Frontend running at http://localhost:$(FRONTEND_PORT)"
	@echo "🚀 Backend running at http://localhost:$(BACKEND_PORT)"

# Run in development mode with volume mounts
dev: stop
	docker run -d --name $(CONTAINER_NAME) \
		-p $(FRONTEND_PORT):4200 \
		-p $(BACKEND_PORT):8080 \
		-v $(PWD)/backend:/app/backend \
		-v $(PWD)/frontend:/app/frontend \
		-v $(PWD)/ansible:/app/ansible \
		-e SPRING_PROFILES_ACTIVE=dev \
		$(IMAGE_NAME)

# Run interactively with logs
interactive: stop
	docker run --rm -it \
		--name $(CONTAINER_NAME) \
		-p $(FRONTEND_PORT):4200 \
		-p $(BACKEND_PORT):8080 \
		$(IMAGE_NAME)

# Stop and remove the container
stop:
	-@docker rm -f $(CONTAINER_NAME) 2>/dev/null || true

buildrun: build run

# Show logs
logs:
	docker logs -f $(CONTAINER_NAME)

# Clean up
clean: stop
	docker rmi -f $(IMAGE_NAME) || true
	@echo "🧼 Cleaned up image and container"

.PHONY: build run dev stop logs interactive buildrun clean