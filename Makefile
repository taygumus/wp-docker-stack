# Variables for compose files
COMPOSE_DEV := docker-compose -f docker-compose.yml -f docker-compose.dev.yml
# COMPOSE_PROD  := docker-compose -f docker-compose.yml -f docker-compose.prod.yml

# Default compose (dev by default)
COMPOSE := $(COMPOSE_DEV)

# Primary targets
up: 
	@$(COMPOSE) up -d --build

down: 
	@$(COMPOSE) down

clean: 
	@$(COMPOSE) down -v

restart: down up

reset: clean up

logs: 
	@$(COMPOSE) logs -f

# Dev-specific targets (requires containers to be running)
sync-site-url: 
	@$(COMPOSE) exec -T wp-cli sh /scripts/wp-init/site-url/sync-site-url.sh

db-backup: 
	@$(COMPOSE) exec -T db-cli sh /scripts/db-backup/run-db-backup-once.sh

db-restore: 
	@$(COMPOSE) exec -T db-cli sh -c "/scripts/db-cli/run-db-restore.sh '$(SQLFILE)'"

.PHONY: up down clean restart reset logs sync-site-url db-backup db-restore