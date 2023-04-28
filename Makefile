NAME = inception

DOCKER = docker
COMPOSE = docker-compose
DOCKER_FLAGS = -f
DOCKER_FILE = srcs/docker-compose.yml

all: ${NAME}

${NAME}:
	@mkdir -p ../data/nginx
	@mkdir -p ../data/mariadb
	${COMPOSE} ${DOCKER_FLAGS} ${DOCKER_FILE} up --build -d
	@${COMPOSE} ${DOCKER_FLAGS} ${DOCKER_FILE} ps

debug:
	${COMPOSE} ${DOCKER_FLAGS} ${DOCKER_FILE} up --build

info:
	@${DOCKER} images
	@${COMPOSE} ${DOCKER_FLAGS} ${DOCKER_FILE} ps

clean:
	${COMPOSE} ${DOCKER_FLAGS} ${DOCKER_FILE} down --rmi all

fclean: clean
	${DOCKER} system prune -f

re: fclean all

rm volume:
	@rm -rf ../data/

.PHONY = all clean fclean re
