# Variables
COMPOSE_DEV = docker-compose -f docker-compose.yml -f docker-compose.dev.yml

# Main commands

up: 
	$(COMPOSE_DEV) up -d --build

down: 
	$(COMPOSE_DEV) down -v

restart: down up

logs: 
	$(COMPOSE_DEV) logs -f

.PHONY: up down restart logs
