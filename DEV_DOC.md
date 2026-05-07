# Developer Documentation

This document explains how a developer can set up, build, run, and maintain the Inception project infrastructure.

---

## 1. Project Setup (From Scratch)

### Prerequisites

- Docker
- Docker Compose
- Linux (sudo is mandatory for the project)
- Make utility

---

### Configuration Files

The project relies on the following configuration files:

- `.env` → environment variables (database credentials, domain name, WordPress users)
- `docker-compose.yml` → service orchestration
- Dockerfiles → one per service (NGINX, WordPress, MariaDB)

No prebuilt images are used except Alpine/Debian base images.

---

### Secrets

This project does not use Docker Secrets.

All credentials are stored in the `.env` file as required by the subject specification.

---

## 2. Build and Launch

### Build and start the entire infrastructure

```bash
make
```

This command:

- Creates required host directories (/home/tcoeffet/data/...)
- Sets correct permissions
- Builds all Docker images
- Starts all containers using Docker Compose

---

```bash
make down
```

This removes containers and network, and can optionally reset data depending on implementation.

---
## 3. Container & Volume management

### check running containers
```bash
docker ps
```

---
### Access a container shell
```bash
docker exec -it <container_name> sh
```
Example:
`docker exec -it srcs-wordpress-1 sh`

---
### View logs
```bash
docker logs <container_name>
```

---
### Manage Docker volumes
List volumes:
```bash
docker volume ls
```
Inspect a volume:
```bash
docker volume inspect <volume_name>
```

---
## 4. Data Storage and Persistence

All persistent data is stored on the host machine in:
`/home/tcoeffet/data/`

### Structure:
- `/home/tcoeffet/data/mariadb` -> MariaDB database files
- `/home/tcoeffet/data/wordpress/` -> WordPress website files

---

### Persistence Behavior

Data persists accross container lifecycle events:
- `docker compose down`
- `docker compose up`
- container recreation

Even if containers are removed, data remains because it is stored on the host filesystem via Docker volumes.

Only manual deletion of /home/tcoeffet/data/ removes persistent data.

---

## 5. Network Architecture


All services communicate through a dedicated Docker network:

```
inception
```

### Flow:
1. User → NGINX (HTTPS only)
2. NGINX → WordPress (PHP-FPM)
3. WordPress → MariaDB

---

## 6. Healthcheck System

MariaDB includes a healthcheck:
```
mariadb-admin ping --silent
```
This ensures:

- Database is fully initialized before WordPress starts
- Proper service dependency handling via depends_on

---

## 7. Debugging

### WordPress not reachable
- Check NGINX container:
```
docker logs srcs-nginx-1
```

### Database connection issues

- Ensure MariaDB is healthy:
```
docker ps
```
- Verify environment variables in .env

---

## 8. Key Design Notes

### Docker vs Virtual Machine

Docker is used instead of VMs because:

- lightweight
- faster startup
- isolated services

---

### Volumes vs Bind Mounts
- Named volumes are used to persist data
- Data is physically stored in /home/tcoeffet/data
- Ensures persistence across container restarts

---
### Network Isolation
- Custom bridge network used
- No use of --link or host networking (forbidden)

---
## 9. Summary

This project demonstrates:

- Multi-container architecture
- Secure HTTPS entrypoint (NGINX)
- Persistent database (MariaDB)
- WordPress CMS deployment
- Container orchestration with Docker Compose

---
