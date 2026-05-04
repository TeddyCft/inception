NAME = inception
COMPOSE = docker compose -f Srcs/docker-compose.yml

DATA_PATH = /home/tcoeffet/data
DB_PATH = $(DATA_PATH)/mariadb
WP_PATH = $(DATA_PATH)/wordpress

all: prepare
	$(COMPOSE) up --build -d

prepare:
	mkdir -p $(DB_PATH) $(WP_PATH)
	sudo chown -R 999:999 $(DB_PATH)
	sudo chmod -R 750 $(DB_PATH)
	sudo chown -R 82:82 $(WP_PATH)
	sudo chmod -R 750 $(WP_PATH)

build:
	$(COMPOSE) build --no-cache

clean:
	$(COMPOSE) down
	docker system prune -af

fclean: 
	$(COMPOSE) down -v --rmi all
	docker system prune -af
	sudo rm -rf $(DATA_PATH)

re: 
	$(MAKE) fclean
	$(MAKE) all

.PHONY: all up build down clean fclean re 