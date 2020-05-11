build-all:
	sudo docker-compose build

kill-all:
	sudo docker kill $( docker ps )

up-prod:
	sudo docker-compose up flask_prod

up-non-daemon:
	sudo docker-compose up

run-postgresql:
	sudo docker-compose up -d db_postgreso

start:
	sudo docker-compose start

stop:
	sudo docker-compose stop

restart:
	sudo docker-compose stop && docker-compose start

shell-api-dev:
	docker exec -ti flask_dev /bin/sh

log-api-dev:
	docker-compose logs flask_dev

create-role:
	docker exec db_postgres psql -U postgres -c "CREATE ROLE ${API_DB_USER} LOGIN ENCRYPTED PASSWORD '${API_DB_PASS}' NOSUPERUSER INHERIT CREATEDB NOCREATEROLE NOREPLICATION;"

alter-role:
	docker exec db_postgres psql -U postgres -c "ALTER ROLE ${API_DB_USER} VALID UNTIL 'infinity';"

permission-role:
	docker exec db_postgres psql -U postgres -c "ALTER USER ${API_DB_USER} CREATEDB;"

create-db:
	docker exec db_postgres psql -U postgres -c "CREATE DATABASE ${API_DB_PASS} WITH OWNER = ${API_DB_USER} ENCODING = 'UTF8' TABLESPACE = pg_default LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8' CONNECTION LIMIT = -1 TEMPLATE template0;"

run-dev:
	sudo docker-compose run --service-ports flask_dev