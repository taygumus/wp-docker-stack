# WordPress Docker Stack

## Overview

A Docker Compose–based WordPress environment focused on automation, reproducibility, and separation of concerns.

This repository provides a structured and repeatable way to run and manage WordPress using containers. The stack relies on explicit configuration, script-driven automation, and a clear boundary between application logic and infrastructure responsibilities.

The objective is to offer a deterministic and extensible environment suitable for both straightforward WordPress setups and for more advanced development, migration, and data safety scenarios.

## Typical Use Cases

This project supports multiple workflows that commonly emerge when working with WordPress:

1. **Fresh WordPress setup**  
   Run a new WordPress instance with minimal configuration using Docker Compose and environment variables.

2. **Import an existing WordPress project**  
   Reuse an existing WordPress installation by:
   - placing a database dump in `db/init/`
   - copying `wp-content` files into `src/`

   The database is automatically initialized on first startup or restored manually when needed.

3. **Environment migration and site URL synchronization**  
   When importing an existing database, the site URL stored in WordPress may not match the current environment (domain or port).  
   A dedicated initialization service detects the current site URL and synchronizes it with the configured environment to prevent redirect and startup issues.

4. **Continuous database safety**  
   Database content is backed up automatically at configurable intervals using a FIFO rotation policy.  
   Backups and on-demand snapshots can also be triggered manually.
