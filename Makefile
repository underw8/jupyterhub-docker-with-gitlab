include .env

build_jupyterhub:
	[ ! -d "${JUPYTERHUB_HOME}/home" ] && mkdir -p ${JUPYTERHUB_HOME}/home || true
	@docker-compose -f docker-compose.yml up --force-recreate --build -d

stop_jupyterhub:
	@docker-compose -f docker-compose.yml down
