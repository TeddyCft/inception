# User Documentation

## Services Overview

This project provides:

* A secure **WordPress website**
* Accessible via **HTTPS only**
* Backed by a **MariaDB database**

---

## Start the Project

```bash
make
```

---

## Stop the Project

```bash
make down
```

---

## Access the Website

Open in browser:

```
https://tcoeffet.42.fr
```

---

## Admin Panel

```
https://tcoeffet.42.fr/wp-admin
```

Login using credentials defined in `.env`.

---

## Credentials

Stored in:

```
srcs/.env
```

Includes:

* Database credentials
* WordPress admin credentials

---

## Check Services

```bash
docker ps
```

Expected containers:

* nginx
* wordpress
* mariadb

---

## Check Logs

```bash
docker logs <container_name>
```

---

## Data Persistence

Data is stored in:

```
/home/tcoeffet/data/
```

* Database → `/mariadb`
* Website → `/wordpress`

Data remains even after stopping containers.

---

## Troubleshooting

### Site not accessible

* Check containers:

```bash
docker ps
```

### Database error

* Ensure MariaDB is running

### Reset everything

```bash
docker compose down -v
sudo rm -rf /home/tcoeffet/data/*
make
```
