COMPOSE_DEV  := docker compose -f docker-compose.yml -f docker-compose.dev.yml
COMPOSE_PROD := docker compose -f docker-compose.yml -f docker-compose.prod.yml

# --------------------------------------------------
# Development targets
# --------------------------------------------------

up:
	@$(COMPOSE_DEV) up -d --build

down:
	@$(COMPOSE_DEV) down

clean:
	@$(COMPOSE_DEV) down -v

reset: clean up

logs:
	@$(COMPOSE_DEV) logs -f

sync-site-url:
	@$(COMPOSE_DEV) exec -T wp-cli sh /scripts/wp-init/site-url/sync-site-url.sh

db-backup:
	@$(COMPOSE_DEV) exec -T db-cli sh /scripts/db-backup/run-db-backup-once.sh

db-restore:
	@$(COMPOSE_DEV) exec -T db-cli sh -c "/scripts/db-cli/run-db-restore.sh '$(SQLFILE)'"

# --------------------------------------------------
# Production targets
# --------------------------------------------------

up-prod:
	@$(COMPOSE_PROD) up -d

down-prod:
	@$(COMPOSE_PROD) down

logs-prod:
	@$(COMPOSE_PROD) logs -f

certbot-first-issue:
	@$(COMPOSE_PROD) run --rm \
		--entrypoint sh \
		certbot \
		/scripts/certbot/certbot-first-issue/certbot-first-issue.sh

certbot-dry-run:
	@$(COMPOSE_PROD) run --rm \
		--entrypoint sh \
		certbot \
		/scripts/certbot/certbot-dry-run/certbot-dry-run.sh

certbot-renew:
	@$(COMPOSE_PROD) run --rm \
		--entrypoint sh \
		certbot \
		/scripts/certbot/certbot-renew/certbot-renew.sh

.PHONY: up down clean reset logs sync-site-url db-backup db-restore \
        up-prod down-prod logs-prod certbot-first-issue certbot-dry-run certbot-renew
