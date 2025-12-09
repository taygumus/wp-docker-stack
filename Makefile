# Variables for compose files
COMPOSE_DEV := docker-compose -f docker-compose.yml -f docker-compose.dev.yml
# COMPOSE_PROD  := docker-compose -f docker-compose.yml -f docker-compose.prod.yml

# Default compose (dev by default)
COMPOSE := $(COMPOSE_DEV)

# Primary targets
up: 
	@$(COMPOSE) up -d --build

down: 
	@$(COMPOSE) down -v

restart: down up

logs: 
	@$(COMPOSE) logs -f

# Dev-specific targets (requires containers to be running)
syncsiteurl: 
	@$(COMPOSE) exec -T wp-cli sh /scripts/wp-init/site-url/sync-site-url.sh

restoredb:
	@$(COMPOSE) exec -T db-cli sh -c "/scripts/db-cli/restore-db.sh '$(SQLFILE)'"

.PHONY: up down restart logs syncsiteurl restoredb