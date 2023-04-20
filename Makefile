NAME = inception

DOCKER = docker
COMPOSE = docker-compose
DOCKER_FLAGS = -f
DOCKER_FILE = srcs/docker-compose.yml

all: ${NAME}

${NAME}:
	${COMPOSE} ${DOCKER_FLAGS} ${DOCKER_FILE} up --build -d

debug:
	${COMPOSE} ${DOCKER_FLAGS} ${DOCKER_FILE} up --build

info:
	@${DOCKER} images
	@${COMPOSE} ${DOCKER_FLAGS} ${DOCKER_FILE} ps

clean:
	${COMPOSE} ${DOCKER_FLAGS} ${DOCKER_FILE} down

fclean: clean
	${DOCKER} system prune -f

re: fclean all

.PHONY = all clean fclean re
