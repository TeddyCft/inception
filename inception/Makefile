NAME = inception
COMPOSE = docker compose -f Srcs/docker-compose.yml

all:
	$(COMPOSE) up --build

up:
	$(COMPOSE) up

build:
	$(COMPOSE) build --no-cache

down:
	$(COMPOSE) down

clean:
	$(COMPOSE) down -v

fclean: clean
	docker system prune -af

re: clean all

.PHONY: all up build down clean fclean re