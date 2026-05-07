*This project has been created as part of the 42 curriculum by tcoeffet.*

# Inception

## Description

This project consists in setting up a small containerized infrastructure using Docker and Docker Compose.

The stack includes:

* **NGINX** with TLS (HTTPS only)
* **WordPress** with PHP-FPM
* **MariaDB** as the database

Each service runs in its own container, built from scratch using Alpine Linux.
The goal is to understand containerization, networking, volumes, and service orchestration.

---

## Instructions

### Requirements

* Docker
* Docker Compose
* Linux environment (sudo rights needed)

### Setup

1. Clone the repository:

```bash
git clone <repo_url> inception
cd inception
```

2. Configure environment variables:

```bash
cd srcs
nano .env

#required env is :
# DOMAIN_NAME=tcoeffet.42.fr

# DB_NAME=XXXX
# DB_USER=XXXX
# DB_PASSWORD=XXXX
# DB_ROOT_PASSWORD=XXXX
# DB_HOST=XXXX

# WP_ADMIN_USER=XXXX
# WP_ADMIN_PASSWORD=XXXX
# WP_ADMIN_EMAIL=XXXX
# WP_USER_NAME=XXXX
# WP_USER_PASSWORD=XXXX
# WP_USER_EMAIL=XXXX
```

3. Launch the project:

```bash
make
```

4. Access the website:

```
https://tcoeffet.42.fr
```

---

## Project Architecture

* **NGINX**

  * Entry point of the infrastructure
  * Handles HTTPS (TLSv1.2 / TLSv1.3)
* **WordPress**

  * Runs with PHP-FPM
  * Connects to MariaDB
* **MariaDB**

  * Stores WordPress data

---

## Technical Choices

### Virtual Machines vs Docker

* **VM**: heavy, full OS
* **Docker**: lightweight, isolated processes
* -> Docker is faster and more efficient

---

### Secrets vs Environment Variables

* **Env variables**: simple but exposed
* **Secrets**: more secure, stored separately
* -> This project uses environment variables but recommends secrets

---

### Docker Network vs Host Network

* **Host network**: no isolation (forbidden)
* **Docker network**: isolated communication between containers
* -> We use a custom Docker network

---

### Docker Volumes vs Bind Mounts

* **Volumes**: managed by Docker
* **Bind mounts**: direct host mapping
* -> This project uses **named volumes with bind mounts** to ensure persistence in `/home/login/data` while still being managed by Docker

---

## Resources

* Docker documentation: https://docs.docker.com/
* NGINX documentation: https://nginx.org/en/docs/
* WordPress CLI: https://developer.wordpress.org/cli/

### AI Usage

AI was used for:

* Debugging Docker configuration
* Understanding healthchecks and container lifecycle
* Improving security practices
* Generating documentation templates

All configurations were reviewed, tested, and validated manually.
