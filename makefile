# Variables
IMAGE_NAME := mansible-docker-container
CONTAINER_NAME := mansible
INTERNALPORT := 4200
EXTERNALPORT ?= 4200
DOCKERFILE := dockerfile
CONTEXT := .

# Build the Docker image (force rebuild with no cache)
build: stop
	docker build -f $(DOCKERFILE) -t $(IMAGE_NAME) $(CONTEXT)

# Run the container
run: stop
	docker run -d --name $(CONTAINER_NAME) -p $(EXTERNALPORT):$(INTERNALPORT) $(IMAGE_NAME)
	@echo "🚀 App running at http://localhost:$(EXTERNALPORT)"

# Stop and remove the container if it's running
stop:
	-@docker rm -f $(CONTAINER_NAME) 2>/dev/null || true

buildstart: build run

# Run interactively (like local dev)
interactive: stop
	docker run --rm -it \
		--name $(CONTAINER_NAME) \
		-p $(EXTERNALPORT):$(INTERNALPORT) \
		$(IMAGE_NAME)


# Show logs
logs:
	docker logs -f $(CONTAINER_NAME)

# Rebuild and restart
rebuild: stop
	docker build --no-cache -f $(DOCKERFILE) -t $(IMAGE_NAME) $(CONTEXT)

# Clean up everything
clean: stop
	docker rmi -f $(IMAGE_NAME) || true
	@echo "🧼 Cleaned up image and container"

.PHONY: build run stop logs rebuild clean
